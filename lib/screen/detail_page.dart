import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:quote/components//utils.dart';
import 'package:quote/components/widget_to_image.dart';
import 'package:quote/control/auth_provider.dart';
import 'package:quote/models/product_item.dart';

class PageDescription extends StatelessWidget {

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: WidgetToImage(
              builder: (key) {
                AuthProvider().key = key;
                return Container(


                 color: Color(  AuthProvider().productItem.color),

                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        alignment: Alignment.center,
                        child: Text(
                         AuthProvider(). productItem.title,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: 'Adine',
                              fontWeight: FontWeight.bold,
                              fontSize: 70,
                              color: Color(  AuthProvider().productItem.font_color)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 50, right: 50, left: 50, bottom: 50),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  AuthProvider(). productItem.image,
                                ),
                                fit: BoxFit.fill)),
                        child: Text(
                          AuthProvider(). productItem.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Anton',
                              color: Color(  AuthProvider().productItem.font_color),
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
          bool f = await AuthProvider().screenShot() ;

                  if(f)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(milliseconds: 3000),
                  backgroundColor: Colors.black,
                  content: Text(
                    'Quote Saved',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )));
                  if(!f)
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 3000),
                        backgroundColor: Colors.black,
                        content: Text(
                          'Permission denied',
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


