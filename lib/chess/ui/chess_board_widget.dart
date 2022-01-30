import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/chess/models/chess_cell.dart';

class ChessBoardWidget extends StatelessWidget {
  final double cellSize;
  final List<ChessCell> cells;

  const ChessBoardWidget(
      {Key? key, required this.cellSize, required this.cells})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: ZVector.only(
          y: 5 + (((cellSize * 8) / 2) - (0.5 * cellSize)),
          z: (((cellSize * 8) / 2) - (0.5 * cellSize))),
      rotate: const ZVector.only(x: tau / 4),
      child: ZGroup(
        children: [
          for (final cell in cells)
            ZPositioned(
              translate: ZVector.only(
                  y: -cell.coordinate.j * cellSize,
                  x: cell.coordinate.i * cellSize),
              child: ZRect(
                width: cellSize,
                height: cellSize,
                fill: true,
                color: Color.alphaBlend(
                    ((cell.coordinate.i + cell.coordinate.j) % 2 == 0
                        ? const Color(0xff803300)
                        : Colors.white).withOpacity(cell.highlightColor != null?0.3:1),
                    cell.highlightColor != null
                        ? Color(cell.highlightColor!)
                        : Colors.transparent),
              ),
            ),
          for (int i = 0; i < 8; i++)
            cellLabel('${i + 1}',
                ZVector.only(x: -cellSize * 0.75, y: -i * cellSize)),
          for (int i = 0; i < 8; i++)
            cellLabel(
                '${8 - i}',
                ZVector.only(
                    x: (cellSize * 8) - cellSize * 0.25, y: -i * cellSize),
                inverse: true),
          for (int i = 0; i < 8; i++)
            cellLabel(
                String.fromCharCode('A'.codeUnitAt(0) + i),
                ZVector.only(
                  y: cellSize * 0.75,
                  x: i * cellSize,
                ),
                vertical: false),
          for (int i = 0; i < 8; i++)
            cellLabel(
                String.fromCharCode('A'.codeUnitAt(0) + 8 - i - 1),
                ZVector.only(
                    y: -(cellSize * 8) + cellSize * 0.25, x: i * cellSize),
                inverse: true,
                vertical: false),
        ],
      ),
    );
  }

  Widget cellLabel(String text, ZVector position,
      {bool vertical = true, bool inverse = false}) {
    return ZPositioned(
      translate: position,
      child: ZToBoxAdapter(
        width: vertical ? cellSize / 2 : cellSize,
        height: vertical ? cellSize : cellSize / 2,
        child: Transform.rotate(
          angle: inverse ? tau / 2 : 0,
          child: Container(
            width: vertical ? cellSize / 2 : cellSize,
            height: vertical ? cellSize : cellSize / 2,
            color: const Color(0xff803300),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
