import 'dart:math';
import 'package:flutter/material.dart';

class FallingPetalsOverlay extends StatefulWidget {
  final Widget child;
  final bool isEnabled;

  const FallingPetalsOverlay({
    Key? key,
    required this.child,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<FallingPetalsOverlay> createState() => _FallingPetalsOverlayState();
}

class _FallingPetalsOverlayState extends State<FallingPetalsOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Petal> _petals = [];
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _initPetals();
  }

  void _initPetals() {
    _petals.clear();
    final colors = [
      const Color(0xFFFF80AB), // Pink rose
      const Color(0xFFFF4081), // Deep pink
      const Color(0xFFFFD54F), // Golden petal
      const Color(0xFFBA68C8), // Orchid purple
      const Color(0xFF81C784), // Mint leaf
      const Color(0xFFFF8A80), // Coral
    ];

    for (int i = 0; i < 35; i++) {
      _petals.add(_Petal(
        x: _rnd.nextDouble(),
        y: _rnd.nextDouble() * 1.5 - 0.5,
        size: 10 + _rnd.nextDouble() * 14,
        speed: 0.15 + _rnd.nextDouble() * 0.25,
        driftSpeed: 1.0 + _rnd.nextDouble() * 2.0,
        driftAmplitude: 0.04 + _rnd.nextDouble() * 0.06,
        rotationSpeed: (_rnd.nextDouble() - 0.5) * 4,
        color: colors[_rnd.nextInt(colors.length)],
        phase: _rnd.nextDouble() * 2 * pi,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEnabled) {
      return widget.child;
    }

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _PetalsPainter(
                    petals: _petals,
                    progress: _controller.value,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _Petal {
  double x;
  double y;
  final double size;
  final double speed;
  final double driftSpeed;
  final double driftAmplitude;
  final double rotationSpeed;
  final Color color;
  final double phase;

  _Petal({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.driftSpeed,
    required this.driftAmplitude,
    required this.rotationSpeed,
    required this.color,
    required this.phase,
  });
}

class _PetalsPainter extends CustomPainter {
  final List<_Petal> petals;
  final double progress;

  _PetalsPainter({
    required this.petals,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in petals) {
      // Current Y position falling downwards
      final currentY = ((p.y + progress * p.speed * 4) % 1.2) - 0.1;
      final actualY = currentY * size.height;

      // Gentle swaying horizontal drift
      final sway =
          sin(p.phase + progress * 2 * pi * p.driftSpeed) * p.driftAmplitude;
      final actualX = ((p.x + sway) % 1.0) * size.width;

      final paint = Paint()
        ..color = p.color.withOpacity(0.85)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(actualX, actualY);
      canvas.rotate(p.phase + progress * 2 * pi * p.rotationSpeed);

      // Draw graceful flower petal shape
      final path = Path();
      path.moveTo(0, -p.size);
      path.quadraticBezierTo(p.size * 0.7, -p.size * 0.4, 0, p.size);
      path.quadraticBezierTo(-p.size * 0.7, -p.size * 0.4, 0, -p.size);
      path.close();

      canvas.drawPath(path, paint);

      // Draw petal center vein highlight
      final veinPaint = Paint()
        ..color = Colors.white.withOpacity(0.4)
        ..strokeWidth = 1.2
        ..style = PaintingStyle.stroke;
      canvas.drawLine(
          Offset(0, -p.size * 0.6), Offset(0, p.size * 0.4), veinPaint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _PetalsPainter oldDelegate) => true;
}
