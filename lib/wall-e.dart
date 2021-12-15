import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

import '3d_gesture.dart';

class WallE extends StatefulWidget {
  const WallE({Key? key}) : super(key: key);

  @override
  _WallEState createState() => _WallEState();
}

class _WallEState extends State<WallE> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ZGesture(
        child: ZRect(
          width: 120,
          height: 80,
          stroke: 20,
          color: const Color(0xFFEE6622),
        ),
      ),
    );
  }
}
