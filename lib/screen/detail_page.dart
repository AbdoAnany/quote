import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:quote/item/utils.dart';
import 'package:quote/item/widget_to_image.dart';
import 'package:quote/models/product_item.dart';

class PageDescription extends StatefulWidget {
 late ProductItem productItem;

  PageDescription(ProductItem productItem) {
    this.productItem = productItem;
  }
  @override
  _PageDescriptionState createState() => _PageDescriptionState(productItem);
}

class _PageDescriptionState extends State<PageDescription> {
 late ProductItem productItem;
 late  GlobalKey key;
 late Uint8List bytes;
  _PageDescriptionState(ProductItem productItem) {
    this.productItem = productItem;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: WidgetToImage(
          builder: (key) {
            this.key = key;
            return Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    child: Text(
                      productItem.title,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: 'Adine',
                          fontWeight: FontWeight.bold,
                          fontSize: 70,
                          color: Color(productItem.font_color)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 50, right: 50, left: 50, bottom: 50),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              productItem.image,
                            ),
                            fit: BoxFit.fill)),
                    child: Text(
                      productItem.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Anton',
                          color: Color(productItem.font_color),
                          fontSize: 25),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bytes = await Utils.capture(key);
          setState(() {
            this.bytes = bytes;
          });
          final success = await ImageGallerySaver.saveImage(
            bytes,
            isReturnImagePathOfIOS: true,
          );

      //    if(success['isSuccess'])
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(milliseconds: 3000),
              backgroundColor: Colors.black,
              content: Text(
                'Quote Saved',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )));
        },
        tooltip: 'Increment',
        child: Icon(Icons.save_alt),
      ),
    ));
  }

  Widget buildImage(Uint8List bytes) =>
      bytes != null ? Image.memory(bytes) : Container();
}
