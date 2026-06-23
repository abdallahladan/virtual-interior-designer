import 'package:flutter/material.dart';
import '../room.dart';

class RoomDesignerScreen extends StatefulWidget {
  final Room room;

  const RoomDesignerScreen({super.key, required this.room});

  @override
  State<RoomDesignerScreen> createState() => _RoomDesignerScreenState();
}

class _RoomDesignerScreenState extends State<RoomDesignerScreen> {
  late Room _currentRoom;
  String _selectedColorScheme = 'Modern';
  final List<String> _colorSchemes = [
    'Modern',
    'Classic',
    'Minimalist',
    'Scandinavian',
    'Industrial',
    'Bohemian'
  ];

  @override
  void initState() {
    super.initState();
    _currentRoom = widget.room;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Design ${_currentRoom.name}'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Preview
              _buildRoomPreview(),
              const SizedBox(height: 24),
              
              // Design Options
              Text(
                'Design Style',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              _buildColorSchemeSelector(),
              const SizedBox(height: 24),
              
              // Design Elements
              Text(
                'Design Elements',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              _buildDesignElements(),
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _saveDesign,
                      child: const Text('Save Design'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomPreview() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: _getColorSchemeColor(),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _currentRoom.type.icon,
              size: 64,
              color: Colors.white70,
            ),
            const SizedBox(height: 12),
            Text(
              _currentRoom.name,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSchemeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _colorSchemes.map((scheme) {
          final isSelected = _selectedColorScheme == scheme;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChip(
              selected: isSelected,
              label: Text(scheme),
              onSelected: (selected) {
                setState(() {
                  _selectedColorScheme = scheme;
                  _currentRoom = _currentRoom.copyWith(colorScheme: scheme);
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDesignElements() {
    final designOptions = _getDesignOptionsForRoom();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: designOptions.map((option) {
        final isSelected = _currentRoom.designElements.contains(option);
        return FilterChip(
          selected: isSelected,
          label: Text(option),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _currentRoom.designElements.add(option);
              } else {
                _currentRoom.designElements.remove(option);
              }
              _currentRoom = _currentRoom.copyWith(
                designElements: List.from(_currentRoom.designElements),
              );
            });
          },
        );
      }).toList(),
    );
  }

  List<String> _getDesignOptionsForRoom() {
    switch (_currentRoom.type) {
      case RoomType.livingRoom:
        return ['Sofa', 'Armchair', 'Coffee Table', 'TV Stand', 'Plants', 'Wall Art'];
      case RoomType.bedroom:
        return ['Bed', 'Nightstand', 'Wardrobe', 'Desk', 'Mirror', 'Lighting'];
      case RoomType.kitchen:
        return ['Cabinets', 'Countertop', 'Appliances', 'Island', 'Backsplash', 'Sink'];
      case RoomType.bathroom:
        return ['Vanity', 'Mirror', 'Shower', 'Bathtub', 'Towel Rack', 'Lighting'];
      case RoomType.office:
        return ['Desk', 'Chair', 'Shelves', 'Monitor', 'Lamp', 'Filing Cabinet'];
      case RoomType.diningRoom:
        return ['Table', 'Chairs', 'Sideboard', 'Chandelier', 'Rug', 'Wall Decor'];
      case RoomType.hallway:
        return ['Console Table', 'Mirror', 'Coat Rack', 'Lighting', 'Rug', 'Wall Art'];
      case RoomType.laundry:
        return ['Washer', 'Dryer', 'Storage', 'Sink', 'Ironing Board', 'Shelves'];
    }
  }

  Color _getColorSchemeColor() {
    switch (_selectedColorScheme) {
      case 'Classic':
        return Colors.amber[700]!;
      case 'Minimalist':
        return Colors.grey[600]!;
      case 'Scandinavian':
        return Colors.blue[300]!;
      case 'Industrial':
        return Colors.grey[800]!;
      case 'Bohemian':
        return Colors.orange[400]!;
      case 'Modern':
      default:
        return Colors.deepPurple[400]!;
    }
  }

  void _saveDesign() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Design for ${_currentRoom.name} saved!'),
        duration: const Duration(seconds: 2),
      ),
    );
    // TODO: Save to Firebase
  }
}
