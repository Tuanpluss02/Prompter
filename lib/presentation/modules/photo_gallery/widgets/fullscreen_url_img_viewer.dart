import 'dart:async';

import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_color.dart';
import 'package:base/common/utils/app_haptics.dart';
import 'package:base/domain/data/responses/ai_image_generated.dart';
import 'package:base/presentation/modules/ai_chat/ai_chat_binding.dart';
import 'package:base/presentation/modules/photo_gallery/widgets/fullscreen_keyboard_listener.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/global/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FullscreenUrlImgViewer extends StatefulWidget {
  static const double imageScale = 2.5;
  final List<ImageList> aiImages;
  final int index;

  const FullscreenUrlImgViewer({super.key, required this.aiImages, this.index = 0});

  @override
  State<FullscreenUrlImgViewer> createState() => _FullscreenUrlImgViewerState();
}

class _FullscreenUrlImgViewerState extends State<FullscreenUrlImgViewer> {
  final _isZoomed = ValueNotifier(false);
  late final _controller = PageController(initialPage: widget.index)..addListener(_handlePageChanged);
  late final ValueNotifier<int> _currentPage = ValueNotifier(widget.index);

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedBuilder(
      animation: _isZoomed,
      builder: (_, __) {
        final bool enableSwipe = !_isZoomed.value && widget.aiImages.length > 1;
        return PageView.builder(
          physics: enableSwipe ? PageScrollPhysics() : NeverScrollableScrollPhysics(),
          controller: _controller,
          itemCount: widget.aiImages.length,
          itemBuilder: (_, index) => _Viewer(widget.aiImages[index], _isZoomed),
          onPageChanged: (_) => AppHaptics.lightImpact(),
        );
      },
    );

    content = Semantics(
      label: 'Fullscreen image viewer',
      container: true,
      image: true,
      child: ExcludeSemantics(child: content),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && context.mounted) {
          _handleBackPressed();
        }
      },
      child: FullscreenKeyboardListener(
        onKeyDown: _handleKeyDown,
        child: Container(
          color: AppColors.backgroundColor,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                    child: Column(
                  children: [
                    Expanded(child: content),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildTools(),
                            SizedBox(height: 10),
                            _buildDescription(),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
                Positioned(
                  top: 10,
                  right: 5,
                  child: GestureDetector(
                    onTap: _handleBackPressed,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: ShapeDecoration(color: Color(0x8024262B), shape: CircleBorder()),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0x8024262B),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                              onPressed: () {
                                _animateToPage(_currentPage.value - 1);
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.aiChat, arguments: AiChatPageData(prompt: widget.aiImages[_currentPage.value].prompt));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(SvgPath.icPen, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                                SizedBox(width: 5),
                                Text('Remix'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0x8024262B),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                              onPressed: () {
                                _animateToPage(_currentPage.value + 1);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // }
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    if (page >= 0 || page < widget.aiImages.length) {
      _controller.animateToPage(page, duration: 300.ms, curve: Curves.easeOut);
    }
  }

  _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0x8024262B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(SvgPath.icinputing, colorFilter: const ColorFilter.mode(Color(0xffc1c2c5), BlendMode.srcIn)),
              SizedBox(width: 5),
              Text('Prompt', style: GoogleFonts.manrope(color: Color(0xffc1c2c5), fontSize: 20)),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: widget.aiImages[_currentPage.value].prompt ?? ''));
                  Fluttertoast.showToast(
                    msg: "Copied to clipboard",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                child: Icon(
                  Icons.copy,
                  color: Color(0xffc1c2c5),
                  size: 20,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          ValueListenableBuilder(
              valueListenable: _currentPage,
              builder: (context, value, child) {
                return SelectableText(widget.aiImages[_currentPage.value].prompt ?? "", style: GoogleFonts.manrope(color: Colors.white, fontSize: 16));
              }),
        ],
      ),
    );
  }

  _buildTools() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0x8024262B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(SvgPath.icBubble, colorFilter: const ColorFilter.mode(Color(0xffc1c2c5), BlendMode.srcIn)),
              SizedBox(width: 5),
              Text('Tools', style: GoogleFonts.manrope(color: Color(0xffc1c2c5), fontSize: 20)),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Color.fromARGB(20, 113, 194, 25),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Color.fromARGB(20, 113, 194, 25), width: 1),
            ),
            child: Text(
              'CiciAI'.toUpperCase(),
              style: GoogleFonts.poppins(color: Color(0xffA5D8FF), fontWeight: FontWeight.bold, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }

  void _handleBackPressed() => Navigator.pop(context, _controller.page!.round());

  bool _handleKeyDown(KeyDownEvent event) {
    int dir = 0;
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      dir = -1;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      dir = 1;
    }
    if (dir != 0) {
      final focus = FocusManager.instance.primaryFocus;
      _animateToPage(_currentPage.value + dir);
      scheduleMicrotask(() {
        focus?.requestFocus();
      });
      return true;
    }
    return false;
  }

  void _handlePageChanged() => _currentPage.value = _controller.page!.round();
}

class _Viewer extends StatefulWidget {
  final ImageList ins;

  final ValueNotifier<bool> isZoomed;
  const _Viewer(this.ins, this.isZoomed);

  @override
  State<_Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<_Viewer> with SingleTickerProviderStateMixin {
  final _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        transformationController: _controller,
        onInteractionEnd: (_) => widget.isZoomed.value = _controller.value.getMaxScaleOnAxis() > 1,
        minScale: 1,
        maxScale: 5,
        child: Hero(
          tag: widget.ins.defaultImage?.url ?? '',
          child: AppImage(
            image: NetworkImage(
              widget.ins.defaultImage?.url ?? '',
            ),
            fit: BoxFit.contain,
            scale: FullscreenUrlImgViewer.imageScale,
            progress: true,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Reset zoom level to 1 on double-tap
  void _handleDoubleTap() => _controller.value = Matrix4.identity();
}
