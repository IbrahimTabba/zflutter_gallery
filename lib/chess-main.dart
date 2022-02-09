import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zflutter_gallery/chess/ui/chess.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  if(!kIsWeb && Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  runApp(const ChessApp());
}

class ChessApp extends StatelessWidget {
  const ChessApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ZChess",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'VT323',
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(const Color(0xffffffff)),
                  overlayColor: MaterialStateProperty.all<Color>(const Color(0xffffffff).withOpacity(0.3)),
                  textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                    color: Colors.white,
                    fontFamily: 'VT323',
                  ))
                //padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 9 , horizontal: 17))
              )
          )
      ),
      debugShowCheckedModeBanner: false,
      home: const Chess(),
    );
  }
}
