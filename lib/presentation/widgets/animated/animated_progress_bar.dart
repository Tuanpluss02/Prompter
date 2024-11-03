import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';

/// An animated progress bar that visually reflects progress updates with smooth transitions.
///
/// Ideal for displaying the status of tasks, downloads, uploads, or any process involving advancement.
///  The bar's progress is controlled by the [progress] value, ranging from 0.0 (no progress) to 1.0 (full progress).
///  The animation smoothly updates the bar's fill whenever the [progress] value changes.
///
/// Customize its appearance using parameters like:
/// - [duration]: Controls the animation's speed.
/// - [width]: Sets the bar's width.
/// - [backgroundColor]:  The bar's background color. Defaults to Color(0xFF272A31).
/// - [progressColor]: The color of the filled progress indicator. Defaults to AppColors.yellowFFDC00.
///
/// ## Example
///
///  ```dart
///  AnimatedProgressBar(
///     progress: 0.6, // Represents 60% progress
///     width: 200,     // Sets the width to 200 logical pixels
///  )
///  ```
class AnimatedProgressBar extends StatefulWidget {
  /// The current progress value, ranging from 0.0 (no progress) to 1.0 (full progress).
  final double progress;

  /// The duration of the progress animation. Defaults to 500 milliseconds for a smooth visual transition.
  final Duration duration;

  /// The width of the progress bar, influencing its horizontal footprint within the layout.
  final double width;

  /// The background color of the progress bar, providing a visual base for the progress indicator.
  final Color backgroundColor;

  /// The color dynamically filling the progress bar, visually indicating the level of completion.
  final Color progressColor;

  /// Constructor for the [AnimatedProgressBar] widget.
  const AnimatedProgressBar({
    super.key,
    required this.progress,
    required this.width,
    this.duration = const Duration(milliseconds: 500),
    this.backgroundColor = const Color(0xFF272A31),
    this.progressColor = AppColors.yellowFFDC00,
  });

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

/// The state class managing the animation and visual representation of the progress bar.
class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  /// The animation controller, governing the progress animation and ensuring smooth transitions.
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Initializes the animation controller.
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    // Starts the initial animation to reflect the provided progress value.
    _animateToProgress();
  }

  @override
  void didUpdateWidget(covariant AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Triggers a new animation whenever the progress value is updated.
    if (oldWidget.progress != widget.progress) {
      _animateToProgress();
    }
  }

  /// Animates the progress bar to the current [widget.progress] value.
  void _animateToProgress() {
    _animationController.animateTo(widget.progress);
  }

  @override
  void dispose() {
    // Releases the animation controller resources to prevent memory leaks when the widget is disposed.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Constructs the visual representation of the AnimatedProgressBar.
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // Background container acting as the progress bar track.
        Container(
          width: widget.width,
          height: 6,
          decoration: ShapeDecoration(
            color: widget.backgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        // Animated container representing the filled progress. Its width is driven by the animation.
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              width: _animationController.value * widget.width,
              height: 6,
              decoration: ShapeDecoration(
                color: widget.progressColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
