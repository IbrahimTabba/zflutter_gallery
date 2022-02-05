import 'package:zflutter_gallery/chess/models/chess_coordinate.dart';
import 'package:zflutter_gallery/chess/models/chess_move.dart';
import 'package:zflutter_gallery/chess/models/strategy/chess_piece_strategy.dart';

class KnightPieceStrategy extends ChessPieceStrategy{
  KnightPieceStrategy() : super(
    constAttackMoves: [
      ChessPieceMove(target: ChessCoordinate(2,1),),
      ChessPieceMove(target: ChessCoordinate(2,-1),),
      ChessPieceMove(target: ChessCoordinate(-2,1),),
      ChessPieceMove(target: ChessCoordinate(-2,-1),),

      ChessPieceMove(target: ChessCoordinate(1,2),),
      ChessPieceMove(target: ChessCoordinate(-1,2),),
      ChessPieceMove(target: ChessCoordinate(1,-2),),
      ChessPieceMove(target: ChessCoordinate(-1,-2),),
    ],
  );

}