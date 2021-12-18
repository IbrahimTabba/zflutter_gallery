import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:zflutter_gallery/rubik/controllers/cube_controller.dart';

class GameAppbar extends StatelessWidget implements PreferredSizeWidget {
  final CubeController controller;

  const GameAppbar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
      title: controller.gameState == GameState.started
          ? StreamBuilder<int>(
              stream: controller.timerStream,
              initialData: 0,
              builder: (context, snapshot) {
                final value = snapshot.data ?? 0;
                final displayTime = StopWatchTimer.getDisplayTime(value,
                    hours: false, milliSecond: false);
                return Text(
                  displayTime,
                  style: const TextStyle(fontSize: 24),
                );
              },
            )
          : Container(),
      actions: controller.gameState == GameState.started
          ? [
              const SizedBox(
                width: 16,
              ),
              IconButton(
                icon: const Icon(Icons.pause),
                onPressed: () {
                  controller.pauseGame();
                },
                tooltip: 'Pause Game',
              ),
              const SizedBox(
                width: 8,
              ),
              IconButton(
                icon: const Icon(Icons.shuffle),
                onPressed: () {
                  controller.shuffle();
                },
                tooltip: 'Shuffle Cube',
              ),
              const SizedBox(
                width: 16,
              )
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
