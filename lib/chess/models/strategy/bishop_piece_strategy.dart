import 'package:zflutter_gallery/chess/models/chess_coordinate.dart';
import 'package:zflutter_gallery/chess/models/chess_move.dart';
import 'package:zflutter_gallery/chess/models/strategy/chess_piece_strategy.dart';

class BishopPieceStrategy extends ChessPieceStrategy{
  BishopPieceStrategy() : super(
    constAttackMoves: [
      ChessPieceMove(canCrossDiameters: true),
    ],
  );

}