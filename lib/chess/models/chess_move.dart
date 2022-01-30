import 'chess_coordinate.dart';

class ChessPieceMove {
  final ChessCoordinate? target;
  final bool? canCrossOrthogonal;
  final bool? canCrossDiameters;

  ChessPieceMove({
    this.target,
    this.canCrossOrthogonal,
    this.canCrossDiameters,
  });
}