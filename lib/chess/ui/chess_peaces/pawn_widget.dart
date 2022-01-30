import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';
import 'package:zflutter_gallery/chess/ui/chess_peaces/base.dart';

class PawnWidget extends StatelessWidget {
  final Color color;
  final double scale;


  const PawnWidget({Key? key, required this.color, this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final color = Color(0xff383838);
    return ZGroup(
      children: [
        ChessBottomBase(color: color,height: 40,),
        ZPositioned(
          translate: ZVector.only(y: -32),
          rotate: ZVector.only(x: tau/4),
          child: ZCircle(
            diameter: 18,
            stroke: 6 * scale,
            color: color,
          ),
        ),
        ZPositioned(
          translate: ZVector.only(y: -40),
          child: ZShape(
            stroke: 20 * scale,
            color: color,
          ),
        ),
        // ZPositioned(
        //   translate: ZVector.only(z: 10),
        //   child: ZToBoxAdapter(
        //     width: 20,
        //     height: 60,
        //     child: InkWell(
        //       onTap: (){
        //         showDialog(context: context , builder: (context)=>Container(width: 100 , height: 100 , color: Colors.yellow,));
        //       },
        //       child: Container(
        //         width: 20,
        //         height: 60,
        //         color: Colors.red,
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
