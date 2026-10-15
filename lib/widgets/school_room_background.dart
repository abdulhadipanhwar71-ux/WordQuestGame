import 'package:flutter/material.dart';

class SchoolRoomBackground extends StatelessWidget {
  final String classId;
  final Widget child;

  const SchoolRoomBackground({
    Key? key,
    required this.classId,
    required this.child,
  }) : super(key: key);

  List<Color> _getGradients() {
    switch (classId) {
      case 'class_1':
        return [const Color(0xFFE8F5E9), const Color(0xFFC8E6C9)];
      case 'class_2':
        return [const Color(0xFFE3F2FD), const Color(0xFFBBDEFB)];
      case 'class_3':
        return [const Color(0xFFFFF3E0), const Color(0xFFFFE0B2)];
      case 'class_4':
        return [const Color(0xFFF3E5F5), const Color(0xFFE1BEE7)];
      case 'class_5':
        return [const Color(0xFFFCE4EC), const Color(0xFFF8BBD0)];
      default:
        return [const Color(0xFFF4F7FB), const Color(0xFFECEFF1)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getGradients();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
