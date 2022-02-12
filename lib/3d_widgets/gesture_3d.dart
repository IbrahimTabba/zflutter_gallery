import 'package:flutter/cupertino.dart';
import 'package:zflutter/zflutter.dart';

class ZGesture extends StatefulWidget {
  final Widget child;
  final double? maxXRotation;
  final double? initialXRotation;
  final double? initialYRotation;
  final double yRotationOffset;
  final Function(double)? onYRotationUpdate;
  final bool returnToIdleState;
  final ZVector idleState;
  final Duration? returnToIdleStateDelay;
  final Widget? topLayer;

  const ZGesture({
    Key? key,
    required this.child,
    this.maxXRotation,
    this.onYRotationUpdate,
    this.initialXRotation,
    this.initialYRotation,
    this.returnToIdleState = false,
    this.idleState = ZVector.zero,
    this.yRotationOffset = 0,
    this.returnToIdleStateDelay,
    this.topLayer,

  }) : super(key: key);

  @override
  _ZGestureState createState() => _ZGestureState();
}

class _ZGestureState extends State<ZGesture> with TickerProviderStateMixin {
  double _xRotation = 0.0;
  double _yRotation = 0.0;

  late Animation<double> _idleAnimationVertical;
  late final AnimationController _idleController;
  late final CurvedAnimation _idleCurveVertical;

  late Animation<double> _idleAnimationHorizontal;

  //late final AnimationController _idleControllerHorizontal;
  late final CurvedAnimation _idleCurveHorizontal;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500));
    _idleCurveVertical = CurvedAnimation(
        parent: _idleController,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn);
    _idleAnimationVertical =
        Tween<double>(begin: 0, end: 0).animate(_idleCurveVertical);

    _idleCurveHorizontal = CurvedAnimation(
        parent: _idleController,
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

    WidgetsBinding.instance?.addPostFrameCallback((_){
      if(widget.returnToIdleStateDelay != null){
        Future.delayed(widget.returnToIdleStateDelay!).then((_){
          if (widget.returnToIdleState) {
            _idleAnimationVertical =
                Tween<double>(begin: 0, end: _xRotation - widget.idleState.x!)
                    .animate(_idleController);
            _idleAnimationHorizontal =
                Tween<double>(begin: 0, end: _yRotation + widget.idleState.y!)
                    .animate(_idleController);
            //_idleController.reset();
            _idleController.reset();
            _idleController.forward().then((val) {
              _idleController.reset();
              _xRotation = widget.idleState.x!;
              _yRotation = widget.idleState.y!;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
            onPanUpdate: _onPanUpdate,
            onPanStart: _onPanStart,
            onPanEnd: _onPanEnd,
            child: AnimatedBuilder(
              animation: _idleController,
              builder: (context, child) {
                return ZIllustration(
                  children: [
                    ZPositioned(
                        rotate: ZVector.only(
                          y: _yRotation -
                              _idleAnimationHorizontal.value +
                              widget.yRotationOffset,
                          x: _xRotation - _idleAnimationVertical.value,
                        ),
                        child: child!)
                  ],
                );
              },
              child: widget.child,
            )),
        if(widget.topLayer!=null)
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: widget.topLayer!,
          ),
      ],
    );
  }

  _onPanUpdate(DragUpdateDetails val){
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
  }

  _onPanStart(DragStartDetails val){
    if (widget.returnToIdleState) {
      _idleController.stop();
      _idleController.stop();
    }
  }

  _onPanEnd(DragEndDetails val){
    widget.onYRotationUpdate?.call(_yRotation % tau);
    if (widget.returnToIdleState) {
      _idleAnimationVertical =
          Tween<double>(begin: 0, end: _xRotation - widget.idleState.x!)
              .animate(_idleController);
      _idleAnimationHorizontal =
          Tween<double>(begin: 0, end: _yRotation + widget.idleState.y!)
              .animate(_idleController);
      //_idleController.reset();
      _idleController.reset();
      _idleController.forward().then((val) {
        _idleController.reset();
        _xRotation = widget.idleState.x!;
        _yRotation = widget.idleState.y!;
      });
    }
  }



}
