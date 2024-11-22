import 'package:flutter/material.dart';

enum DisposeLevel { high, medium, low }

class FullScreenPage extends StatefulWidget {
  final Widget child;

  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel disposeLevel;
  const FullScreenPage({
    super.key,
    required this.child,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    this.disposeLevel = DisposeLevel.medium,
  });

  @override
  State<FullScreenPage> createState() => _FullScreenPageState();
}

class FullScreenWidget extends StatelessWidget {
  final Widget child;

  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel disposeLevel;
  const FullScreenWidget({
    super.key,
    required this.child,
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
