import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/base.dart';

class QueenWidget extends StatelessWidget {
  final Color color;
  final double scale;

  const QueenWidget({Key? key, required this.color, this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ChessBottomBase(color: color,height: 65,flat: true,diameter: 38,),
        ZPositioned(
          translate: const ZVector.only(y: -80),
            rotate: const ZVector.only(x: -tau/4),
            child: ZCone(
                diameter: 30,
                length: 60,
                color: color,
                backfaceColor: color
            )),
        ZPositioned(
          translate: const ZVector.only(y:-82.5),
          child: ZShape(
            stroke: 15 * scale,
            color: color,
          ),
        )

      ],
    );
  }
}
