import 'package:zflutter_gallery/chess/models/chess_piece_type.dart';
import 'package:zflutter_gallery/chess/models/strategy/chess_piece_strategy.dart';

import 'chess_coordinate.dart';
import 'chess_piece_color.dart';

class ChessPiece {
  final ChessCoordinate initialPosition;
  final ChessCoordinate currentPosition;
  final ChessPieceColor color;
  final ChessPieceStrategy strategy;
  final ChessPieceType type;

  ChessPiece({
    required this.initialPosition,
    required this.currentPosition,
    required this.color,
    required this.strategy,
    required this.type,
  });
}