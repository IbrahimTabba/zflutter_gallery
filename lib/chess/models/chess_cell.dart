import 'package:zflutter_gallery/chess/models/chess_coordinate.dart';

class ChessCell {
  ChessCoordinate coordinate;
  int? highlightColor;

  ChessCell({required this.coordinate, this.highlightColor});
}
