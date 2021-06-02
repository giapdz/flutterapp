import 'package:flutter/material.dart';
import 'package:HotelsHN/ui/screens/category_item.dart';
import 'package:HotelsHN/fake_data.dart';

// class CategoriesPage extends StatefulWidget {
//   const CategoriesPage();
//
//   @override
//   State<StatefulWidget> createState() => CategoriesState();
// }
class CategoriesPage extends StatelessWidget {
  static const String routeName = '/CategoriesPage';
  // class CategoriesState extends State<CategoriesPage> {
  // CategoriesState();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khách sạn Hà Nội',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(

      child: GridView(
      padding: EdgeInsets.all(12),
      children: FAKE_CATEGORIES.map((eachCategory) => CategoryItem(category: eachCategory)).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 3/2, //width / height
        crossAxisSpacing: 12,
        mainAxisSpacing: 12
      ),
    )
    ),
    );
  }
}