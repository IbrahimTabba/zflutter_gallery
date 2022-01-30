import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/base.dart';

class KingWidget extends StatelessWidget {
  final Color color;
  final double scale;


  const KingWidget({Key? key, required this.color, this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ChessBottomBase(color: color,height: 65,flat: true,diameter: 38,),
        ZPositioned(
          translate: ZVector.only(y: -80),
            rotate: ZVector.only(x: -tau/4),
            child: ZCone(
                diameter: 30,
                length: 60,
                color: color,
                backfaceColor: color
            )),
        ZPositioned(
          translate: ZVector.only(y: -90.0),
          child: ZBox(
            width: 5,
            height: 20,
            depth: 5,
            color: color,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(y: -92.5),
          rotate: ZVector.only(x: tau/4),
          child: ZBox(
            width: 10,
            height: 5,
            depth: 5,
            color: color,
          ),
        )
      ],
    );
  }
}
