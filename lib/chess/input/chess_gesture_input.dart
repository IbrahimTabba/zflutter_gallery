import 'package:flutter/material.dart';
import 'package:zflutter_gallery/chess/controller/chess_controller.dart';
import 'package:zflutter_gallery/chess/models/chess_piece_color.dart';

class ChessGestureInput extends StatelessWidget {
  final ChessController controller;
  final double cellSize;

  const ChessGestureInput({
    Key? key,
    required this.controller,
    required this.cellSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
            8,
            (i) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(
                        8,
                        (j) => SizedBox(
                              width: cellSize,
                              height: cellSize * 0.7,
                              //color: Colors.red.withOpacity(0.5),
                              child: GestureDetector(
                                onTap: () {
                                  controller.onPressOnCell(
                                      controller.currentColorTurn ==
                                              ChessPieceColor.black
                                          ? i
                                          : 8 - i - 1,
                                      controller.currentColorTurn ==
                                              ChessPieceColor.black
                                          ? 8 - j - 1
                                          : j);
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.move,
                                  onEnter: (event) {
                                    controller.cellHover(
                                        controller.currentColorTurn ==
                                                ChessPieceColor.black
                                            ? i
                                            : 8 - i - 1,
                                        controller.currentColorTurn ==
                                                ChessPieceColor.black
                                            ? 8 - j - 1
                                            : j);
                                  },
                                  onExit: (event) {},
                                ),
                              ),
                            ))
                  ],
                ))
      ],
    );
  }
}
