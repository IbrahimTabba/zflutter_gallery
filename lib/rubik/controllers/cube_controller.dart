import 'package:flutter/cupertino.dart';
import 'package:zflutter_gallery/rubik/models/rubik_cube_model.dart';

class CubeController extends ChangeNotifier {
  final RubikCubitModel cube;
  final AnimationController horizontalRotateController;

  CubeFaces? targetFace;

  CubeController({
    required this.cube,
    required this.horizontalRotateController,
  });

  Future<void> rotateBottom({bool clockWise = true}) async {
    targetFace = CubeFaces.bottom;
    notifyListeners();
    await horizontalRotateController.forward();
    horizontalRotateController.reset();
    horizontalRotate(0,clockWise: clockWise);
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
