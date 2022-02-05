class ChessCoordinate {
  final int i, j;

  ChessCoordinate(
      this.i,
      this.j,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChessCoordinate &&
          runtimeType == other.runtimeType &&
          i == other.i &&
          j == other.j;

  ChessCoordinate move(int i , int j){
    return ChessCoordinate(
      this.i + i,
      this.j + j
    );
  }

  @override
  int get hashCode => i.hashCode ^ j.hashCode;
}