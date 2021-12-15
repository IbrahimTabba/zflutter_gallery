import 'dart:ui';

class CubeCell {
  final Color? frontColor;
  final Color? backColor;
  final Color? rightColor;
  final Color? leftColor;
  final Color? topColor;
  final Color? bottomColor;

  CubeCell({
    this.frontColor,
    this.backColor,
    this.rightColor,
    this.leftColor,
    this.topColor,
    this.bottomColor,
  });

  CubeCell copyWith({
    frontColor,
    backColor,
    rightColor,
    leftColor,
    topColor,
    bottomColor,
  }) {
    return CubeCell(
        frontColor: frontColor ?? this.frontColor,
        backColor: backColor ?? this.backColor,
        topColor: topColor ?? this.topColor,
        bottomColor: bottomColor ?? this.bottomColor,
        leftColor: leftColor ?? this.leftColor,
        rightColor: rightColor ?? this.rightColor
    );
  }
}
