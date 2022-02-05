import 'package:flutter/cupertino.dart';
import 'package:zflutter/zflutter.dart';

class ZGesture extends StatefulWidget {
  final Widget child;
  final double? maxXRotation;
  final double? initialXRotation;
  final double? initialYRotation;
  final Function(double)? onYRotationUpdate;
  final bool returnToIdleState;
  final ZVector idleState;

  const ZGesture({
    Key? key,
    required this.child,
    this.maxXRotation,
    this.onYRotationUpdate,
    this.initialXRotation,
    this.initialYRotation,
    this.returnToIdleState = false,
    this.idleState = ZVector.zero,
  }) : super(key: key);

  @override
  _ZGestureState createState() => _ZGestureState();
}

class _ZGestureState extends State<ZGesture> with TickerProviderStateMixin {
  double _xRotation = 0.0;
  double _yRotation = 0.0;

  late Animation<double> _idleAnimationVertical;
  late final AnimationController _idleControllerVertical;
  late final CurvedAnimation _idleCurveVertical;

  late Animation<double> _idleAnimationHorizontal;
  late final AnimationController _idleControllerHorizontal;
  late final CurvedAnimation _idleCurveHorizontal;

  @override
  void initState() {
    super.initState();
    _idleControllerVertical = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 500));
    _idleCurveVertical = CurvedAnimation(
        parent: _idleControllerVertical,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn);
    _idleAnimationVertical =
        Tween<double>(begin: 0, end: 0).animate(_idleCurveVertical);

    _idleControllerHorizontal = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 500));
    _idleCurveHorizontal = CurvedAnimation(
        parent: _idleControllerHorizontal,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn);
    _idleAnimationHorizontal =
        Tween<double>(begin: 0, end: 0).animate(_idleCurveHorizontal);

    if (widget.initialXRotation != null) {
      _xRotation += widget.initialXRotation!;
    }
    if (widget.initialYRotation != null) {
      _yRotation += widget.initialYRotation!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanUpdate: (val) {
          if ((_idleAnimationVertical.isCompleted ||
                  _idleAnimationVertical.isDismissed) &&
              (_idleAnimationHorizontal.isCompleted ||
                  _idleAnimationHorizontal.isDismissed)) {
            setState(() {
              if (widget.maxXRotation != null) {
                if (((_xRotation - (val.delta.dy / 100)) >
                        -widget.maxXRotation!) &&
                    ((_xRotation - (val.delta.dy / 100)) <
                        widget.maxXRotation!)) {
                  _xRotation -= val.delta.dy / 100;
                }
              }
              _yRotation -= val.delta.dx / 100;
            });
          }
        },
        onPanStart: (val) {
          if (widget.returnToIdleState) {
            _idleControllerVertical.stop();
            _idleControllerVertical.stop();
          }
        },
        onPanEnd: (details) {
          widget.onYRotationUpdate?.call(_yRotation % tau);
          if (widget.returnToIdleState) {
            _idleAnimationVertical =
                Tween<double>(begin: 0, end: _xRotation - widget.idleState.x!)
                    .animate(_idleControllerVertical);
            _idleAnimationHorizontal =
                Tween<double>(begin: 0, end: _yRotation + widget.idleState.y!)
                    .animate(_idleControllerHorizontal);
            _idleControllerVertical.reset();
            _idleControllerHorizontal.reset();
            _idleControllerVertical.forward().then((val) {
              _idleControllerVertical.reset();
              _xRotation = widget.idleState.x!;
            });
            _idleControllerHorizontal.forward().then((val) {
              _idleControllerHorizontal.reset();
              _yRotation = widget.idleState.y!;
            });
          }
        },
        child: AnimatedBuilder(
          animation: _idleAnimationVertical,
          builder: (context, child) {
            return AnimatedBuilder(
              animation: _idleAnimationHorizontal,
              builder: (BuildContext context, Widget? _) {
                return ZIllustration(
                  children: [
                    ZPositioned(
                        rotate: ZVector.only(
                          y: _yRotation - _idleAnimationHorizontal.value,
                          x: _xRotation - _idleAnimationVertical.value,
                        ),
                        child: child!)
                  ],
                );
              },
            );
          },
          child: widget.child,
        ));
  }
}
