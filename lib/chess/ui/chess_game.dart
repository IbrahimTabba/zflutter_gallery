import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
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

  late final AnimationController chessPieceAnimationController;
  late final AnimationController chessPieceInitialAnimationController;
  late final AnimationController chessBoardAnimationController;

  late final CurvedAnimation verticalChessPieceCurve;
  late final CurvedAnimation horizontalChessPieceCurve;
  late final CurvedAnimation chessBoardCurve;

  late Animation chessBoardAnimation;
  late Animation chessPieceInitialAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    controller = ChessController(ChessBoard.build(),
        chessPieceAnimationController: chessPieceAnimationController,
        verticalChessAnimationCurve: verticalChessPieceCurve,
        horizontalChessAnimationCurve: horizontalChessPieceCurve,
        chessBoardAnimationController: chessBoardAnimationController);

    WidgetsBinding.instance?.addPostFrameCallback((_)async{
      await Future.delayed(const Duration(seconds: 1));
      chessPieceInitialAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenChessCellSize = min(
        (min(MediaQuery.of(context).size.width - 125,
                MediaQuery.of(context).size.height - 75) /
            8),
        75.0);
    controller.updateChessCellSize(screenChessCellSize);
    final scale = screenChessCellSize / chessCellSize;
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (BuildContext context, ChessBoard chessBoard, Widget? child) {
        return Stack(
          children: [
            Center(
              child: ChessWidget(
                chessController: controller,
                chessCellSize: chessCellSize * scale,
                verticalChessPieceAnimation:
                    controller.verticalChessPieceAnimation,
                horizontalChessPieceAnimation:
                    controller.horizontalChessPieceAnimation,
                scale: scale,
                pieceIntroAnimation: chessPieceInitialAnimation,
                animationController: chessPieceAnimationController,
                activeChessPiece: controller.selectedPiece,
                chessBoardAnimation: chessBoardAnimation,
                currentColorTurn: controller.currentColorTurn,
              ),
            ),
            // Center(
            //   child: ChessGestureInput(
            //     controller: controller,
            //     cellSize: chessCellSize * scale,
            //   ),
            // )
          ],
        );
      },
    );
  }

  _initAnimations() {
    chessPieceAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    chessBoardAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      reverseDuration: const Duration(milliseconds: 1200),
    );

    chessPieceInitialAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    verticalChessPieceCurve = CurvedAnimation(
      parent: chessPieceAnimationController,
      curve: Curves.fastOutSlowIn,
    );
    horizontalChessPieceCurve = CurvedAnimation(
      parent: chessPieceAnimationController,
      curve: Curves.fastOutSlowIn,
    );
    chessBoardCurve = CurvedAnimation(
      parent: chessBoardAnimationController,
      curve: Curves.fastOutSlowIn,
    );
    chessBoardAnimation =
        Tween<double>(begin: 0, end: tau / 2).animate(chessBoardCurve);

    chessPieceInitialAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: chessPieceInitialAnimationController,
          curve: Curves.linear,
        ));
  }
}
