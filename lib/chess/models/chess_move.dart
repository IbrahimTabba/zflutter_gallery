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

  operator *(int x) => ChessPieceMove(
      canCrossDiameters: canCrossDiameters,
      canCrossOrthogonal: canCrossOrthogonal,
      target: target != null
          ? ChessCoordinate(target!.i * x, target!.j * x)
          : null);
}
