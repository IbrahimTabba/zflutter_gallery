import 'package:flutter/cupertino.dart';
import 'package:synchronized/synchronized.dart';
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

  final AnimationController chessPieceAnimationController;
  final AnimationController chessBoardAnimationController;

  final CurvedAnimation verticalChessAnimationCurve;
  final CurvedAnimation horizontalChessAnimationCurve;

  late Animation verticalChessPieceAnimation;
  late Animation horizontalChessPieceAnimation;

  final lock = Lock();

  ChessController(
    ChessBoard value, {
    this.currentColorTurn = ChessPieceColor.black,
    required this.chessPieceAnimationController,
    required this.chessBoardAnimationController,
    required this.verticalChessAnimationCurve,
    required this.horizontalChessAnimationCurve,
  }) : super(value) {
    verticalChessPieceAnimation =
        Tween<double>(begin: 0, end: 0).animate(verticalChessAnimationCurve);
    horizontalChessPieceAnimation =
        Tween<double>(begin: 0, end: 0).animate(horizontalChessAnimationCurve);
  }

  void updateChessCellSize(double currentCellSize) {
    chessCellSize = currentCellSize;
  }

  ChessBoard get board => value;

  onPressOnCell(int i, int j) async {
    lock.synchronized(()async{
      final coordinate = ChessCoordinate(i, j);
      if (coordinate == selectedPiece?.currentPosition) {
        selectedPiece = null;
        board.clearAllHighlightCells(forClearKing: false);
        possibleTargetsForSelectedCell = null;
        notifyListeners();
      } else if (possibleTargetsForSelectedCell
          ?.map((e) => e.coordinate)
          .contains(coordinate) ??
          false) {
        final originalPiecePosition = selectedPiece!.currentPosition;
        board.pieceAt(ChessCoordinate(i, j))?.ignored = true;
        selectedPiece!.currentPosition = ChessCoordinate(i, j);
        final isCheckMateAfterMove = board.isCheckMate(selectedPiece!.color);
        selectedPiece!.currentPosition = originalPiecePosition;
        board.pieceAt(ChessCoordinate(i, j))?.ignored = false;
        if (isCheckMateAfterMove) {
          return;
        }
        board.clearAllHighlightCells();
        if (chessCellSize != null) {
          verticalChessPieceAnimation = Tween<double>(
              begin: 0,
              end: chessCellSize! * (selectedPiece!.currentPosition.j - j))
              .animate(verticalChessAnimationCurve);
          horizontalChessPieceAnimation = Tween<double>(
              begin: 0,
              end: chessCellSize! * (i - selectedPiece!.currentPosition.i))
              .animate(horizontalChessAnimationCurve);
          notifyListeners();
          await chessPieceAnimationController.forward();
          chessPieceAnimationController.reset();
        }
        board.removePieceAt(coordinate);
        selectedPiece?.currentPosition = ChessCoordinate(i, j);
        selectedPiece = null;
        possibleTargetsForSelectedCell = null;
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 600));
        await switchTurn();

        if (board.isCheckMate(currentColorTurn)) {
          board.kingCell(currentColorTurn)?.highlightColor = 0xffff0000;
        }
        notifyListeners();
      } else {
        final piece = board.pieceAt(ChessCoordinate(i, j));
        if (piece != null && piece.color == currentColorTurn) {
          board.clearAllHighlightCells(forClearKing: false);
          selectedPiece = piece;
          board.cellAt(coordinate)?.highlightColor = 0xff2e7ef0;
          possibleTargetsForSelectedCell =
              board.possibleTargetsForChessPiece(piece);
          possibleTargetsForSelectedCell?.forEach((cell) {
            if (board.cellHasEnemy(cell.coordinate, piece.color)) {
              cell.highlightColor = 0xff1d9e00;
            } else {
              cell.highlightColor = 0xff2e7ef0;
            }
          });
          notifyListeners();
        }
      }
    });

  }

  cellHover(int i, int j) {
    if (selectedPiece != null) {
      return;
    }
    if (board.cellHasPiece(ChessCoordinate(i, j)) &&
        board.pieceAt(ChessCoordinate(i, j))?.color == currentColorTurn) {
      board.clearAllHighlightCells(forClearKing: false);
      if(board.cellAt(ChessCoordinate(i, j))?.highlightColor!=0xffff0000) {
        board.cellAt(ChessCoordinate(i, j))?.highlightColor = 0xff2e7ef0;
      }
      notifyListeners();
    } else {
      board.clearAllHighlightCells(forClearKing: false);
    }
  }

  switchTurn() async {
    if (currentColorTurn == ChessPieceColor.black) {
      await chessBoardAnimationController.forward();
      currentColorTurn = ChessPieceColor.white;
    } else {
      await chessBoardAnimationController.reverse();
      currentColorTurn = ChessPieceColor.black;
    }
  }
}
