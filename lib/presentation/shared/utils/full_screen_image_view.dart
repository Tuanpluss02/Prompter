import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

enum DisposeLevel { high, medium, low }

class FullScreenPage extends StatefulWidget {
  final Widget child;
  final String imageUrl;
  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel disposeLevel;
  const FullScreenPage({
    super.key,
    required this.child,
    required this.imageUrl,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    this.disposeLevel = DisposeLevel.medium,
  });

  @override
  State<FullScreenPage> createState() => _FullScreenPageState();
}

class FullScreenWidget extends StatelessWidget {
  final Widget child;
  final String imageUrl;
  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel disposeLevel;
  const FullScreenWidget({
    super.key,
    required this.child,
    required this.imageUrl,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    required this.disposeLevel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false,
                barrierColor: backgroundIsTransparent ? Colors.white.withOpacity(0) : backgroundColor,
                pageBuilder: (BuildContext context, _, __) {
                  return FullScreenPage(
                    imageUrl: imageUrl,
                    backgroundColor: backgroundColor,
                    backgroundIsTransparent: backgroundIsTransparent,
                    disposeLevel: disposeLevel,
                    child: child,
                  );
                }));
      },
      child: child,
    );
  }
}

class _ActionSheet extends StatelessWidget {
  final String imageUrl;
  const _ActionSheet(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    // You can use PopScope to handle the swipe-to-dismiss gestures, as well as
    // the system back gestures and tapping on the barrier, all in one place.
    return DraggableSheet(
      // minPosition: const SheetAnchor.proportional(0.5),
      child: Card(
        color: Color(0xff2c2c2c),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15),
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xff363636),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GestureDetector(
                onTap: () {
                  ImageUtils.saveImageToGallery(imageUrl: imageUrl);
                },
                child: ListTile(
                  trailing: SvgPicture.asset(SvgPath.icImageDownload),
                  title: Text(
                    'Download',
                    style: AppTextStyles.s18w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class _FullScreenPageState extends State<FullScreenPage> {
  double initialPositionY = 0;

  double currentPositionY = 0;

  double positionYDelta = 0;

  double opacity = 1;

  double disposeLimit = 150;

  Duration animationDuration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundIsTransparent ? Colors.transparent : widget.backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragStart: (details) => _startVerticalDrag(details),
          onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
          onVerticalDragEnd: (details) => _endVerticalDrag(details),
          onLongPress: () {
            final modalRoute = ModalSheetRoute(
              // Enable the swipe-to-dismiss behavior.
              swipeDismissible: true,
              // Use `SwipeDismissSensitivity` to tweak the sensitivity of the swipe-to-dismiss behavior.
              swipeDismissSensitivity: const SwipeDismissSensitivity(
                minFlingVelocityRatio: 2.0,
                minDragDistance: 200.0,
              ),
              builder: (context) => _ActionSheet(widget.imageUrl),
            );

            Navigator.push(context, modalRoute);
          },
          child: Container(
            color: widget.backgroundColor.withOpacity(opacity),
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: animationDuration,
                  curve: Curves.fastOutSlowIn,
                  top: 0 + positionYDelta,
                  bottom: 0 - positionYDelta,
                  left: 0,
                  right: 0,
                  child: widget.child,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setDisposeLevel();
  }

  setDisposeLevel() {
    setState(() {
      if (widget.disposeLevel == DisposeLevel.high) {
        disposeLimit = 300;
      } else if (widget.disposeLevel == DisposeLevel.medium) {
        disposeLimit = 200;
      } else {
        disposeLimit = 100;
      }
    });
  }

  setOpacity() {
    double tmp = positionYDelta < 0 ? 1 - ((positionYDelta / 1000) * -1) : 1 - (positionYDelta / 1000);

    if (tmp > 1) {
      opacity = 1;
    } else if (tmp < 0) {
      opacity = 0;
    } else {
      opacity = tmp;
    }

    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      opacity = 0.5;
    }
  }

  _endVerticalDrag(DragEndDetails details) {
    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        animationDuration = Duration(milliseconds: 300);
        opacity = 1;
        positionYDelta = 0;
      });

      Future.delayed(animationDuration).then((_) {
        setState(() {
          animationDuration = Duration.zero;
        });
      });
    }
  }

  void _startVerticalDrag(details) {
    setState(() {
      initialPositionY = details.globalPosition.dy;
    });
  }

  void _whileVerticalDrag(details) {
    setState(() {
      currentPositionY = details.globalPosition.dy;
      positionYDelta = currentPositionY - initialPositionY;
      setOpacity();
    });
  }
}
