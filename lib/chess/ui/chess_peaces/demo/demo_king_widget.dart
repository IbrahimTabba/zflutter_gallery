import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/base.dart';

import 'demo_base.dart';

class DemoKingWidget extends StatelessWidget {
  final Color color;
  final double scale;

  const DemoKingWidget({Key? key, required this.color, this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        DemoChessBottomBase(
          color: color,
          height: 65,
          flat: true,
          diameter: 38,
        ),
        ZPositioned(
            translate: const ZVector.only(y: -80 - 130),
            rotate: const ZVector.only(x: -tau / 4),
            child: ZCone(
                diameter: 30, length: 60, color: color, backfaceColor: color)),
        ZPositioned(
          translate: const ZVector.only(y: -90.0 - 140),
          child: ZBox(
            width: 5,
            height: 20,
            depth: 5,
            color: color,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(y: -92.5 - 160),
          rotate: const ZVector.only(x: tau / 4),
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
