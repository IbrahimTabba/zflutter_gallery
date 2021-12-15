import 'package:flutter/cupertino.dart';
import 'package:synchronized/synchronized.dart';
import 'package:zflutter_gallery/rubik/models/rubik_cube_model.dart';

class CubeController extends ChangeNotifier {
  final RubikCubitModel cube;
  final AnimationController horizontalRotateController;
  final AnimationController faceRotateController;
  final AnimationController sideRotateController;

  TargetMove? targetMove;
  bool? locked;
  final lock = Lock();

  CubeController({
    required this.cube,
    required this.horizontalRotateController,
    required this.faceRotateController,
    required this.sideRotateController,
  });

  Future<void> rotateLayer({required int layer, bool clockWise = true}) async {
    await lock.synchronized(()async{
      if(locked??false) {
        return;
      }
      locked = true;
      targetMove = TargetMove(
          cubeAxis: CubeAxis.horizontal,
          moveIndex: layer,
          clockWise: clockWise
      );
      notifyListeners();
      await horizontalRotateController.forward();
      horizontalRotateController.reset();
      horizontalRotate(layer, clockWise: clockWise);
      locked = false;
    });
  }

  Future<void> rotateSide({required int side, bool clockWise = true}) async {
    await lock.synchronized(()async{
      if(locked??false) {
        return;
      }
      locked = true;
      targetMove = TargetMove(
          cubeAxis: CubeAxis.side,
          moveIndex: side,
          clockWise: clockWise
      );
      notifyListeners();
      await sideRotateController.forward();
      sideRotateController.reset();
      verticalSideRotate(side, clockWise: clockWise);
      locked = false;
    });
  }

  Future<void> rotateFace({required int face, bool clockWise = true}) async {
    await lock.synchronized(()async{
      if(locked??false) {
        return;
      }
      locked = true;
      targetMove = TargetMove(
          cubeAxis: CubeAxis.vertical,
          moveIndex: face,
          clockWise: clockWise
      );
      notifyListeners();
      await faceRotateController.forward();
      faceRotateController.reset();
      verticalFaceRotate(face, clockWise: clockWise);
      locked = false;
    });
  }

  Future<void> rotateBottom({bool clockWise = true}) async {
    await rotateLayer(layer: 0, clockWise: clockWise);
  }

  Future<void> rotateRight({bool clockWise = true}) async {
    await rotateSide(side: 0, clockWise: clockWise);
  }

  Future<void> rotateFront({bool clockWise = true}) async {
    await rotateFace(face: 0, clockWise: clockWise);
  }

  void horizontalRotate(int layer, {bool clockWise = true}) {
    cube.horizontalRotate(layer, clockWise: clockWise);
    notifyListeners();
  }

  void verticalFaceRotate(int face, {bool clockWise = true}) {
    cube.verticalFaceRotate(face, clockWise: clockWise);
    notifyListeners();
  }

  void verticalSideRotate(int side, {bool clockWise = true}) {
    cube.verticalSideRotate(side, clockWise: clockWise);
    notifyListeners();
  }
}

class TargetMove {
  final CubeAxis cubeAxis;
  final int moveIndex;
  final bool clockWise;

  TargetMove({
    required this.cubeAxis,
    required this.moveIndex,
    required this.clockWise,
  });
}

enum CubeAxis { horizontal, vertical, side }
