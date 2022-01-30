import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zflutter_gallery/chess/controller/chess_controller.dart';
import 'package:zflutter_gallery/chess/input/chess_gesture_input.dart';
import 'package:zflutter_gallery/chess/models/chess_board.dart';
import 'package:zflutter_gallery/chess/ui/chess_widget.dart';

class ChessGame extends StatefulWidget {
  const ChessGame({Key? key}) : super(key: key);

  @override
  _ChessGameState createState() => _ChessGameState();
}

class _ChessGameState extends State<ChessGame> {

  late final ChessController controller;

  static const chessCellSize = 55.0;

  @override
  void initState() {
    super.initState();
    controller = ChessController(ChessBoard.build());
  }

  @override
  Widget build(BuildContext context) {
    final screenChessCellSize = min(
        (min(MediaQuery.of(context).size.width-100,
            MediaQuery.of(context).size.height-50) /
            8),
        55.0);
    final scale = screenChessCellSize/chessCellSize;
    print(scale);
    return Stack(
      children: [
        Center(
          child: ChessWidget(
            controller: controller,
            chessCellSize: chessCellSize * scale,
            scale: scale,
          ),
        ),
        Center(
          child: ChessGestureInput(
            controller: controller,
            cellSize: chessCellSize * scale,
          ),
        )
      ],
    );
  }
}
