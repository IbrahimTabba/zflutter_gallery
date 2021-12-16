import 'package:flutter/material.dart';
import 'package:zflutter_gallery/rubik/ui/rubik_cube.dart';
import 'package:zflutter_gallery/rubik/ui/rubik_cube_game.dart';
import 'package:zflutter_gallery/wall-e.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        backgroundColor: Colors.black,
        body: RubikCubeGame(cubeSize: 3,),
      ),
    );
  }
}
