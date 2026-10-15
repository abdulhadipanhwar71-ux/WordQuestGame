import 'package:flutter/material.dart';

class SchoolClass {
  final String id;
  final String name;
  final String titleUrdu;
  final String roomName;
  final String description;
  final int startLevel;
  final int endLevel;
  final IconData icon;
  final List<Color> themeColors;

  const SchoolClass({
    required this.id,
    required this.name,
    required this.titleUrdu,
    required this.roomName,
    required this.description,
    required this.startLevel,
    required this.endLevel,
    required this.icon,
    required this.themeColors,
  });

  static const List<SchoolClass> all = [
    SchoolClass(
      id: 'class_1',
      name: 'Class 1: Beginner',
      titleUrdu: 'درجہ اول: ابتدائی',
      roomName: 'Classroom 101',
      description: 'Foundations of reading and 3 to 4-letter words.',
      startLevel: 1,
      endLevel: 10,
      icon: Icons.child_care_rounded,
      themeColors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
    ),
    SchoolClass(
      id: 'class_2',
      name: 'Class 2: Explorer',
      titleUrdu: 'درجہ دوم: کھوجی',
      roomName: 'School Library',
      description: 'Explore books and 4-letter puzzles in the library.',
      startLevel: 11,
      endLevel: 20,
      icon: Icons.menu_book_rounded,
      themeColors: [Color(0xFF2196F3), Color(0xFF1565C0)],
    ),
    SchoolClass(
      id: 'class_3',
      name: 'Class 3: Word Builder',
      titleUrdu: 'درجہ سوم: معمار',
      roomName: 'Science Lab',
      description: 'Construct 4 and 5-letter compounds in science.',
      startLevel: 21,
      endLevel: 30,
      icon: Icons.biotech_rounded,
      themeColors: [Color(0xFFFF9800), Color(0xFFE65100)],
    ),
    SchoolClass(
      id: 'class_4',
      name: 'Class 4: Scholar',
      titleUrdu: 'درجہ چہارم: عالم',
      roomName: 'Language Lab',
      description: 'Master advanced 5-letter vocabulary and anagrams.',
      startLevel: 31,
      endLevel: 40,
      icon: Icons.psychology_rounded,
      themeColors: [Color(0xFF9C27B0), Color(0xFF6A1B9A)],
    ),
    SchoolClass(
      id: 'class_5',
      name: 'Class 5: Master',
      titleUrdu: 'درجہ پنجم: ماہر',
      roomName: 'Grand Auditorium',
      description: 'The pinnacle of Word School: 5 and 6-letter masterworks.',
      startLevel: 41,
      endLevel: 50,
      icon: Icons.workspace_premium_rounded,
      themeColors: [Color(0xFFE91E63), Color(0xFF880E4F)],
    ),
  ];
}
