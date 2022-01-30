import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/3d_widgets/gesture_3d.dart';
import 'package:zflutter_gallery/chess/controller/chess_controller.dart';
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
  final ChessController controller;
  final double scale;

  const ChessWidget(
      {Key? key, required this.controller, required this.chessCellSize, this.scale=1})
      : super(key: key);

  ZVector itemCoordinates(int i, int j) {
    return ZVector.only(
        x: (i * chessCellSize) -
            (((chessCellSize * 8) / 2) - (0.5 * chessCellSize)),
        z: (-j * chessCellSize) +
            (((chessCellSize * 8) / 2) - (0.5 * chessCellSize)));
  }

  Widget buildPeace(ChessPiece chessPiece) {
    return ZPositioned(
      translate: itemCoordinates(
          chessPiece.currentPosition.i, chessPiece.currentPosition.j),
      rotate: chessPiece.color == ChessPieceColor.white?ZVector.only(y: tau/2 ):ZVector.zero,
      scale: ZVector.all(scale),
      child: () {
        switch (chessPiece.type) {
          case ChessPieceType.pawn:
            return PawnWidget(
              //color: Color.alphaBlend(itemColor(chessPiece.color).withOpacity(0.7),Color(0xff803300)),
              color: itemColor(chessPiece.color),
              scale: scale,
            );
          case ChessPieceType.rook:
            return RookWidget(
              color: itemColor(chessPiece.color),
              scale: scale,
            );
          case ChessPieceType.knight:
            return KnightWidget(
              color: itemColor(chessPiece.color),
              scale: scale,
            );
          case ChessPieceType.bishop:
          return BishopWidget(
            color: itemColor(chessPiece.color),
            scale: scale,
          );
          case ChessPieceType.queen:
            return QueenWidget(
              color: itemColor(chessPiece.color),
              scale: scale,
            );
          case ChessPieceType.king:
            return KingWidget(
              color: itemColor(chessPiece.color),
              scale: scale,
            );
          default:
            return ZGroup(
              children: [],
            );
        }
      }.call(),
    );
  }

  Color itemColor(ChessPieceColor pieceColor) {
    switch (pieceColor) {
      case ChessPieceColor.black:
        return Colors.black;
      case ChessPieceColor.white:
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
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (BuildContext context, ChessBoard chessBoard, Widget? child) {
        return ZGesture(
          maxXRotation: tau / 8,
          child: ZGroup(
            children: [
              for (final piece in chessBoard.pieces) buildPeace(piece),
              buildCells(chessBoard.cells),
            ],
          ),
        );
      },
    );
  }
}
