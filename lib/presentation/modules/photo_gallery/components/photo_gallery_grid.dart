import 'dart:async';
import 'dart:math';

import 'package:base/app/utils/app_haptics.dart';
import 'package:base/data/responses/ai_image_generated.dart';
import 'package:base/presentation/modules/photo_gallery/widgets/app_loading_indicator.dart';
import 'package:base/presentation/modules/photo_gallery/widgets/buttons.dart';
import 'package:base/presentation/modules/photo_gallery/widgets/eight_way_swipe_detector.dart';
import 'package:base/presentation/modules/photo_gallery/widgets/fullscreen_keyboard_listener.dart';
import 'package:base/presentation/modules/photo_gallery/widgets/fullscreen_url_img_viewer.dart';
import 'package:base/presentation/modules/photo_gallery/widgets/unsplash_photo.dart';
import 'package:base/presentation/widgets/global/app_logic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sized_context/sized_context.dart';

part '../widgets/_animated_cutout_overlay.dart';

class PhotoGalleryGrid extends StatefulWidget {
  const PhotoGalleryGrid({super.key, this.imageSize, required this.aiImages});
  final Size? imageSize;
  final List<ImageList> aiImages;

  @override
  State<PhotoGalleryGrid> createState() => _PhotoGalleryGridState();
}

class _PhotoGalleryGridState extends State<PhotoGalleryGrid> {
  static const int _gridSize = 5;
  // Index starts in the middle of the grid (eg, 25 items, index will start at 13)
  int _index = ((_gridSize * _gridSize) / 2).round();
  Offset _lastSwipeDir = Offset.zero;
  final double _scale = 1;
  bool _skipNextOffsetTween = false;
  late Duration swipeDuration = Duration(milliseconds: 600) * .4;
  int get _imgCount => pow(_gridSize, 2).round();

  late final List<FocusNode> _focusNodes = List.generate(_imgCount, (index) => FocusNode());

  final bool useClipPathWorkAroundForWeb = kIsWeb;

  @override
  void initState() {
    super.initState();
    _focusNodes[_index].requestFocus();
  }

  void _setIndex(int value, {bool skipAnimation = false}) {
    if (value < 0 || value >= _imgCount) return;
    _skipNextOffsetTween = skipAnimation;
    setState(() => _index = value);
    _focusNodes[value].requestFocus();
  }

  /// Determine the required offset to show the current selected index.
  /// index=0 is top-left, and the index=max is bottom-right.
  Offset _calculateCurrentOffset(double padding, Size size) {
    double halfCount = (_gridSize / 2).floorToDouble();
    Size paddedImageSize = Size(size.width + padding, size.height + padding);
    // Get the starting offset that would show the top-left image (index 0)
    final originOffset = Offset(halfCount * paddedImageSize.width, halfCount * paddedImageSize.height);
    // Add the offset for the row/col
    int col = _index % _gridSize;
    int row = (_index / _gridSize).floor();
    final indexedOffset = Offset(-paddedImageSize.width * col, -paddedImageSize.height * row);
    return originOffset + indexedOffset;
  }

  bool _handleKeyDown(KeyDownEvent event) {
    final key = event.logicalKey;
    Map<LogicalKeyboardKey, int> keyActions = {
      LogicalKeyboardKey.arrowUp: -_gridSize,
      LogicalKeyboardKey.arrowDown: _gridSize,
      LogicalKeyboardKey.arrowRight: 1,
      LogicalKeyboardKey.arrowLeft: -1,
    };

    // Apply key action, exit early if no action is defined
    int? actionValue = keyActions[key];
    if (actionValue == null) return false;
    int newIndex = _index + actionValue;

    // Block actions along edges of the grid
    bool isRightSide = _index % _gridSize == _gridSize - 1;
    bool isLeftSide = _index % _gridSize == 0;
    bool outOfBounds = newIndex < 0 || newIndex >= _imgCount;
    if ((isRightSide && key == LogicalKeyboardKey.arrowRight) || (isLeftSide && key == LogicalKeyboardKey.arrowLeft) || outOfBounds) {
      return false;
    }
    _setIndex(newIndex);
    return true;
  }

  /// Converts a swipe direction into a new index
  void _handleSwipe(Offset dir) {
    // Calculate new index, y swipes move by an entire row, x swipes move one index at a time
    int newIndex = _index;
    if (dir.dy != 0) newIndex += _gridSize * (dir.dy > 0 ? -1 : 1);
    if (dir.dx != 0) newIndex += (dir.dx > 0 ? -1 : 1);
    // After calculating new index, exit early if we don't like it...
    if (newIndex < 0 || newIndex > _imgCount - 1) {
      return; // keep the index in range
    }
    if (dir.dx < 0 && newIndex % _gridSize == 0) {
      return; // prevent right-swipe when at right side
    }
    if (dir.dx > 0 && newIndex % _gridSize == _gridSize - 1) {
      return; // prevent left-swipe when at left side
    }
    _lastSwipeDir = dir;
    AppHaptics.lightImpact();
    _setIndex(newIndex);
  }

