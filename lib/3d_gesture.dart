import 'package:flutter/cupertino.dart';
import 'package:zflutter/zflutter.dart';

class ZGesture extends StatefulWidget {
  final Widget child;
  final double? maxXRotation;

  const ZGesture({Key? key, required this.child, this.maxXRotation}) : super(key: key);
  @override
  _ZGestureState createState() => _ZGestureState();
}

class _ZGestureState extends State<ZGesture> {
  double _xRotation = 0.0;
  double _yRotation = 0.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (val){
        setState(() {
          if(widget.maxXRotation!=null){
            if(((_xRotation - (val.delta.dy/100)) > -widget.maxXRotation!) && ((_xRotation - (val.delta.dy/100)) < widget.maxXRotation!)){
              _xRotation-=val.delta.dy/100;
            }
          }
          _yRotation-=val.delta.dx/100;
        });
      },
//      onVerticalDragUpdate: (val){
//        setState(() {
//          if(val.delta.dy<0.0){_xRotation+=0.025;}
//          else{_xRotation-=0.025;}
//
//        });
//      },
//      onHorizontalDragUpdate: (val){
//        setState(() {
//          if(val.delta.dx<0.0){_yRotation+=0.025;}
//          else{_yRotation-=0.025;}
//        });
//      },
      child: ZIllustration(
        children: [
          ZPositioned(
            rotate: ZVector.only(y:_yRotation , x: _xRotation),
            child: widget.child
          )
        ],
      ),
    );
  }
}
