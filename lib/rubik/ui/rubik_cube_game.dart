import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/rubik/controllers/cube_controller.dart';
import 'package:zflutter_gallery/rubik/input/gesture_input.dart';
import 'package:zflutter_gallery/rubik/models/rubik_cube_model.dart';
import 'package:zflutter_gallery/rubik/ui/game_appbar.dart';
import 'package:zflutter_gallery/rubik/ui/rubik_cube.dart';
import 'package:zflutter_gallery/rubik/ui/tutorial/game_tutorial.dart';

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

  final double cubeCellSize = 50;

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
    double cubeSize = (cubeCellSize * (widget.cubeSize + 1));
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, cube, _) => Scaffold(
        backgroundColor: Colors.black,
        appBar: GameAppbar(
          controller: controller,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            GameGestureInput(
              active: controller.gameState == GameState.started &&
                  controller.gameState != GameState.paused &&
                  controller.gameState != GameState.win,
              controller: controller,
              gameSize: cubeSize,
              child: SizedBox(
                height: cubeSize,
                width: cubeSize,
                child: Center(
                  child: RubikCube(
                    controller: controller,
                    horizontalRotateAnimation: horizontalRotateAnimation,
                    faceRotateAnimation: faceRotateAnimation,
                    sideRotateAnimation: sideRotateAnimation,
                    cubeCellSize: cubeCellSize,
                    onYRotationChanged: (rotation) {
                      controller.rotationOffset = rotation;
                    },
                  ),
                ),
              ),
            ),
            if (controller.gameState == GameState.notStarted)
              _gameAction(
                icon: Icons.play_circle,
                text: 'Start',
                action: () async {
                  if (!(GetIt.I
                      .get<SharedPreferences>()
                      .getBool('tutorial_shown') ??
                      false)) {
                    final result = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const GameTutorial();
                        });
                    if (!((result != null && result is bool && result))) {
                      return;
                    }
                    GetIt.I
                        .get<SharedPreferences>()
                        .setBool('tutorial_shown', true);
                  }
                  controller.startGame();
                  controller.shuffle();
                },
              ),
            if (controller.gameState == GameState.paused)
              _gameAction(
                icon: Icons.play_circle,
                text: 'Resume',
                action: () {
                  controller.resumeGame();
                },
              ),
            if (controller.gameState == GameState.win)
              _gameAction(
                icon: Icons.replay_circle_filled,
                text: 'Retry',
                action: () async {
                  controller.startGame();
                  controller.shuffle();
                },
              ),
            if (kIsWeb)
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: InkWell(
                  onTap: () async {
                    if (await canLaunch(
                        'https://play.google.com/store/apps/details?id=com.ibrahim.zrubikscube')) {
                      launch(
                          'https://play.google.com/store/apps/details?id=com.ibrahim.zrubikscube');
                    }
                  },
                  child: SizedBox(width: 200,child: Image.asset('assets/images/google-play-badge.png')),
                ),
              )
          ],
        ),
      ),
    );
  }

  _initAnimations() {
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

  Widget _gameAction(
      {required IconData icon,
        required String text,
        required Function()? action}) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: true,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 38),
          child: InkWell(
            onTap: action,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 34,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 48),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
