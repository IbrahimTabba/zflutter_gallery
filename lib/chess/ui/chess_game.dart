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

class _ChessGameState extends State<ChessGame> with TickerProviderStateMixin {
  late final ChessController controller;

  static const chessCellSize = 55.0;


  late final CurvedAnimation verticalChessPieceCurve;
  late final AnimationController verticalChessPieceController;

  late final CurvedAnimation horizontalChessPieceCurve;
  late final AnimationController horizontalChessPieceController;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    controller = ChessController(
      ChessBoard.build(),
      verticalChessPieceAnimationController: verticalChessPieceController,
      verticalChessAnimationCurve: verticalChessPieceCurve,
      horizontalChessAnimationCurve: horizontalChessPieceCurve,
      horizontalChessPieceAnimationController: horizontalChessPieceController,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenChessCellSize = min(
        (min(MediaQuery.of(context).size.width - 100,
                MediaQuery.of(context).size.height - 50) /
            8),
        65.0);
    controller.updateChessCellSize(screenChessCellSize);
    final scale = screenChessCellSize / chessCellSize;
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (BuildContext context, ChessBoard chessBoard, Widget? child) {
        return Stack(
          children: [
            Center(
              child: ChessWidget(
                chessBoard: chessBoard,
                chessCellSize: chessCellSize * scale,
                verticalChessPieceAnimation: controller.verticalChessPieceAnimation,
                horizontalChessPieceAnimation: controller.horizontalChessPieceAnimation,
                scale: scale,
                activeChessPiece: controller.selectedPiece,
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
      },
    );
  }

  _initAnimations() {
    verticalChessPieceController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    verticalChessPieceCurve = CurvedAnimation(
      parent: verticalChessPieceController,
      curve: Curves.easeInOut,
    );

    horizontalChessPieceController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    horizontalChessPieceCurve = CurvedAnimation(
      parent: horizontalChessPieceController,
      curve: Curves.easeInOut,
    );
  }
}
