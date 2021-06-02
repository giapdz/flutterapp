import 'package:flutter/material.dart';
import 'package:foodapp/models/food.dart';
import 'package:foodapp/models/category.dart';
const FAKE_CATEGORIES = const [
  Category(id: 1, content: 'Khách sạn 1-2 sao', color: Colors.deepOrange),
  Category(id: 2, content: 'Khách sạn 3-4 sao', color: Colors.teal),
  Category(id: 3, content: 'Khách sạn 5 sao', color: Colors.pink),
  Category(id: 4, content: 'Căn hộ', color: Colors.blueAccent),
  Category(id: 5, content: 'Kí túc xá', color: Colors.deepPurple),
  Category(id: 6, content: 'Nhà trọ', color: Colors.green),
];
var FAKE_HOTELS = [
  //array of food's objects
  Hotel(
      name: "Hanoi Canina Hotel",
      urlImage: "https://exp.cdn-hotels.com/hotels/46000000/45710000/45703600/45703586/3af3a977_z.jpg?impolicy=fcrop&w=702&h=468&q=high",
      evaluate: 9.7,
      price: 160000,
      star: 1,
      Location: '16A Ngõ Trung Yên, Hàng Bạc, Hoàn Kiếm, Hà Nội',
      Convenients: ['Máy sấy tóc', 'Điều hoà', 'Bồn tắm','Wifi'],
      categoryId: 1),
];