import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/3d_widgets/gesture_3d.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/demo/demo_king_widget.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/king_widget.dart';

class DemoChess extends StatelessWidget {
  const DemoChess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            //colors: [Color(0xffd19a75), Color(0xff04060a)],
            colors: [Colors.white , Colors.white],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1, 1),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ZGesture(
            maxXRotation: tau/8,
            child: ZGroup(
              children:[
                const DemoKingWidget(color: Colors.black,),
                ZPositioned(
                  translate: ZVector.only(x: 50),
                    child: KingWidget(color: Colors.black,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
