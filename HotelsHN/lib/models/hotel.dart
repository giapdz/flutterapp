import 'dart:math';
import 'package:wemapgl/wemapgl.dart';
import 'category.dart';
import 'package:flutter/cupertino.dart';
class Hotel {
  int id;
  String name;
  String urlImage;
  double evaluate; //time to finish this food
  int price;
  double star;
  String Location;
  //one foods has many ingredients
  List<String> Convenients = List<String>();
  LatLng coordinate;
  //reference: 1 Category has many Foods
  int categoryId;
  //constructor:
  Hotel({
    @required this.name,
    @required this.urlImage,
    @required this.evaluate,
    this.price,
    @required this.star,
    this.Location,
    this.coordinate,
    this.Convenients,
    this.categoryId,
  }) {
    //id is "auto-increment"
    this.id = Random().nextInt(1000);
  }
}

