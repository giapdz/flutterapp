import 'package:flutter/material.dart';
import 'package:foodapp/models/food.dart';
import 'package:foodapp/ui/screens/map.dart';
class DetailFoodPage extends StatelessWidget {
  Hotel hotel;
  DetailFoodPage({this.hotel});
  @override
  Widget build(BuildContext context) {
    print('Convenients : ${hotel.Convenients}');
    return Scaffold(
      appBar: AppBar(title: Text('${hotel.name}'),),
      body:
          ListView(
            children: <Widget>[
              Column(
              children: <Widget>[
               Center(
               child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: hotel.urlImage,
              )
               ),
               Row(
                 children: <Widget>[
                  Container(
                   padding: EdgeInsets.symmetric(vertical: 10),
                   child: Text('Vị trí',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ]
               ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('${hotel.Location}',style: TextStyle(fontSize: 18)),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
           TextButton (
                    child: Text('Xem trên bản đồ',style: TextStyle(fontSize: 18),),
                    onPressed: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                  builder: (context) => FullMap()//send params using "constructor"
                  )
                  );
                 },
                  )
                 ]

                ),

              //  Expanded(
              //  child: Text('${hotel.Location}',style: TextStyle(fontSize: 22)),
              // ),
                Row(

                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('Đánh giá',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ]
                ),
                Container(
                child: Text('${hotel.evaluate}',style: TextStyle(fontSize: 22, color: Colors.green)),
                ),
                Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('Tiện ích',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ]
                ),
                    Column(
                    children: <Widget>[
                     ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: this.hotel.Convenients.length,
                      itemBuilder: (context, index) {
                      String convenient = this.hotel.Convenients[index];return ListTile(
                         leading: CircleAvatar(
                         child: Text('${index+1}', style: TextStyle(fontSize: 19, color: Colors.black),),
                       ),
                        title: Text(convenient, style: TextStyle(fontSize: 20),),
                  );
                }
            ),
            ]
                    )
        ],
      )
    ]
    )


    );

  }
}