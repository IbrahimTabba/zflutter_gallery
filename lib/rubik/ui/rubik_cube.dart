import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/3d_gesture.dart';
import 'package:zflutter_gallery/rubik/controllers/cube_controller.dart';
import 'package:zflutter_gallery/rubik/models/rubik_cell.dart';
import 'package:zflutter_gallery/rubik/models/rubik_cube_model.dart';

class RubikCube extends StatefulWidget {
  final CubeController cubeController;
  final Animation horizontalRotateAnimation;
  final Animation faceRotateAnimation;
  final Animation sideRotateAnimation;

  const RubikCube(
      {Key? key,
      required this.cubeController,
      required this.horizontalRotateAnimation,
      required this.faceRotateAnimation,
      required this.sideRotateAnimation})
      : super(key: key);

  @override
  _RubikCubeState createState() => _RubikCubeState();
}

class _RubikCubeState extends State<RubikCube> {
  final double cubeCellSize = 60;
  final double cubeCellMargin = 3;
  late final RubikCubitModel cube;

  @override
  void initState() {
    super.initState();
    cube = widget.cubeController.cube;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.horizontalRotateAnimation,
      builder: (BuildContext context, Widget? child) {
        return AnimatedBuilder(
          animation: widget.sideRotateAnimation,
          builder: (BuildContext context, Widget? child) {
            return AnimatedBuilder(
              animation: widget.faceRotateAnimation,
              builder: (BuildContext context, Widget? child) {
                return ZGesture(
                  child: _cube(cube),
                  maxXRotation: tau / 12,
                );
              },
            );
          },
        );
      },
    );
  }

  ZWidget _cube(RubikCubitModel cube) {
    return ZGroup(
      children: [
        ZPositioned(
          rotate: ZVector.only(
            y: widget.horizontalRotateAnimation.value *
                ((widget.cubeController.targetMove?.clockWise ?? true)
                    ? 1.0
                    : -1.0),
            x: widget.sideRotateAnimation.value *
                ((widget.cubeController.targetMove?.clockWise ?? true)
                    ? 1.0
                    : -1.0),
            z: widget.faceRotateAnimation.value *
                ((widget.cubeController.targetMove?.clockWise ?? true)
                    ? 1.0
                    : -1.0),
          ),
          child: ZGroup(
            children: [
              for (int i = 0; i < cube.cells.length; i++)
                for (int j = 0; j < cube.cells[i].length; j++)
                  for (int k = 0; k < cube.cells[i][j].length; k++)
                    if (isTargetFace(widget.cubeController.targetMove, i, j, k))
                      _cubeCell(i, j, k, cube.cells[i][j][k])
            ],
          ),
        ),
        for (int i = 0; i < cube.cells.length; i++)
          for (int j = 0; j < cube.cells[i].length; j++)
            for (int k = 0; k < cube.cells[i][j].length; k++)
              if (!isTargetFace(widget.cubeController.targetMove, i, j, k))
                _cubeCell(i, j, k, cube.cells[i][j][k])
      ],
    );
  }

  bool isTargetFace(TargetMove? targetMove, int i, int j, int k) {
    if (targetMove?.cubeAxis == CubeAxis.horizontal &&
        i == targetMove?.moveIndex) {
      return true;
    }
    if (targetMove?.cubeAxis == CubeAxis.vertical &&
        k == targetMove?.moveIndex) {
      return true;
    }
    if (targetMove?.cubeAxis == CubeAxis.side && j == targetMove?.moveIndex) {
      return true;
    }
    return false;
  }

  Widget _cubeCell(int i, int j, int k, CubeCell cell) {
    if (shouldIgnoreCell(i, j, k)) {
      return ZGroup(
        children: const [],
      );
    }
    return ZPositioned(
      translate: ZVector.only(
        y: (-cubeCellSize * i) + (((cube.size - 1) * cubeCellSize) / 2),
        x: (cubeCellSize * j) - (((cube.size - 1) * cubeCellSize) / 2),
        z: (-cubeCellSize * k) + (((cube.size - 1) * cubeCellSize) / 2),
      ),
      child: ZGroup(
        children: [
          ZBox(
            height: cubeCellSize - cubeCellMargin,
            width: cubeCellSize - cubeCellMargin,
            depth: cubeCellSize - cubeCellMargin,
            stroke: 1,
            fill: true,
            color: Colors.black,
            frontColor: cell.frontColor,
            topColor: cell.topColor,
            leftColor: cell.leftColor,
            rightColor: cell.rightColor,
            bottomColor: cell.bottomColor,
            rearColor: cell.backColor,
          ),
          ZBox(
            height: cubeCellSize - cubeCellMargin + 2,
            width: cubeCellSize - cubeCellMargin + 2,
            depth: cubeCellSize - cubeCellMargin + 2,
            stroke: 1,
            fill: false,
            frontColor: Colors.black,
            color: Colors.black,
            topColor: Colors.black,
            leftColor: Colors.black,
            rightColor: Colors.black,
            bottomColor: Colors.black,
            rearColor: Colors.black,
          )
        ],
      ),
    );
  }

  bool shouldIgnoreCell(int i, int j, int k) {
    if (i != 0 && i != cube.size - 1) {
      if (j != 0 && j != cube.size - 1 && k != 0 && k != cube.size - 1) {
        return true;
      }
    }
    return false;
  }
}
