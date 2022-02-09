import 'package:flutter/material.dart';
import 'package:zflutter_gallery/chess/ui/chess_game.dart';

class Chess extends StatelessWidget {
  const Chess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xffd19a75), Color(0xff04060a)],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1, 1),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ChessGame(),
        ),
      ),
    );
  }
}
