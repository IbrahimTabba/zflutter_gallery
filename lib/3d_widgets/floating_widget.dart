import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

class FloatingWidget extends StatefulWidget {
  final Widget child;

  const FloatingWidget({Key? key, required this.child}) : super(key: key);

  @override
  _FloatingWidgetState createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with TickerProviderStateMixin {
  late final Animation<double> _idleAnimation;
  late final AnimationController _idleController;
  late final CurvedAnimation _idleCurve;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
        reverseDuration: const Duration(seconds: 5));

    _idleCurve = CurvedAnimation(
        parent: _idleController,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn);

    // _idleAnimation =
    //     Tween<double>(begin: -tau / 40, end: tau / 40).animate(_idleCurve);

    _idleAnimation =
        Tween<double>(begin: 20, end: -20).animate(_idleCurve);

    _idleController.repeat(reverse: true );
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _idleAnimation,
      builder: (BuildContext context, Widget? child) {
        return ZPositioned(
          translate: ZVector.only(y: _idleAnimation.value),
          child: child!,
        );
      },
      child: widget.child,

    );
  }
}
