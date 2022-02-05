import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/base.dart';

class BishopWidget extends StatelessWidget {
  final Color color;
  final double scale;

  const BishopWidget({Key? key, required this.color, this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ChessBottomBase(color: color,height: 45,flat: true,diameter: 30,),
        ZPositioned(
          translate: const ZVector.only(y: -55),
          child: ZEllipse(
            color: color,
            width: 1,
            height: 5,
            stroke: 25 * scale,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(y: -70),
          child: ZShape(
            color: color,
            stroke: 10 * scale,
          ),
        )
      ],
    );
  }
}
