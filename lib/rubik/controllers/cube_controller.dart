import 'package:flutter/cupertino.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:synchronized/synchronized.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/rubik/models/rubik_cube_model.dart';

class CubeController extends ValueNotifier<RubikCubitModel> {
  final RubikCubitModel cube;
  final AnimationController horizontalRotateController;
  final AnimationController faceRotateController;
  final AnimationController sideRotateController;
  late final StopWatchTimer _stopWatchTimer;
  TargetMove? targetMove;
  double rotationOffset = 0.0;
  double get rotationsCount => rotationOffset/(tau/4);
  late GameState gameState;
  Stream<int> get timerStream => _stopWatchTimer.rawTime;

  final lock = Lock();

  CubeController({
    required this.cube,
    required this.horizontalRotateController,
    required this.faceRotateController,
    required this.sideRotateController,
  }):super(cube){
    _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp,);
    gameState = GameState.notStarted;
  }

  Future<void> rotateLayer({required int layer, bool clockWise = true}) async {
    await lock.synchronized(()async{
      targetMove = TargetMove(
          cubeAxis: CubeAxis.horizontal,
          moveIndex: layer,
          clockWise: clockWise
      );
      notifyListeners();
      await horizontalRotateController.forward();
      horizontalRotateController.reset();
      horizontalRotate(layer, clockWise: clockWise);
      validate();
    });
  }

  Future<void> rotateSide({required int side, bool clockWise = true}) async {

    await lock.synchronized(()async{
      targetMove = TargetMove(
          cubeAxis: CubeAxis.side,
          moveIndex: side,
          clockWise: clockWise
      );
      notifyListeners();
      await sideRotateController.forward();
      sideRotateController.reset();
      verticalSideRotate(side, clockWise: clockWise);
      validate();
    });
  }

  Future<void> rotateFace({required int face, bool clockWise = true}) async {
    await lock.synchronized(()async{
      targetMove = TargetMove(
          cubeAxis: CubeAxis.vertical,
          moveIndex: face,
          clockWise: clockWise
      );
      notifyListeners();
      await faceRotateController.forward();
      faceRotateController.reset();
      verticalFaceRotate(face, clockWise: clockWise);
      validate();
    });
  }

  Future<void> rotateBottom({bool clockWise = true}) async {
    await rotateLayer(layer: 0, clockWise: clockWise);
  }

  Future<void> rotateTop({bool clockWise = true}) async {
    await rotateLayer(layer: cube.size-1, clockWise: clockWise);
  }

  Future<void> rotateRight({bool clockWise = true}) async {
    if(rotationsCount > 0.5 && rotationsCount <= 1.5){
      return rotateFace(face: cube.size-1, clockWise: !clockWise);
    }
    else if(rotationsCount > 1.5 && rotationsCount <= 2.5){
      return rotateSide(side: 0, clockWise: !clockWise);
    }
    else if(rotationsCount > 2.5 && rotationsCount <= 3.5){
      return rotateFace(face: 0,clockWise: clockWise);
    }

    await rotateSide(side: cube.size-1, clockWise: clockWise);
  }

  Future<void> rotateLeft({bool clockWise = true}) async {
    if(rotationsCount > 0.5 && rotationsCount <= 1.5){
      return rotateFace(face: 0, clockWise: !clockWise);
    }
    else if(rotationsCount > 1.5 && rotationsCount <= 2.5){
      return rotateSide(side: cube.size-1,clockWise: !clockWise);
    }
    else if(rotationsCount > 2.5 && rotationsCount <= 3.5){
      return rotateFace(face: cube.size-1,clockWise: clockWise);
    }
    await rotateSide(side: 0, clockWise: clockWise);
  }

  Future<void> rotateFront({bool clockWise = true}) async {
    if(rotationsCount > 0.5 && rotationsCount <= 1.5){
      return rotateSide(side: cube.size-1, clockWise: clockWise);
    }
    else if(rotationsCount > 1.5 && rotationsCount <= 2.5){
      return rotateFace(face: cube.size-1,clockWise: !clockWise);
    }
    else if(rotationsCount > 2.5 && rotationsCount <= 3.5){
      return rotateSide(side: 0,clockWise: !clockWise);
    }
    await rotateFace(face: 0, clockWise: clockWise);
  }

  Future<void> rotateBack({bool clockWise = true}) async {
    await rotateFace(face: cube.size-1, clockWise: clockWise);
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

  void shuffle(){
    //cube.shuffle();
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    notifyListeners();
  }

  void startGame(){
    gameState = GameState.started;
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    notifyListeners();
  }

  void pauseGame(){
    gameState = GameState.paused;
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    notifyListeners();
  }

  void resumeGame(){
    gameState = GameState.started;
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    notifyListeners();
  }

  void validate(){
    final win = cube.didWin;
    if(win){
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      gameState = GameState.win;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    horizontalRotateController.dispose();
    faceRotateController.dispose();
    sideRotateController.dispose();
    _stopWatchTimer.dispose();
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

enum GameState{
  notStarted , started , paused , win
}