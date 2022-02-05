import 'package:flutter/cupertino.dart';
import 'package:zflutter_gallery/chess/models/chess_board.dart';
import 'package:zflutter_gallery/chess/models/chess_cell.dart';
import 'package:zflutter_gallery/chess/models/chess_coordinate.dart';
import 'package:zflutter_gallery/chess/models/chess_piece.dart';
import 'package:zflutter_gallery/chess/models/chess_piece_color.dart';

class ChessController extends ValueNotifier<ChessBoard> {
  ChessPiece? selectedPiece;
  List<ChessCell>? possibleTargetsForSelectedCell;
  ChessPieceColor currentColorTurn;

  double? chessCellSize;

  final AnimationController verticalChessPieceAnimationController;
  final AnimationController horizontalChessPieceAnimationController;

  final CurvedAnimation verticalChessAnimationCurve;
  final CurvedAnimation horizontalChessAnimationCurve;

  late Animation verticalChessPieceAnimation;
  late Animation horizontalChessPieceAnimation;

  ChessController(ChessBoard value,
      {this.currentColorTurn = ChessPieceColor.black
        , required this.verticalChessPieceAnimationController,
         required this.horizontalChessPieceAnimationController,
         required this.verticalChessAnimationCurve,
         required this.horizontalChessAnimationCurve,
      })
      : super(value){
    verticalChessPieceAnimation = Tween<double>(begin: 0, end: 0).animate(verticalChessAnimationCurve);
    horizontalChessPieceAnimation = Tween<double>(begin: 0, end: 0).animate(horizontalChessAnimationCurve);
    verticalChessPieceAnimation.addListener((){
      //print('${verticalChessPieceAnimation.value}');
    });
  }

  void updateChessCellSize(double currentCellSize){
    chessCellSize = currentCellSize;
  }

  ChessBoard get board => value;

  onPressOnCell(int i, int j)async{
    final coordinate = ChessCoordinate(i, j);
    if(coordinate == selectedPiece?.currentPosition){
      selectedPiece = null;
      board.clearAllHighlightCells();
      possibleTargetsForSelectedCell = null;
      notifyListeners();
    }

    else if(possibleTargetsForSelectedCell?.map((e) => e.coordinate).contains(coordinate)??false){
      if(chessCellSize!=null){
        verticalChessPieceAnimation = Tween<double>(begin: 0, end: chessCellSize!*(selectedPiece!.currentPosition.j-j)).animate(verticalChessAnimationCurve);
        horizontalChessPieceAnimation = Tween<double>(begin: 0, end: chessCellSize!*(i-selectedPiece!.currentPosition.i)).animate(horizontalChessAnimationCurve);
        notifyListeners();
        await Future.wait([
          verticalChessPieceAnimationController.forward(),
          horizontalChessPieceAnimationController.forward(),
        ]);
      }
      verticalChessPieceAnimationController.reset();
      horizontalChessPieceAnimationController.reset();
      board.removePieceAt(coordinate);
      selectedPiece?.currentPosition = ChessCoordinate(i,j);
      selectedPiece = null;
      possibleTargetsForSelectedCell = null;
      board.clearAllHighlightCells();
      switchTurn();
      notifyListeners();
    }
    else{
      final piece = board.pieceAt(ChessCoordinate(i, j));
      if (piece != null && piece.color == currentColorTurn) {
        selectedPiece = piece;
        board.cellAt(coordinate)?.highlightColor = 0xff2e7ef0;
        possibleTargetsForSelectedCell =
            board.possibleTargetsForChessPiece(piece);
        possibleTargetsForSelectedCell?.forEach((cell) {
          if(board.cellHasEnemy(cell.coordinate, piece.color)) {
            cell.highlightColor = 0xff960f16;
          } else {
            cell.highlightColor = 0xff2e7ef0;
          }
        });
        notifyListeners();
      }
    }

  }

  cellHover(int i, int j) {
    if(selectedPiece!=null) {
      return;
    }
    if (board.cellHasPiece(ChessCoordinate(i, j)) && board.pieceAt(ChessCoordinate(i, j))?.color == currentColorTurn) {
      board.clearAllHighlightCells();
      board.cellAt(ChessCoordinate(i, j))?.highlightColor = 0xff2e7ef0;
      notifyListeners();
    }
  }

  switchTurn(){
    if(currentColorTurn == ChessPieceColor.black){
      currentColorTurn = ChessPieceColor.white;
    }
    else{
      currentColorTurn = ChessPieceColor.black;
    }
  }
}
