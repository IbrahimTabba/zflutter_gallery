import 'package:zflutter_gallery/chess/models/chess_coordinate.dart';
import 'package:zflutter_gallery/chess/models/chess_piece.dart';
import 'package:zflutter_gallery/chess/models/chess_piece_color.dart';
import 'package:zflutter_gallery/chess/models/chess_piece_type.dart';
import 'package:zflutter_gallery/chess/models/strategy/bishop_piece_strategy.dart';
import 'package:zflutter_gallery/chess/models/strategy/king_piece_strategy.dart';
import 'package:zflutter_gallery/chess/models/strategy/knight_piece_strategy.dart';
import 'package:zflutter_gallery/chess/models/strategy/pawn_piece_strategy.dart';
import 'package:zflutter_gallery/chess/models/strategy/queen_piece_strategy.dart';
import 'package:zflutter_gallery/chess/models/strategy/rook_piece_strategy.dart';

import 'chess_cell.dart';

class ChessBoard {
  final List<ChessPiece> pieces;
  final List<ChessCell> cells;

  ChessBoard({required this.pieces, required this.cells});

  ChessBoard.build()
      : pieces = [
          /// build initial black peaces
          for (int i = 0; i < 8; i++)
            ChessPiece(
                initialPosition: ChessCoordinate(i, 1),
                currentPosition: ChessCoordinate(i, 1),
                color: ChessPieceColor.black,
                type: ChessPieceType.pawn,
                strategy: PawnPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(0, 0),
              currentPosition: ChessCoordinate(0, 0),
              color: ChessPieceColor.black,
              type: ChessPieceType.rook,
              strategy: RookPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(7, 0),
              currentPosition: ChessCoordinate(7, 0),
              color: ChessPieceColor.black,
              type: ChessPieceType.rook,
              strategy: RookPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(3, 0),
              currentPosition: ChessCoordinate(3, 0),
              color: ChessPieceColor.black,
              type: ChessPieceType.king,
              strategy: KingPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(4, 0),
              currentPosition: ChessCoordinate(4, 0),
              color: ChessPieceColor.black,
              type: ChessPieceType.queen,
              strategy: QueenPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(2, 0),
              currentPosition: ChessCoordinate(2, 0),
              color: ChessPieceColor.black,
              type: ChessPieceType.bishop,
              strategy: BishopPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(5, 0),
              currentPosition: ChessCoordinate(5, 0),
              color: ChessPieceColor.black,
              type: ChessPieceType.bishop,
              strategy: BishopPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(1, 0),
              currentPosition: ChessCoordinate(1, 0),
              color: ChessPieceColor.black,
              type: ChessPieceType.knight,
              strategy: KnightPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(6, 0),
              currentPosition: ChessCoordinate(6, 0),
              color: ChessPieceColor.black,
              type: ChessPieceType.knight,
              strategy: KnightPieceStrategy()),

          /// build initial whit peaces
          for (int i = 0; i < 8; i++)
            ChessPiece(
                initialPosition: ChessCoordinate(i, 6),
                currentPosition: ChessCoordinate(i, 6),
                color: ChessPieceColor.white,
                type: ChessPieceType.pawn,
                strategy: PawnPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(0, 7),
              currentPosition: ChessCoordinate(0, 7),
              color: ChessPieceColor.white,
              type: ChessPieceType.rook,
              strategy: RookPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(7, 7),
              currentPosition: ChessCoordinate(7, 7),
              color: ChessPieceColor.white,
              type: ChessPieceType.rook,
              strategy: RookPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(4, 7),
              currentPosition: ChessCoordinate(4, 7),
              color: ChessPieceColor.white,
              type: ChessPieceType.king,
              strategy: KingPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(3, 7),
              currentPosition: ChessCoordinate(3, 7),
              color: ChessPieceColor.white,
              type: ChessPieceType.queen,
              strategy: QueenPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(2, 7),
              currentPosition: ChessCoordinate(2, 7),
              color: ChessPieceColor.white,
              type: ChessPieceType.bishop,
              strategy: BishopPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(5, 7),
              currentPosition: ChessCoordinate(5, 7),
              color: ChessPieceColor.white,
              type: ChessPieceType.bishop,
              strategy: BishopPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(1, 7),
              currentPosition: ChessCoordinate(1, 7),
              color: ChessPieceColor.white,
              type: ChessPieceType.knight,
              strategy: KnightPieceStrategy()),
          ChessPiece(
              initialPosition: ChessCoordinate(6, 7),
              currentPosition: ChessCoordinate(6, 7),
              color: ChessPieceColor.white,
              type: ChessPieceType.knight,
              strategy: KnightPieceStrategy()),
        ],
        cells = [
          for (int i = 0; i < 8; i++)
            for (int j = 0; j < 8; j++)
              ChessCell(
                coordinate: ChessCoordinate(i, j),
                //highlightColor: 0xff880808,
              )
        ];

  ChessCell cellAt(int i, int j) => cells
      .where((cell) => cell.coordinate.i == i && cell.coordinate.j == j)
      .first;

  clearAllHighlightCells() {
    for (final cell in cells) {
      cell.highlightColor = null;
    }
  }

  bool cellHasPiece(int i, int j) {
    return pieces.any((piece) =>
        piece.currentPosition.i == i && piece.currentPosition.j == j);
  }
}
