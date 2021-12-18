import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class TutorialPage2 extends StatelessWidget {
  const TutorialPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 100,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Stack(
              children: [
                SvgPicture.asset(
                  'assets/svg/rubik_s_cube.svg',
                  width: 150,
                  height: 150,
                ),
                Positioned(
                    bottom: 0,
                    left: 25,
                    child: Lottie.asset(
                      'assets/animations/23081-tap.json',
                      height: 100,
                    ),
                )
              ],
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Tap or double Tap front face to rotate it clockwise and counterclockwise',
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
