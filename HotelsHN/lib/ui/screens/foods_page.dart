import 'package:flutter/material.dart';
import 'package:HotelsHN/fake_data.dart';
import 'package:HotelsHN/models/category.dart';
import 'package:HotelsHN/models/hotel.dart';
import 'detail_food_page.dart';

class FoodsPage extends StatelessWidget {
  static const String routeName = '/FoodsPage';
  Category category;
  FoodsPage({this.category});
  @override
  Widget build(BuildContext context) {
    Map<String, Category> arguments = ModalRoute.of(context).settings.arguments;
    this.category = arguments['category'];
    //Filter foods of from category
    List<Hotel> hotels = FAKE_HOTELS.where((hotel) => hotel.categoryId == this.category.id).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(' ${category.content}'),
      ),
      body: Center(
        child: Center(
          child: hotels.length > 0 ? ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                //We will continue in the next lesson
                Hotel hotel = hotels[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => DetailFoodPage(hotel: hotel)//send params using "constructor"
                        )
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          clipBehavior: Clip.hardEdge,
                          child: Center(
                            child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image: hotel.urlImage
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,left: 10,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(color: Colors.white, width: 2)
                          ),
                          child: Row(
                            children: <Widget>[
                              Text('${hotel.evaluate} đặc biệt',
                                style: TextStyle(fontSize: 20, color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,right: 10,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Row(
                            children: <Widget>[
                              Text('${hotel.price} \₫ ',
                                style: TextStyle(fontSize: 20, color: Colors.white),),
                              Text('\n 1 đêm',
                                style: TextStyle(fontSize: 12, color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,left: 10,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          // decoration: BoxDecoration(
                          //   color: Colors.black45,
                          //   borderRadius: BorderRadius.circular(10),
                          //
                          // ),
                          child: Text('${hotel.name} ',
                            style: TextStyle(fontSize: 18, color: Colors.white),),
                        ),
                      ),
                      Positioned(
                        bottom: 15,left: 10,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          // decoration: BoxDecoration(
                          //     color: Colors.black45,
                          //     borderRadius: BorderRadius.circular(10),
                          //     border: Border.all(color: Colors.white, width: 2)
                          // ),
                          child: Row(
                            children: <Widget>[
                              Text('${hotel.star}',
                                style: TextStyle(fontSize: 12, color: Colors.white),),
                              Icon(Icons.star, color: Colors.white, size: 15,),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          ):
          Text('No hotels found',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        )
      ),
    );
  }
}