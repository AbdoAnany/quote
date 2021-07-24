import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/models/dbHelper.dart';
import 'package:quote/screen/home.dart';
import '../models/product_item.dart';
import '../provider_preferences.dart';
import '../screen/detail_page.dart';

class AnimalCard extends StatelessWidget {
  final ProductItem productItem;
  AnimalCard({
    required this.productItem,
  });
 late DbHelper dbHeloer;

  @override
  Widget build(BuildContext context) {
    dbHeloer = DbHelper();
    Size _size = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, watch, _) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageDescription(productItem)),
          );
        },
        child: Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 20),
            height: 210,
            alignment: Alignment.center,
            width: _size.width < 700 ? 400 : 330,
            decoration: BoxDecoration(
                color: Color(productItem.color).withOpacity(1),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/s0.png',
                    ),
                    fit: BoxFit.contain),
                boxShadow: [
                  BoxShadow(
                      //color: Colors.white.withOpacity(0.3),
                      offset: Offset(10, 10),
                      blurRadius: 10)
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      dbHeloer.deleteDateItem(productItem.id);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    productItem.title,
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
