import 'package:zflutter_gallery/chess/models/chess_board.dart';
import 'package:zflutter_gallery/chess/models/chess_move.dart';
import 'package:zflutter_gallery/chess/models/chess_piece.dart';

abstract class ChessPieceStrategy {
  final List<ChessPieceMove>? constNonAttackMoves;
  final List<ChessPieceMove> constAttackMoves;
  final List<ChessPieceMove>? Function(ChessPiece chessPiece , ChessBoard chessBoard)?
      conditionalMoves;

  ChessPieceStrategy({
    required this.constAttackMoves,
    this.constNonAttackMoves,
    this.conditionalMoves,
  });

  // List<ChessCell> availableTargetCells(ChessCell position){
  //   final result = <ChessCell>[];
  //   for (final move in moves) {
  //     if(move.target!=null){
  //
  //     }
  //   }
  //   return result;
  // }
}
