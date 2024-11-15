import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';

class GradientProgressBar extends StatelessWidget {
  final double progress;
  final double width;
  final double height;

  const GradientProgressBar({super.key, required this.progress, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomPaint(
              size: Size(width, height),
              painter: DiagonalStripePainter(),
            ),
          ),
        ),
        AnimatedPositioned(
          width: width * progress,
          height: height,
          duration: const Duration(milliseconds: 300),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.yellowFFC107,
                    AppColors.purple673AB7,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class DiagonalStripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFA1A1A1)
      ..strokeWidth = 1;

    const stripeSpacing = 8.0;

    for (double i = 0; i < size.width / stripeSpacing; i++) {
      canvas.drawLine(
        Offset(i * stripeSpacing, 0),
        Offset((i + 1) * stripeSpacing, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
