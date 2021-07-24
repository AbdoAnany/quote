import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:quote/item/quotel_card.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quote/models/dbHelper.dart';
import '../item/FadeAnimation.dart';
import '../models/product_item.dart';
import 'add_quote.dart';
import 'detail_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DbHelper dbHelper;
  int x = 0;
  // final adState = AdState(infuture);

 /** final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-4604195146685998/8502808729',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );**/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DbHelper();
   // myBanner..load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //myBanner.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder(
          future: dbHelper.allDateItem(),
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
                      child: QuoteCard(productItem: item,),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent.withOpacity(.1),
        child: Icon(
          Icons.create,
          size: 30,
        ),
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuote()),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
      //  child: AdWidget(ad: myBanner),
      ),
    ));
  }


}
