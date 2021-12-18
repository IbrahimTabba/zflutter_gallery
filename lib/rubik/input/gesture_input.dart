import 'package:flutter/material.dart';
import 'package:zflutter_gallery/rubik/controllers/cube_controller.dart';

class GameGestureInput extends StatelessWidget {
  final CubeController controller;
  final Widget child;
  final double gameSize;
  final bool active;

  const GameGestureInput({
    Key? key,
    required this.controller,
    required this.child,
    required this.gameSize,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: GestureDetector(
              onTap: () {
                if(active) {
                  controller.rotateFront();
                }
              },
              onDoubleTap: () {
                if(active){
                  controller.rotateFront(clockWise: false);
                }
              },
              child: child),
        ),
        IgnorePointer(
          ignoring: !active,
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    controller.rotateTop(
                        clockWise: (details.primaryVelocity ?? 0.0) < 0);
                  },
                  onTap: (){

                  },
                ),
              ),
              SizedBox(
                width: gameSize,
                height: gameSize,
              ),
              Expanded(
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    controller.rotateBottom(
                        clockWise: (details.primaryVelocity ?? 0.0) < 0);
                  },
                  onTap: (){

                  },
                ),
              ),
            ],
          ),
        ),
        IgnorePointer(
          ignoring: !active,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    controller.rotateLeft(
                        clockWise: (details.primaryVelocity ?? 0.0) < 0);
                  },
                  onTap: (){

                  },
                ),
              ),
              SizedBox(
                width: gameSize,
                height: gameSize,
              ),
              Expanded(
                child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    controller.rotateRight(
                        clockWise: (details.primaryVelocity ?? 0.0) < 0);
                  },
                  onTap: (){

                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
