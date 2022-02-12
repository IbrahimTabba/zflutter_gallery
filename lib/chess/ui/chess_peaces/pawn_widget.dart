import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/base.dart';

class PawnWidget extends StatelessWidget {
  final Color color;
  final double scale;

  const PawnWidget({Key? key, required this.color, this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ChessBottomBase(
          color: color,
          height: 40,
        ),
        ZPositioned(
          translate: const ZVector.only(y: -32),
          rotate: const ZVector.only(x: tau / 4),
          child: ZCircle(
            diameter: 18,
            stroke: 6 * scale,
            color: color,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(y: -40),
          child: ZShape(
            stroke: 20 * scale,
            color: color,
          ),
        ),
      ],
    );
  }
}
