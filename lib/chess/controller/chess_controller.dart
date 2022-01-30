import 'package:flutter/cupertino.dart';
import 'package:zflutter_gallery/chess/models/chess_board.dart';

class ChessController extends ValueNotifier<ChessBoard>{
  ChessController(ChessBoard value) : super(value);

  ChessBoard get board => value;

  testHover(int i , int j){
    board.clearAllHighlightCells();
    if(board.cellHasPiece(i, j)) {
      board.cellAt(i,j).highlightColor = 0xff2e7ef0;
    }
    // if(j+1 < 8) {
    //   board.cellAt(i,j+1).highlightColor = 0xff2e7ef0;
    // }
    // if(j+2 < 8) {
    //   board.cellAt(i,j+2).highlightColor = 0xff2e7ef0;
    // }
    notifyListeners();
  }


}