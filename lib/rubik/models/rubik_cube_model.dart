import 'package:flutter/material.dart';
import 'package:zflutter_gallery/rubik/models/rubik_cell.dart';
import 'dart:math';

class RubikCubitModel {
  late final List<List<List<CubeCell>>> cells;
  final int size;

  int get cellsCount =>
      ((2 * pow(size, 2)) + ((size - 2) * (pow(size, 2) - pow(size - 2, 2))))
          .toInt();

  RubikCubitModel(this.size) {
    cells = List.generate(
        size,
        (i) => List.generate(
            size, (j) => List.generate(size, (k) => _initCell(i,j,k))));
  }

  CubeCell _initCell(int layer, int frontPosition, int leftSidePosition) {
    final cell = CubeCell(
      topColor: layer == size-1 ? RubikCubeColors.topColor : RubikCubeColors.blank,
      bottomColor: layer == 0 ? RubikCubeColors.bottomColor : RubikCubeColors.blank,
      leftColor: frontPosition==0 ? RubikCubeColors.leftColor : RubikCubeColors.blank,
      rightColor: frontPosition==size-1 ? RubikCubeColors.rightColor : RubikCubeColors.blank,
      frontColor: leftSidePosition==0 ? RubikCubeColors.frontColor : RubikCubeColors.blank,
      backColor: leftSidePosition==size-1 ? RubikCubeColors.backColor : RubikCubeColors.blank,
    );
    return cell;
  }

  void horizontalRotate(int layer , {bool clockWise = true}){
    final layerCells = List.generate(size, (i)=>List.generate(size , (j)=>cells[layer][i][j]));
    for(int i = 0 ; i < size ; i++){
      for(int j = 0 ; j < size ; j++){
        cells[layer][i][j] = layerCells[j][i];
        final currentCell = cells[layer][i][j];
        cells[layer][i][j] = currentCell.copyWith(
          leftColor: clockWise?currentCell.frontColor:currentCell.backColor,
          backColor: clockWise?currentCell.leftColor:currentCell.rightColor,
          rightColor: clockWise?currentCell.backColor:currentCell.frontColor,
          frontColor: clockWise?currentCell.rightColor:currentCell.leftColor
        );
      }
    }
    for(int i = 0 ; i < size ; i++){
      for(int j = 0 ; j <= size/2 ; j++){
        if(clockWise){
          final temp = cells[layer][i][j];
          cells[layer][i][j] = cells[layer][i][size-j-1];
          cells[layer][i][size-j-1] = temp;
        }
        else{
          final temp = cells[layer][j][i];
          cells[layer][j][i] = cells[layer][size-1-j][i];
          cells[layer][size-1-j][i] = temp;
        }

      }
    }
  }

  void verticalSideRotate(int side , {bool clockWise = true}){
    final layerCells = List.generate(size, (i)=>List.generate(size , (j)=>cells[i][side][j]));
    for(int i = 0 ; i < size ; i++){
      for(int j = 0 ; j < size ; j++){
        cells[i][side][j] = layerCells[j][i];
        final currentCell = cells[i][side][j];
        cells[i][side][j] = currentCell.copyWith(
          topColor: clockWise?currentCell.frontColor:currentCell.backColor,
          frontColor: clockWise?currentCell.bottomColor:currentCell.topColor,
          bottomColor: clockWise?currentCell.backColor:currentCell.frontColor,
          backColor: clockWise?currentCell.topColor:currentCell.bottomColor
        );
      }
    }
    for(int i = 0 ; i < size ; i++){
      for(int j = 0 ; j <= size/2 ; j++){
        if(clockWise){
          final temp = cells[j][side][i];
          cells[j][side][i] = cells[size-1-j][side][i];
          cells[size-1-j][side][i] = temp;
        }
        else{
          final temp = cells[i][side][j];
          cells[i][side][j] = cells[i][side][size-j-1];
          cells[i][side][size-j-1] = temp;
        }
      }
    }
  }

  void verticalFaceRotate(int face , {bool clockWise = true}){
    final layerCells = List.generate(size, (i)=>List.generate(size , (j)=>cells[i][j][face]));
    for(int i = 0 ; i < size ; i++){
      for(int j = 0 ; j < size ; j++){
        cells[i][j][face] = layerCells[j][i];
        final currentCell = cells[i][j][face];
        cells[i][j][face] = currentCell.copyWith(
          topColor: clockWise?currentCell.leftColor:currentCell.rightColor,
          rightColor: clockWise?currentCell.topColor:currentCell.bottomColor,
          bottomColor: clockWise?currentCell.rightColor:currentCell.leftColor,
          leftColor: clockWise?currentCell.bottomColor:currentCell.topColor

        );
      }
    }
    for(int i = 0 ; i < size ; i++){
      for(int j = 0 ; j <= size/2 ; j++){
        if(clockWise){
          final temp = cells[j][i][face];
          cells[j][i][face] = cells[size-1-j][i][face];
          cells[size-1-j][i][face] = temp;
        }
        else{
          final temp = cells[i][j][face];
          cells[i][j][face] = cells[i][size-j-1][face];
          cells[i][size-j-1][face] = temp;
        }
      }
    }
  }

  void shuffle(){
    const moves = 10;
    final randGenerator = Random();
    for(int move = 0 ; move < moves ; move++){
      final layerMove = randGenerator.nextInt(size-1);
      final faceMove = randGenerator.nextInt(size-1);
      final sideMove = randGenerator.nextInt(size-1);
      horizontalRotate(layerMove , clockWise: randGenerator.nextBool());
      verticalSideRotate(sideMove , clockWise: randGenerator.nextBool());
      verticalFaceRotate(faceMove , clockWise: randGenerator.nextBool());
    }
  }

  bool get didWin{
    for(int i = 0 ; i < size ; i++){
      for(int j = 0 ; j < size ; j++){
        if(cells[0][i][j].bottomColor != RubikCubeColors.bottomColor) {
          return false;
        }
        if(cells[size-1][i][j].topColor != RubikCubeColors.topColor) {
          return false;
        }
        if(cells[i][0][j].leftColor != RubikCubeColors.leftColor) {
          return false;
        }
        if(cells[i][size-1][j].rightColor != RubikCubeColors.rightColor) {
          return false;
        }
        if(cells[i][j][0].frontColor != RubikCubeColors.frontColor) {
          return false;
        }
        if(cells[i][j][size-1].backColor != RubikCubeColors.backColor) {
          return false;
        }
      }
    }
    return true;
  }
}

class RubikCubeColors {
  static const frontColor = Color(0xff009C46);
  static const rightColor = Color(0xffB80830);
  static const backColor = Color(0xff0044AE);
  static const leftColor = Color(0xffFF5800);
  static const bottomColor = Color(0xffFED602);
  static const topColor = Color(0xffFFFFFF);
  static const blank = Color(0xff000000);
  //static const blank = Colors.transparent;
}

enum CubeFaces{
  font , back , left , right , top , bottom
}
