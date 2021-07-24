import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/models/dbHelper.dart';
import 'package:quote/screen/home.dart';
import '../models/product_item.dart';
import '../provider_preferences.dart';
import '../screen/detail_page.dart';

class QuoteCard extends StatelessWidget {
  final ProductItem productItem;
  QuoteCard({
    required this.productItem,
  });
 late DbHelper dbHelper;

  @override
  Widget build(BuildContext context) {
    dbHelper = DbHelper();
    Size _size = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, watch, _) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PageDescription(productItem)),
        ),
        child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 20),
            height: 210,
            width: 400,
            decoration: BoxDecoration(
                color: Color(productItem.color),
                image: DecorationImage(
                    image: AssetImage(
                      productItem.image,
                    ),
                    fit: BoxFit.fill,
                    alignment: Alignment.center),
                boxShadow: [BoxShadow(offset: Offset(10, 10), blurRadius: 10)],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black,
                      ),
                      onPressed: () {

                        dbHelper.deleteDateItem(productItem.id);

                      }),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    productItem.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Adine',
                        letterSpacing: 8,
                        fontWeight: FontWeight.w900,
                        fontSize: 60,
                        color: Color(productItem.font_color)),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
