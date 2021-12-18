import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zflutter_gallery/rubik/ui/tutorial/tutorial_page_1.dart';
import 'package:zflutter_gallery/rubik/ui/tutorial/tutorial_page_2.dart';

class GameTutorial extends StatefulWidget {
  const GameTutorial({Key? key}) : super(key: key);

  @override
  State<GameTutorial> createState() => _GameTutorialState();
}

class _GameTutorialState extends State<GameTutorial> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey)),
        constraints: BoxConstraints(
          maxWidth: kIsWeb? 500 : double.infinity,
        ),
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0, bottom: 16),
        child: Material(
          color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            height: 550,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: (){
                      switch(currentIndex){
                        case 0:
                          return const TutorialPage1();
                        case 1:
                          return const TutorialPage2();
                        default:
                          return const TutorialPage1();
                      }
                    }.call(),
                  ),
                ),
                const SizedBox(height: 18,),
                Row(
                  children: [
                    if(currentIndex == 1)
                      TextButton(
                        child: const Text(
                          'Previous',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                      ),
                    const Spacer(),
                    TextButton(
                      child: Text(
                        currentIndex==1?'Start':'Next',
                        style: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if(currentIndex==1){
                          Navigator.of(context).pop(true);
                        }
                        else{
                          setState(() {
                            currentIndex++;
                          });
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
