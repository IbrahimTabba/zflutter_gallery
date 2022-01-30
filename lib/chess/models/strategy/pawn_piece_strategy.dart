import 'package:zflutter_gallery/chess/models/chess_coordinate.dart';
import 'package:zflutter_gallery/chess/models/chess_move.dart';
import 'package:zflutter_gallery/chess/models/strategy/chess_piece_strategy.dart';

class PawnPieceStrategy extends ChessPieceStrategy{
  PawnPieceStrategy() : super(
    constAttackMoves: [
      ChessPieceMove(target: ChessCoordinate(1,1),),
      ChessPieceMove(target: ChessCoordinate(-1,1),),
    ],
    constNonAttackMoves: [
      ChessPieceMove(target: ChessCoordinate(0,1),),
    ]
  );

}