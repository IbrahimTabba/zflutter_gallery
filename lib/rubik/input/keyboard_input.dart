import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zflutter_gallery/rubik/controllers/cube_controller.dart';

class KeyboardInput extends StatelessWidget {
  final CubeController controller;
  final Widget child;

  const KeyboardInput({
    Key? key,
    required this.controller,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (e) {
        if (e.runtimeType == RawKeyDownEvent) {
          if (e.isKeyPressed(LogicalKeyboardKey.keyE)) {
            controller.rotateBottom();
          } else if (e.isKeyPressed(LogicalKeyboardKey.keyQ)) {
            controller.rotateBottom(clockWise: false);
          }
          if (e.isKeyPressed(LogicalKeyboardKey.keyD)) {
            controller.rotateRight();
          } else if (e.isKeyPressed(LogicalKeyboardKey.keyA)) {
            controller.rotateRight(clockWise: false);
          }
          if (e.isKeyPressed(LogicalKeyboardKey.keyZ)) {
            controller.rotateFront();
          } else if (e.isKeyPressed(LogicalKeyboardKey.keyC)) {
            controller.rotateFront(clockWise: false);
          }
        }
      },
      child: child,
    );
  }
}