  Future<void> _handleImageTapped(int index, bool isSelected) async {
    if (_index == index) {
      int? newIndex = await AppLogic().showFullscreenDialogRoute(
        context,
        FullscreenUrlImgViewer(aiImages: widget.aiImages, index: _index),
      );
      if (newIndex != null) {
        _setIndex(newIndex, skipAnimation: true);
      }
    } else {
      _setIndex(index);
    }
  }

  void _handleImageFocusChanged(int index, bool isFocused) {
    if (isFocused) {
      _setIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FullscreenKeyboardListener(
      onKeyDown: _handleKeyDown,
      child: Builder(builder: (context) {
        if (widget.aiImages.isEmpty) {
          return Center(child: AppLoadingIndicator());
        }
        // Size imgSize = widget.imageSize ?? Size.square(context.widthPx / _gridSize);
        Size imgSize = widget.imageSize ?? Size(context.widthPx * 0.7, context.heightPx * 0.6);
        imgSize = (widget.imageSize ?? imgSize) * _scale;
        // Get transform offset for the current _index
        final padding = 16.0;
        var gridOffset = _calculateCurrentOffset(padding, imgSize);
        gridOffset += Offset(0, -context.mq.padding.top / 2);
        final offsetTweenDuration = _skipNextOffsetTween ? Duration.zero : swipeDuration;
        final cutoutTweenDuration = _skipNextOffsetTween ? Duration.zero : swipeDuration * .5;
        return _AnimatedCutoutOverlay(
          animationKey: ValueKey(_index),
          cutoutSize: imgSize,
          swipeDir: _lastSwipeDir,
          duration: cutoutTweenDuration,
          opacity: _scale == 1 ? .7 : .5,
          enabled: useClipPathWorkAroundForWeb == false,
          child: SafeArea(
            bottom: false,
            // Place content in overflow box, to allow it to flow outside the parent
            child: OverflowBox(
              maxWidth: _gridSize * imgSize.width + padding * (_gridSize - 1),
              maxHeight: _gridSize * imgSize.height + padding * (_gridSize - 1),
              alignment: Alignment.center,
              // Detect swipes in order to change index
              child: EightWaySwipeDetector(
                onSwipe: _handleSwipe,
                threshold: 30,
                // A tween animation builder moves from image to image based on current offset
                child: TweenAnimationBuilder<Offset>(
                  tween: Tween(begin: gridOffset, end: gridOffset),
                  duration: offsetTweenDuration,
                  curve: Curves.easeOut,
                  builder: (_, value, child) => Transform.translate(offset: value, child: child),
                  child: FocusTraversalGroup(
                    //policy: OrderedTraversalPolicy(),
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: _gridSize,
                      childAspectRatio: imgSize.aspectRatio,
                      mainAxisSpacing: padding,
                      crossAxisSpacing: padding,
                      children: List.generate(_imgCount, (i) => _buildImage(i, swipeDuration, imgSize)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildImage(int index, Duration swipeDuration, Size imgSize) {
    /// Bind to collectibles.statesById because we might need to rebuild if a collectible is found.
    return FocusTraversalOrder(
      order: NumericFocusOrder(index.toDouble()),
      child: Builder(builder: (context) {
        bool isSelected = index == _index;
        final imgUrl = widget.aiImages[index].defaultImage?.url ?? '';

        final photoWidget = TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeOut,
          tween: Tween(begin: 1, end: isSelected ? 1.15 : 1),
          builder: (_, value, child) => Transform.scale(scale: value, child: child),
          child: PhotoDisplay(
            imgUrl,
            fit: BoxFit.cover,
          ).animate().fade(),
        );

        return MergeSemantics(
          child: Semantics(
            focused: isSelected,
            image: true,
            liveRegion: isSelected,
            onIncrease: () => _handleImageTapped(_index + 1, false),
            onDecrease: () => _handleImageTapped(_index - 1, false),
            child: AppBtn.basic(
              semanticLabel: 'Image $index',
              focusNode: _focusNodes[index],
              onFocusChanged: (isFocused) => _handleImageFocusChanged(index, isFocused),
              onPressed: () => _handleImageTapped(index, isSelected),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: imgSize.width,
                  height: imgSize.height,
                  child: (useClipPathWorkAroundForWeb == false)
                      ? photoWidget
                      : Stack(
                          children: [
                            photoWidget,
                            // Because the web platform doesn't support clipPath, we use a workaround to highlight the selected image
                            Positioned.fill(
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 600),
                                opacity: isSelected ? 0 : .7,
                                child: ColoredBox(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
