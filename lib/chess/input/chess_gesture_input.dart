import 'package:flutter/material.dart';
import 'package:zflutter_gallery/chess/controller/chess_controller.dart';

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
        ...List.generate(8,(i)=>
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(8,(j)=>Container(
                width: cellSize,
                height: cellSize*0.7,
                //color: Colors.red.withOpacity(0.5),
                child: MouseRegion(
                  onHover: (event){
                    controller.testHover(i,8-j-1);
                  },
                  onExit: (event){

                  },
                ),
              ))
            ],
          )
        )
      ],
    );
  }
}
