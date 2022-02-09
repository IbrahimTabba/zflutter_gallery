import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/base.dart';

class RookWidget extends StatelessWidget {
  final Color color;
  final double scale;

  const RookWidget({Key? key, required this.color, this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ChessBottomBase(
          color: color,
          height: 45,
          flat: true,
          diameter: 30,
        ),
        ZPositioned(
          translate: const ZVector.only(y: -45),
          rotate: const ZVector.only(x: tau / 4),
          child: ZCylinder(
            diameter: 30,
            length: 10,
            frontface: color,
            color: color,
            backface: color,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(y: -52.5, z: 12.5),
          child: ZBox(
            width: 13,
            height: 7.5,
            depth: 3,
            color: color,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(y: -52.5, z: -12.5),
          child: ZBox(
            width: 13,
            height: 7.5,
            depth: 3,
            color: color,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(y: -52.5, x: 12.5),
          rotate: const ZVector.only(y: tau / 4),
          child: ZBox(
            width: 13,
            height: 7.5,
            depth: 3,
            color: color,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(y: -52.5, x: -12.5),
          rotate: const ZVector.only(y: tau / 4),
          child: ZBox(
            width: 13,
            height: 7.5,
            depth: 3,
            color: color,
          ),
        )
      ],
    );
  }
}
