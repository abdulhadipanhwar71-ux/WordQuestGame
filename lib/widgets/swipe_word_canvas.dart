import 'dart:math';
import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../theme/app_colors.dart';

class SwipeWordCanvas extends StatefulWidget {
  final List<String> letters;
  final Function(String word) onWordSubmitted;
  final VoidCallback onShuffle;
  final double size;

  const SwipeWordCanvas({
    Key? key,
    required this.letters,
    required this.onWordSubmitted,
    required this.onShuffle,
    this.size = 280,
  }) : super(key: key);

  @override
  State<SwipeWordCanvas> createState() => _SwipeWordCanvasState();
}

class _SwipeWordCanvasState extends State<SwipeWordCanvas> {
  final List<int> _selectedIndices = [];
  Offset? _currentTouchPos;

  String get _currentWord =>
      _selectedIndices.map((i) => widget.letters[i]).join();

  List<Offset> _getTileCenters(Offset center, double radius) {
    final count = widget.letters.length;
    if (count == 0) return [];
    final centers = <Offset>[];
    for (int i = 0; i < count; i++) {
      // Start from top (-pi / 2)
      final angle = -pi / 2 + (2 * pi * i / count);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      centers.add(Offset(x, y));
    }
    return centers;
  }

  double _getTileRadius() {
    final count = widget.letters.length;
    if (count <= 3) return 34.0;
    if (count == 4) return 32.0;
    if (count == 5) return 29.0;
    return 27.0;
  }

  int? _findHitTile(Offset touchPos, List<Offset> centers, double tileRadius) {
    final hitRadius = tileRadius * 1.35;
    for (int i = 0; i < centers.length; i++) {
      if ((touchPos - centers[i]).distance <= hitRadius) {
        return i;
      }
    }
    return null;
  }

  void _onPanStart(
      DragStartDetails details, List<Offset> centers, double tileRadius) {
    _selectedIndices.clear();
    final hit = _findHitTile(details.localPosition, centers, tileRadius);
    if (hit != null) {
      _selectedIndices.add(hit);
      AudioService.playTileTap();
    }
    setState(() {
      _currentTouchPos = details.localPosition;
    });
  }

  void _onPanUpdate(
      DragUpdateDetails details, List<Offset> centers, double tileRadius) {
    final hit = _findHitTile(details.localPosition, centers, tileRadius);
    if (hit != null) {
      if (!_selectedIndices.contains(hit)) {
        _selectedIndices.add(hit);
        AudioService.playTileConnect();
      } else if (_selectedIndices.length >= 2 &&
          _selectedIndices[_selectedIndices.length - 2] == hit) {
        // Backtracked to previous tile - remove last selected
        _selectedIndices.removeLast();
        AudioService.playTileTap();
      }
    }
    setState(() {
      _currentTouchPos = details.localPosition;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_selectedIndices.isNotEmpty) {
      final formed = _currentWord;
      widget.onWordSubmitted(formed);
    }
    setState(() {
      _selectedIndices.clear();
      _currentTouchPos = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final canvasSize = widget.size;
    final center = Offset(canvasSize / 2, canvasSize / 2);
    final ringRadius = canvasSize * 0.36;
    final tileRadius = _getTileRadius();
    final centers = _getTileCenters(center, ringRadius);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Live Word Preview Banner
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 48,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: _selectedIndices.isNotEmpty
                ? AppColors.primaryBlueDark
                : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _selectedIndices.isNotEmpty
                  ? AppColors.goldCoin
                  : Colors.grey.shade300,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _selectedIndices.isNotEmpty
                    ? AppColors.goldCoin.withOpacity(0.35)
                    : Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_selectedIndices.isEmpty)
                Text(
                  'Swipe across letters to form words',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                )
              else
                Text(
                  _currentWord,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4.0,
                  ),
                ),
            ],
          ),
        ),

        // Circular Touch Pad
        SizedBox(
          width: canvasSize,
          height: canvasSize,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: (d) => _onPanStart(d, centers, tileRadius),
            onPanUpdate: (d) => _onPanUpdate(d, centers, tileRadius),
            onPanEnd: _onPanEnd,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Wheel outer decorative ring
                Container(
                  width: canvasSize,
                  height: canvasSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.4),
                    border: Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.2),
                      width: 8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),

                // Center Shuffle Button
                Center(
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 4,
                    shadowColor: AppColors.primaryBlue.withOpacity(0.3),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        AudioService.playTileTap();
                        widget.onShuffle();
                      },
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.primaryBlue.withOpacity(0.4),
                              width: 1.5),
                        ),
                        child: const Icon(
                          Icons.shuffle_rounded,
                          color: AppColors.primaryBlue,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ),

                // Line Drawing Canvas
                CustomPaint(
                  size: Size(canvasSize, canvasSize),
                  painter: _SwipeLinePainter(
                    selectedCenters:
                        _selectedIndices.map((i) => centers[i]).toList(),
                    currentTouchPos: _currentTouchPos,
                  ),
                ),

                // Render Circular Letter Badges
                ...List.generate(centers.length, (index) {
                  final centerPos = centers[index];
                  final isSelected = _selectedIndices.contains(index);
                  final selectionOrder = _selectedIndices.indexOf(index);
                  final letter = widget.letters[index];

                  return Positioned(
                    left: centerPos.dx - tileRadius,
                    top: centerPos.dy - tileRadius,
                    child: AnimatedScale(
                      scale: isSelected ? 1.15 : 1.0,
                      duration: const Duration(milliseconds: 120),
                      curve: Curves.easeOutBack,
                      child: Container(
                        width: tileRadius * 2,
                        height: tileRadius * 2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: isSelected
                                ? [AppColors.goldCoin, const Color(0xFFFFA000)]
                                : [Colors.white, const Color(0xFFF0F4F8)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: isSelected
                                ? Colors.white
                                : AppColors.primaryBlue.withOpacity(0.35),
                            width: isSelected ? 3.0 : 2.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? AppColors.goldCoin.withOpacity(0.6)
                                  : Colors.black.withOpacity(0.12),
                              blurRadius: isSelected ? 10 : 5,
                              offset: Offset(0, isSelected ? 2 : 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              letter,
                              style: TextStyle(
                                fontSize: tileRadius * 0.95,
                                fontWeight: FontWeight.w900,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.primaryBlueDark,
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 2,
                                right: 2,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryBlueDark,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${selectionOrder + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SwipeLinePainter extends CustomPainter {
  final List<Offset> selectedCenters;
  final Offset? currentTouchPos;

  _SwipeLinePainter({
    required this.selectedCenters,
    required this.currentTouchPos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (selectedCenters.isEmpty) return;

    final path = Path();
    path.moveTo(selectedCenters.first.dx, selectedCenters.first.dy);

    for (int i = 1; i < selectedCenters.length; i++) {
      path.lineTo(selectedCenters[i].dx, selectedCenters[i].dy);
    }

    if (currentTouchPos != null) {
      path.lineTo(currentTouchPos!.dx, currentTouchPos!.dy);
    }

    // Outer glow line
    final glowPaint = Paint()
      ..color = AppColors.goldCoin.withOpacity(0.4)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Solid core line
    final linePaint = Paint()
      ..color = AppColors.goldCoin
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _SwipeLinePainter oldDelegate) {
    return true;
  }
}
