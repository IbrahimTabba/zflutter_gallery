import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/rubik/controllers/cube_controller.dart';
import 'package:zflutter_gallery/rubik/models/rubik_cube_model.dart';
import 'package:zflutter_gallery/rubik/ui/rubik_cube.dart';

class RubikCubeGame extends StatefulWidget {
  final int cubeSize;

  const RubikCubeGame({Key? key, this.cubeSize = 3}) : super(key: key);

  @override
  _RubikCubeGameState createState() => _RubikCubeGameState();
}

class _RubikCubeGameState extends State<RubikCubeGame>
    with TickerProviderStateMixin {
  late final CubeController controller;

  late final Animation horizontalRotateAnimation;
  late final AnimationController horizontalRotateController;
  late final CurvedAnimation horizontalRotateCurve;

  late final Animation sideRotateAnimation;
  late final AnimationController sideRotateController;
  late final CurvedAnimation sideRotateCurve;

  late final Animation faceRotateAnimation;
  late final AnimationController faceRotateController;
  late final CurvedAnimation faceRotateCurve;


  @override
  void initState() {
    super.initState();
    horizontalRotateController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    horizontalRotateCurve = CurvedAnimation(
      parent: horizontalRotateController,
      curve: Curves.linear,
    );
    horizontalRotateAnimation =
        Tween<double>(begin: 0, end: tau / 4).animate(horizontalRotateCurve);

    sideRotateController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    sideRotateCurve = CurvedAnimation(
      parent: sideRotateController,
      curve: Curves.linear,
    );
    sideRotateAnimation =
        Tween<double>(begin: 0, end: tau / 4).animate(sideRotateCurve);

    faceRotateController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    faceRotateCurve = CurvedAnimation(
      parent: faceRotateController,
      curve: Curves.linear,
    );
    faceRotateAnimation =
        Tween<double>(begin: 0, end: tau / 4).animate(faceRotateCurve);

    controller = CubeController(
      cube: RubikCubitModel(widget.cubeSize),
      horizontalRotateController: horizontalRotateController,
      faceRotateController: faceRotateController,
      sideRotateController: sideRotateController
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (e) {
        if (e.runtimeType == RawKeyDownEvent) {
          if (e.isKeyPressed(LogicalKeyboardKey.keyE)) {
            setState(() {
              controller.rotateBottom();
            });
          } else if (e.isKeyPressed(LogicalKeyboardKey.keyQ)) {
            setState(() {
              controller.rotateBottom(clockWise: false);
            });
          }
          if (e.isKeyPressed(LogicalKeyboardKey.keyD)) {
            setState(() {
              controller.rotateRight();
            });
          } else if (e.isKeyPressed(LogicalKeyboardKey.keyA)) {
            setState(() {
              controller.rotateRight(clockWise: false);
            });
          }
          if (e.isKeyPressed(LogicalKeyboardKey.keyZ)) {
            setState(() {
              controller.rotateFront();
            });
          } else if (e.isKeyPressed(LogicalKeyboardKey.keyC)) {
            setState(() {
              controller.rotateFront(clockWise: false);
            });
          }
        }
      },
      child: ChangeNotifierProvider.value(
        value: controller,
        builder: (context, _) => RubikCube(
          cubeController: controller,
          horizontalRotateAnimation: horizontalRotateAnimation,
          faceRotateAnimation: faceRotateAnimation,
          sideRotateAnimation: sideRotateAnimation,
        ),
      ),
    );
  }
}
