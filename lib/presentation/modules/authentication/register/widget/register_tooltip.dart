import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/presentation/widgets/highlighted_text.dart';

class RegisterTooltip extends StatelessWidget {
  const RegisterTooltip({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(
              top: 10), // khoảng cách để mũi tên nằm trên Container
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // màu đen mờ hơn
                blurRadius: 16, // độ mở rộng của bóng lớn hơn
                spreadRadius: 4, // độ rộng của bóng lớn hơn
                offset: const Offset(0, 0), // vị trí bóng đổ
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: HighlightedText(
            text: tr(LocaleKeys.enterYourFullNameToContinue),
            highlights: [tr(LocaleKeys.fullName)],
            height: null,
          ),
        ),
        Positioned(
          top: 0,
          child: CustomPaint(
            size: const Size(16, 10), // kích thước của mũi tên
            painter: CustomStyleArrow(),
          ),
        ),
      ],
    );
  }
}

class CustomStyleArrow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Path trianglePath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();

    // Vẽ mũi tên mà không đổ bóng
    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
