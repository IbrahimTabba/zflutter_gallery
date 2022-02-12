import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

class DemoChessBottomBase extends StatelessWidget {
  final Color color;
  final double height;
  final double diameter;
  final bool flat;

  const DemoChessBottomBase(
      {Key? key,
      required this.color,
      required this.height,
      this.flat = false,
      this.diameter = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        if (!flat)
          ZPositioned(
              rotate: const ZVector.only(x: tau / 4),
              child: ZCone(
                  diameter: diameter,
                  length: height,
                  color: color,
                  backfaceColor: color))
        else ...[
          ZPositioned(
              rotate: const ZVector.only(x: tau / 4 ),
              translate: const ZVector.only(y: -10),
              child: ZCone(
                  diameter: diameter,
                  length: height,
                  color: color,
                  backfaceColor: color)),
          ZPositioned(
              rotate: const ZVector.only(x: tau / 4),
              translate: ZVector.only(y: (-height / 2) - height - 20),
              child: ZCylinder(
                diameter: diameter * 0.6,
                length: height,
                frontface: color,
                color: color,
                backface: color,
              ))
        ],
        ZPositioned(
          rotate: const ZVector.only(x: tau / 4),
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
