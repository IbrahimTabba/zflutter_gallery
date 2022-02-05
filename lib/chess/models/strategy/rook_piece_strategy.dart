import 'package:zflutter_gallery/chess/models/chess_move.dart';
import 'package:zflutter_gallery/chess/models/strategy/chess_piece_strategy.dart';

class RookPieceStrategy extends ChessPieceStrategy{
  RookPieceStrategy() : super(
    constAttackMoves: [
      ChessPieceMove(canCrossOrthogonal: true),
    ],
  );

}