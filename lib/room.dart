import 'package:flutter/material.dart';

enum RoomType {
  livingRoom('Living Room', Icons.living),
  bedroom('Bedroom', Icons.bed),
  kitchen('Kitchen', Icons.kitchen),
  bathroom('Bathroom', Icons.bathroom),
  office('Office', Icons.work),
  diningRoom('Dining Room', Icons.restaurant),
  hallway('Hallway', Icons.door_front_door),
  laundry('Laundry Room', Icons.local_laundry_service);

  final String displayName;
  final IconData icon;

  const RoomType(this.displayName, this.icon);
}

class Room {
  final String id;
  final RoomType type;
  final String name;
  final List<String> designElements;
  final String colorScheme;
  final DateTime createdAt;
  final DateTime updatedAt;

  Room({
    required this.id,
    required this.type,
    required this.name,
    this.designElements = const [],
    this.colorScheme = 'Modern',
    required this.createdAt,
    required this.updatedAt,
  });

  factory Room.create(RoomType type) {
    final now = DateTime.now();
    return Room(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      name: type.displayName,
      createdAt: now,
      updatedAt: now,
    );
  }

  Room copyWith({
    String? id,
    RoomType? type,
    String? name,
    List<String>? designElements,
    String? colorScheme,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Room(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      designElements: designElements ?? this.designElements,
      colorScheme: colorScheme ?? this.colorScheme,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
