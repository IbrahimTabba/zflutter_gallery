import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

class ChessBottomBase extends StatelessWidget {
  final Color color;
  final double height;
  final double diameter;
  final bool flat;
  const ChessBottomBase({Key? key, required this.color, required this.height , this.flat = false, this.diameter = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        // ZShape(
        //   path: [
        //     ZMove.only(x: 0 , y: -height),
        //     ZArc(
        //         corner: ZVector.only(x: 5 , y: -height + (height*0.75)),
        //         end: ZVector.only(x: 5 , y: 0)
        //     )
        //   ],
        //   color: color,
        //   stroke: 6,
        // ),
        if(!flat)
          ZPositioned(
            rotate: const ZVector.only(x: tau/4),
            child: ZCone(
                diameter: diameter,
                length: height,
                color: color,
                backfaceColor: color
            ))
        else
          ...[
            ZPositioned(
                rotate: const ZVector.only(x: tau/4),
                child: ZCone(
                    diameter: diameter,
                    length: height,
                    color: color,
                    backfaceColor: color
                )),
            ZPositioned(
                rotate: const ZVector.only(x: tau/4),
                translate: ZVector.only(y: -height/2),
                child: ZCylinder(
                  diameter: diameter*0.6,
                  length: height,
                  frontface: color,
                  color: color,
                  backface: color,
                ))
          ],
        ZPositioned(
          rotate: const ZVector.only(x: tau/4),
          child: ZCircle(
            diameter: 30,
            stroke: 6,
            color: color,
          ),
        ),
      ],
    );
  }
}
