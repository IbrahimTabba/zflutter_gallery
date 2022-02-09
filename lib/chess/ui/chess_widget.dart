import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/3d_widgets/gesture_3d.dart';
import 'package:zflutter_gallery/chess/models/chess_board.dart';
import 'package:zflutter_gallery/chess/models/chess_cell.dart';
import 'package:zflutter_gallery/chess/models/chess_piece.dart';
import 'package:zflutter_gallery/chess/models/chess_piece_color.dart';
import 'package:zflutter_gallery/chess/models/chess_piece_type.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/bishop_widget.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/king_widget.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/queen_widget.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/rook_widget.dart';

import 'chess_board_widget.dart';
import 'chess_peaces/knight_widget.dart';
import 'chess_peaces/pawn_widget.dart';

class ChessWidget extends StatelessWidget {
  final double chessCellSize;
  final ChessBoard chessBoard;
  final double scale;
  final Animation verticalChessPieceAnimation;
  final Animation horizontalChessPieceAnimation;
  final Animation chessBoardAnimation;
  final AnimationController animationController;
  final ChessPiece? activeChessPiece;
  final ChessPieceColor currentColorTurn;

  const ChessWidget({
    Key? key,
    required this.chessBoard,
    required this.chessCellSize,
    this.scale = 1,
    required this.verticalChessPieceAnimation,
    required this.horizontalChessPieceAnimation,
    required this.animationController,
    required this.chessBoardAnimation,
    this.activeChessPiece,
    required this.currentColorTurn,
  }) : super(key: key);

  ZVector itemCoordinates(int i, int j, bool isCurrentPiece) {
    return ZVector.only(
        x: (i * chessCellSize) -
            (((chessCellSize * 8) / 2) - (0.5 * chessCellSize)) +
            (isCurrentPiece ? horizontalChessPieceAnimation.value : 0.0),
        z: (-j * chessCellSize) +
            (((chessCellSize * 8) / 2) - (0.5 * chessCellSize)) +
            (isCurrentPiece ? verticalChessPieceAnimation.value : 0.0));
  }

  Widget buildPeace(ChessPiece chessPiece) {
    bool isCurrentPiece = chessPiece == activeChessPiece;
    return ZPositioned(
      translate: itemCoordinates(chessPiece.currentPosition.i,
          chessPiece.currentPosition.j, isCurrentPiece),
      rotate: chessPiece.color == ChessPieceColor.white
          ? const ZVector.only(y: tau / 2)
          : ZVector.zero,
      scale: ZVector.all(scale),
      child: () {
        switch (chessPiece.type) {
          case ChessPieceType.pawn:
            return PawnWidget(
              // color: Color.alphaBlend(
              //     itemColor(chessPiece).withOpacity(0.7),
              //     const Color(0xff803300)),
              color: itemColor(chessPiece),
              scale: scale,
            );
          case ChessPieceType.rook:
            return RookWidget(
              color: itemColor(chessPiece),
              scale: scale,
            );
          case ChessPieceType.knight:
            return KnightWidget(
              color: itemColor(chessPiece),
              scale: scale,
            );
          case ChessPieceType.bishop:
            return BishopWidget(
              color: itemColor(chessPiece),
              scale: scale,
            );
          case ChessPieceType.queen:
            return QueenWidget(
              color: itemColor(chessPiece),
              scale: scale,
            );
          case ChessPieceType.king:
            return KingWidget(
              color: itemColor(chessPiece),
              scale: scale,
            );
          default:
            return ZGroup(
              children: const [],
            );
        }
      }.call(),
    );
  }

  Color itemColor(ChessPiece piece) {
    switch (piece.color) {
      case ChessPieceColor.black:
        if(piece.type == ChessPieceType.pawn) {
          return const Color(0xff333333);
        }
        return Colors.black;
      case ChessPieceColor.white:
        if(piece.type!=ChessPieceType.pawn) {
          return const Color(0xffd9ad8f);
        }
        //return Colors.white;
        //return const Color(0xfffae2d4);
        return const Color(0xfff7d7c1);
    }
  }

  Widget buildCells(List<ChessCell> cells) {
    return ZPositioned(
      translate: ZVector.only(
          x: -(((chessCellSize * 8) / 2) - (0.5 * chessCellSize)),
          z: (((chessCellSize * 8) / 2) - (0.5 * chessCellSize))),
      child: ChessBoardWidget(
        cells: cells,
        cellSize: chessCellSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: chessBoardAnimation,
      builder: (BuildContext context, Widget? child) {
        return ZGesture(
          maxXRotation: tau / 8,
          returnToIdleState: true,
          idleState: const ZVector.only(x: -tau / 8, y: 0, z: 0),
          yRotationOffset: chessBoardAnimation.value,
          child: child!,
        );
      },
      child: ZGroup(
        sortMode: SortMode.update,
        children: [
          for (final piece in chessBoard.pieces)
            if (piece == activeChessPiece)
              AnimatedBuilder(
                  animation: animationController,
                  builder: (BuildContext context, Widget? child) {
                    return buildPeace(piece);
                  })
            else
              buildPeace(piece),
          buildCells(chessBoard.cells),
        ],
      ),
    );
  }
}
