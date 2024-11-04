import 'dart:async';

import 'package:base/app/utils/app_haptics.dart';
import 'package:base/data/responses/ai_image_generated.dart';
import 'package:base/presentation/modules/photo_gallery/widgets/fullscreen_keyboard_listener.dart';
import 'package:base/presentation/widgets/global/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FullscreenUrlImgViewer extends StatefulWidget {
  const FullscreenUrlImgViewer({super.key, required this.aiImages, this.index = 0});
  final List<ImageList> aiImages;
  final int index;

  static const double imageScale = 2.5;

  @override
  State<FullscreenUrlImgViewer> createState() => _FullscreenUrlImgViewerState();
}

class _FullscreenUrlImgViewerState extends State<FullscreenUrlImgViewer> {
  final _isZoomed = ValueNotifier(false);
  late final _controller = PageController(initialPage: widget.index)..addListener(_handlePageChanged);
  late final ValueNotifier<int> _currentPage = ValueNotifier(widget.index);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  void _handleBackPressed() => Navigator.pop(context, _controller.page!.round());

  void _animateToPage(int page) {
    if (page >= 0 || page < widget.aiImages.length) {
      _controller.animateToPage(page, duration: 300.ms, curve: Curves.easeOut);
    }
  }

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
          itemBuilder: (_, index) => _Viewer(widget.aiImages[index].defaultImage?.url ?? '', _isZoomed),
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
          color: Colors.black,
          child: Stack(
            children: [
              Positioned.fill(child: content),
              // Show next/previous btns if there are more than one image
              if (widget.aiImages.length > 1) ...{Text('hehehe')}
            ],
          ),
        ),
      ),
    );
  }
}

class _Viewer extends StatefulWidget {
  const _Viewer(this.url, this.isZoomed);

  final String url;
  final ValueNotifier<bool> isZoomed;

  @override
  State<_Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<_Viewer> with SingleTickerProviderStateMixin {
  final _controller = TransformationController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Reset zoom level to 1 on double-tap
  void _handleDoubleTap() => _controller.value = Matrix4.identity();

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
          tag: widget.url,
          child: AppImage(
            image: NetworkImage(
              widget.url,
            ),
            fit: BoxFit.contain,
            scale: FullscreenUrlImgViewer.imageScale,
            progress: true,
          ),
        ),
      ),
    );
  }
}
