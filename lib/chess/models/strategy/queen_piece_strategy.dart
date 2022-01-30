import 'package:zflutter_gallery/chess/models/chess_coordinate.dart';
import 'package:zflutter_gallery/chess/models/chess_move.dart';
import 'package:zflutter_gallery/chess/models/strategy/chess_piece_strategy.dart';

class QueenPieceStrategy extends ChessPieceStrategy{
  QueenPieceStrategy() : super(
    constAttackMoves: [
      //ChessPieceMove(canCrossOrthogonal: true),
    ],
  );

}