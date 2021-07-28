import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/components/quotel_card.dart';
import 'package:quote/control/auth_provider.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../components/FadeAnimation.dart';
import '../models/product_item.dart';
import 'add_quote.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pro = ChangeNotifierProvider((ref) => AuthProvider());
    AuthProvider().borderLists();

    return SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff504944),
                  Colors.black54,
                ],
              ),
            ),
            child: Consumer(
              builder: (context, watch, _) {
                var river = watch(pro);
                return FutureBuilder(
                  future: river.allDateItem(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null)
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          backgroundColor: Colors.white,
                        ),
                      );
                    if (snapshot.data == [])
                      return Center(
                        child: Text(
                          'No Quote',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      );
                    if (snapshot.data.isNotEmpty) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            ProductItem item =
                            ProductItem.fromMap(snapshot.data[index]);
                            return FadeAnimation(
                              fadeDirection: FadeDirection.bottom,
                              delay: 2 + index / 5,
                              child: QuoteCard(
                                productItem: item,
                              ),
                            );
                          });
                    }
                    return Center(
                      child: Text(
                        'No Quote',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.transparent.withOpacity(0),
            child: Icon(
              Icons.create,
              size: 30,
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddQuote()),
              );
            },
          ),
          // bottomNavigationBar: Container(
          //   height: 50,
          // //  child: AdWidget(ad: myBanner),
          // ),
        ));
  }
}

