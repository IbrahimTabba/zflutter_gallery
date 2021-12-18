import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class TutorialPage1 extends StatelessWidget {
  const TutorialPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animations/64919-swipe-gesture-left.json',
          width: 100,
          height: 100,
          reverse: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Lottie.asset(
                'assets/animations/64918-swipe-gesture-up.json',
                height: 100,
                width: 100,
                reverse: true,
              ),
            ),
            SvgPicture.asset(
              'assets/svg/rubik_s_cube.svg',
              width: 150,
              height: 150,
            ),
            Expanded(
              child: Lottie.asset(
                'assets/animations/64917-swipe-down-gesture.json',
                height: 100,
                width: 100,
                reverse: true,
              ),
            ),
          ],
        ),
        Lottie.asset(
          'assets/animations/64920-swipe-gesture-right.json',
          width: 100,
          height: 100,
          reverse: true,
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Swipe screen part that faces the desired cube side',
          style: TextStyle(color: Colors.white, fontSize: 24),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
