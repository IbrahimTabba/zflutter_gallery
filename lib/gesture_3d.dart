import 'package:flutter/cupertino.dart';
import 'package:zflutter/zflutter.dart';

class ZGesture extends StatefulWidget {
  final Widget child;
  final double? maxXRotation;
  final double? initialXRotation;
  final double? initialYRotation;
  final Function(double)? onYRotationUpdate;

  const ZGesture({
    Key? key,
    required this.child,
    this.maxXRotation,
    this.onYRotationUpdate,
    this.initialXRotation,
    this.initialYRotation,
  }) : super(key: key);

  @override
  _ZGestureState createState() => _ZGestureState();
}

class _ZGestureState extends State<ZGesture> {
  double _xRotation = 0.0;
  double _yRotation = 0.0;

  @override
  void initState() {
    super.initState();
    if(widget.initialXRotation!=null) {
      _xRotation+=widget.initialXRotation!;
    }
    if(widget.initialYRotation!=null) {
      _yRotation+=widget.initialYRotation!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (val) {
        setState(() {
          if (widget.maxXRotation != null) {
            if (((_xRotation - (val.delta.dy / 100)) > -widget.maxXRotation!) &&
                ((_xRotation - (val.delta.dy / 100)) < widget.maxXRotation!)) {
              _xRotation -= val.delta.dy / 100;
            }
          }
          _yRotation -= val.delta.dx / 100;
        });
      },
      onPanEnd: (details) {
        widget.onYRotationUpdate?.call(_yRotation % tau);
      },
      child: ZIllustration(
        children: [
          ZPositioned(
              rotate: ZVector.only(y: _yRotation, x: _xRotation),
              child: widget.child)
        ],
      ),
    );
  }
}
