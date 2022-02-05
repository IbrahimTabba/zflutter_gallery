import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/base.dart';

class KnightWidget extends StatelessWidget {
  final Color color;
  final double scale;


  const KnightWidget({Key? key, required this.color, this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ChessBottomBase(color: color,height: 30,flat: true,diameter: 30,),
        ZPositioned(
          translate: const ZVector.only(y: -30),
          child: ZShape(
            path: [
              ZMove.only(y: 0,z: 0),
              ZBezier(
                [
                  const ZVector.only(y: 0 , z: 0),
                  const ZVector.only(y: -35 , z: -10),
                  const ZVector.only(y: 5 , z: -25)
                ]
              ),
            ],
            color: color,
            stroke: 19 * scale,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(y: -55 , z: -10),
          rotate: const ZVector.only(y: tau/4),
          child: ZShape(
            path: [
              ZMove.only(x: 0, y: -3),
              ZLine.only(x: 3, y: 3),
              ZLine.only(x: -3, y: 3),
            ],
            // closed by default
            stroke: 2 * scale,
            color: color,
            fill: true,
          ),
        )
      ],
    );
  }
}
