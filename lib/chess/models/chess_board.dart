import 'package:zflutter_gallery/chess/models/chess_coordinate.dart';
import 'package:zflutter_gallery/chess/models/chess_move.dart';
import 'package:zflutter_gallery/chess/models/chess_piece.dart';
import 'package:zflutter_gallery/chess/models/chess_piece_color.dart';
import 'package:zflutter_gallery/chess/models/chess_piece_type.dart';
import 'package:zflutter_gallery/chess/models/strategy/bishop_piece_strategy.dart';
import 'package:zflutter_gallery/chess/models/strategy/king_piece_strategy.dart';
import 'package:zflutter_gallery/chess/models/strategy/knight_piece_strategy.dart';
import 'package:zflutter_gallery/chess/models/strategy/pawn_piece_strategy.dart';
import 'package:zflutter_gallery/chess/models/strategy/queen_piece_strategy.dart';
import 'package:zflutter_gallery/chess/models/strategy/rook_piece_strategy.dart';
import 'package:collection/collection.dart';
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
                strategy: PawnPieceStrategy(reverse: false)),
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
                strategy: PawnPieceStrategy(reverse: true)),
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

  ChessCell? cellAt(ChessCoordinate coordinate) =>
      cells.firstWhereOrNull((cell) => cell.coordinate == coordinate);

  ChessPiece? pieceAt(ChessCoordinate coordinate) =>
      pieces.firstWhereOrNull((piece) => piece.currentPosition == coordinate);

  bool cellHasPiece(ChessCoordinate coordinate) {
    return pieces.any((piece) => piece.currentPosition == coordinate);
  }

  bool isValidCoordinate(ChessCoordinate coordinate) =>
      coordinate.i <= 7 &&
      coordinate.i >= 0 &&
      coordinate.j <= 7 &&
      coordinate.j >= 0;

  bool cellIsEmpty(ChessCoordinate coordinate) =>
      isValidCoordinate(coordinate) && !cellHasPiece(coordinate);

  removePieceAt(ChessCoordinate coordinate){
    pieces.removeWhere((piece)=>piece.currentPosition == coordinate);
  }

  bool cellHasEnemy(ChessCoordinate target, ChessPieceColor color) {
    final targetPiece = pieceAt(target);
    return targetPiece != null && targetPiece.color != color;
  }

  List<ChessCell> possibleTargetsForChessPiece(ChessPiece piece) {
    final result = <ChessCell>[];
    piece.strategy.constNonAttackMoves?.forEach((move) {
      if (move.target != null) {
        final moveCoordinate =
            piece.currentPosition.move(move.target!.i, move.target!.j);
        if (cellIsEmpty(moveCoordinate)) {
          result.add(cellAt(moveCoordinate)!);
        }
      }
    });
    final attackMoves = piece.strategy.constAttackMoves +
        (piece.strategy.conditionalMoves?.call(piece, this) ??
            <ChessPieceMove>[]);
    for (final move in attackMoves) {
      if (move.target != null) {
        final moveCoordinate =
            piece.currentPosition.move(move.target!.i, move.target!.j);
        if (cellIsEmpty(moveCoordinate) ||
            cellHasEnemy(moveCoordinate, piece.color)) {
          result.add(cellAt(moveCoordinate)!);
        }
      }
      if (move.canCrossOrthogonal ?? false) {
        var horizontalMove = 1;
        while (cellIsEmpty(piece.currentPosition.move(horizontalMove, 0))) {
          result.add(cellAt(piece.currentPosition.move(horizontalMove, 0))!);
          horizontalMove++;
        }
        if (cellHasEnemy(
            piece.currentPosition.move(horizontalMove, 0), piece.color)) {
          result.add(cellAt(piece.currentPosition.move(horizontalMove, 0))!);
        }
        horizontalMove = -1;
        while (cellIsEmpty(piece.currentPosition.move(horizontalMove, 0))) {
          result.add(cellAt(piece.currentPosition.move(horizontalMove, 0))!);
          horizontalMove--;
        }
        if (cellHasEnemy(
            piece.currentPosition.move(horizontalMove, 0), piece.color)) {
          result.add(cellAt(piece.currentPosition.move(horizontalMove, 0))!);
        }

        var verticalMove = 1;
        while (cellIsEmpty(piece.currentPosition.move(0, verticalMove))) {
          result.add(cellAt(piece.currentPosition.move(0, verticalMove))!);
          verticalMove++;
        }
        if (cellHasEnemy(
            piece.currentPosition.move(0, verticalMove), piece.color)) {
          result.add(cellAt(piece.currentPosition.move(0, verticalMove))!);
        }
        verticalMove = -1;
        while (cellIsEmpty(piece.currentPosition.move(0, verticalMove))) {
          result.add(cellAt(piece.currentPosition.move(0, verticalMove))!);
          verticalMove--;
        }
        if (cellHasEnemy(
            piece.currentPosition.move(0, verticalMove), piece.color)) {
          result.add(cellAt(piece.currentPosition.move(0, verticalMove))!);
        }
      }

      if (move.canCrossDiameters ?? false) {
        var i = 1;
        var j = 1;
        while (cellIsEmpty(piece.currentPosition.move(i, j))) {
          result.add(cellAt(piece.currentPosition.move(i, j))!);
          i++;
          j++;
        }
        if (cellHasEnemy(piece.currentPosition.move(i, j), piece.color)) {
          result.add(cellAt(piece.currentPosition.move(i, j))!);
        }

        i = -1;
        j = -1;
        while (cellIsEmpty(piece.currentPosition.move(i, j))) {
          result.add(cellAt(piece.currentPosition.move(i, j))!);
          i--;
          j--;
        }
        if (cellHasEnemy(piece.currentPosition.move(i, j), piece.color)) {
          result.add(cellAt(piece.currentPosition.move(i, j))!);
        }

        i = 1;
        j = -1;
        while (cellIsEmpty(piece.currentPosition.move(i, j))) {
          result.add(cellAt(piece.currentPosition.move(i, j))!);
          i++;
          j--;
        }
        if (cellHasEnemy(piece.currentPosition.move(i, j), piece.color)) {
          result.add(cellAt(piece.currentPosition.move(i, j))!);
        }

        i = -1;
        j = 1;
        while (cellIsEmpty(piece.currentPosition.move(i, j))) {
          result.add(cellAt(piece.currentPosition.move(i, j))!);
          i--;
          j++;
        }
        if (cellHasEnemy(piece.currentPosition.move(i, j), piece.color)) {
          result.add(cellAt(piece.currentPosition.move(i, j))!);
        }
      }
    }

    return result;
  }

  void clearAllHighlightCells() {
    for (final cell in cells) {
      cell.highlightColor = null;
    }
  }
}
