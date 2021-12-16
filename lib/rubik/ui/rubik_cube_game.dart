import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    _initAnimations();
    controller = CubeController(
        cube: RubikCubitModel(widget.cubeSize),
        horizontalRotateController: horizontalRotateController,
        faceRotateController: faceRotateController,
        sideRotateController: sideRotateController);
  }

  @override
  Widget build(BuildContext context) {
    double cubeSize;
    if(kIsWeb) {
      cubeSize = MediaQuery.of(context).size.height * 0.40;
    } else {
      cubeSize = MediaQuery.of(context).size.width * 0.50;
    }
    return _gameGestures(context,
        child: SizedBox(
          height: cubeSize,
          width: cubeSize,
          child: Center(
            child: ChangeNotifierProvider.value(
              value: controller,
              builder: (context, _) => RubikCube(
                cubeController: controller,
                horizontalRotateAnimation: horizontalRotateAnimation,
                faceRotateAnimation: faceRotateAnimation,
                sideRotateAnimation: sideRotateAnimation,
                onYRotationChanged: (rotation){
                  controller.rotationOffset = rotation;
                },
              ),
            ),
          ),
        ),
        size: cubeSize);
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
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                controller.rotateTop(
                    clockWise: (details.primaryVelocity ?? 0.0) < 0);
              },
              onVerticalDragEnd: (details) {
                controller.rotateRight(
                    clockWise: (details.primaryVelocity ?? 0.0) < 0);
              },
              onTap: () {
                controller.rotateFront();
              },
              onDoubleTap: () {
                controller.rotateFront(clockWise: false);
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            color: Colors.grey[400],
            child: Center(
              child: ChangeNotifierProvider.value(
                value: controller,
                builder: (context, _) => RubikCube(
                  cubeController: controller,
                  horizontalRotateAnimation: horizontalRotateAnimation,
                  faceRotateAnimation: faceRotateAnimation,
                  sideRotateAnimation: sideRotateAnimation,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                controller.rotateBottom(
                    clockWise: (details.primaryVelocity ?? 0.0) < 0);
              },
              onVerticalDragEnd: (details) {
                controller.rotateRight(
                    clockWise: (details.primaryVelocity ?? 0.0) < 0);
              },
              onTap: () {
                controller.rotateFront();
              },
              onDoubleTap: () {
                controller.rotateFront(clockWise: false);
              },
            ),
          ),
        ],
      ),
    );
  }

  _gameGestures(
    BuildContext context, {
    required Widget child,
    required double size,
  }) {
    return Stack(
      children: [
        Center(
          child: GestureDetector(
              onTap: () {
                controller.rotateFront();
              },
              onDoubleTap: () {
                controller.rotateFront(clockWise: false);
              },
              child: child),
        ),
        Column(
          children: [
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  controller.rotateTop(
                      clockWise: (details.primaryVelocity ?? 0.0) < 0);
                },
              ),
            ),
            SizedBox(
              width: size,
              height: size,
            ),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  controller.rotateBottom(
                      clockWise: (details.primaryVelocity ?? 0.0) < 0);
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  controller.rotateLeft(
                      clockWise: (details.primaryVelocity ?? 0.0) < 0);
                },
              ),
            ),
            SizedBox(
              width: size,
              height: size,
            ),
            Expanded(
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  controller.rotateRight(
                      clockWise: (details.primaryVelocity ?? 0.0) < 0);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  _initAnimations(){
    horizontalRotateController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    horizontalRotateCurve = CurvedAnimation(
      parent: horizontalRotateController,
      curve: Curves.easeInOut,
    );
    horizontalRotateAnimation =
        Tween<double>(begin: 0, end: tau / 4).animate(horizontalRotateCurve);

    sideRotateController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    sideRotateCurve = CurvedAnimation(
      parent: sideRotateController,
      curve: Curves.easeInOut,
    );
    sideRotateAnimation =
        Tween<double>(begin: 0, end: tau / 4).animate(sideRotateCurve);

    faceRotateController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    faceRotateCurve = CurvedAnimation(
      parent: faceRotateController,
      curve: Curves.easeInOut,
    );
    faceRotateAnimation =
        Tween<double>(begin: 0, end: tau / 4).animate(faceRotateCurve);
  }
}
