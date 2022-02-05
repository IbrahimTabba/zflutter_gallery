import 'package:zflutter_gallery/chess/models/chess_board.dart';
import 'package:zflutter_gallery/chess/models/chess_coordinate.dart';
import 'package:zflutter_gallery/chess/models/chess_move.dart';
import 'package:zflutter_gallery/chess/models/chess_piece.dart';
import 'package:zflutter_gallery/chess/models/strategy/chess_piece_strategy.dart';

class PawnPieceStrategy extends ChessPieceStrategy{
  final bool reverse;
  PawnPieceStrategy({required this.reverse}) : super(
    constAttackMoves: [

    ],
    constNonAttackMoves: [
      ChessPieceMove(target: ChessCoordinate(0,1),) * (reverse?-1:1),
    ],
    conditionalMoves: (ChessPiece piece , ChessBoard board){
      return [
        if(piece.initialPosition == piece.currentPosition)
          ChessPieceMove(target: ChessCoordinate(0,2),) * (reverse?-1:1),
        if(board.cellHasEnemy(piece.currentPosition.move(1* (reverse?-1:1),1* (reverse?-1:1)) , piece.color))
          ChessPieceMove(target: ChessCoordinate(1,1),) * (reverse?-1:1),
        if(board.cellHasEnemy(piece.currentPosition.move(-1* (reverse?-1:1),1* (reverse?-1:1)), piece.color))
          ChessPieceMove(target: ChessCoordinate(-1,1),) * (reverse?-1:1),
      ];
    }
  );

}