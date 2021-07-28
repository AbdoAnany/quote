import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:quote/control/auth_provider.dart';
import 'package:quote/models/product_item.dart';

class AddQuote extends StatefulWidget {
  @override
  _AddQuoteState createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  late TextEditingController title, description;
  Color pickerColor = Color(0xffffffff);
  Color pickerColor1 = Color(0xffffffff);
  Color currentColor = Color(0xffffffff);
  Color fontColor = Color(0xff000000);
  int count = 0;
  late File filepicker;
  late ProductItem productItem;
  var pro = AuthProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = TextEditingController();
    description = TextEditingController();
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void changeColor1(Color color) {
    setState(() => pickerColor1 = color);
  }

  void counter(x) {
    setState(() {
      if (x == '+' && count < borderList.length - 1)
        count = count + 1;
      else if (x == '-' && count > 0) count = count - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //   backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: fontColor,
                    child: TextButton(
                      child: const Text(
                        'F',
                      ),
                      onPressed: () {
                        fontColors();
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: currentColor,
                    child: TextButton(
                      child: const Text('Bg'),
                      onPressed: () {
                        pickerColors();
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12, bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: fontColor),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: null,
                    prefixIcon: Icon(
                      Icons.supervisor_account_outlined,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12, bottom: 20),
                padding:
                    EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: currentColor,
                    image: DecorationImage(
                        image: NetworkImage(borderList[count]),
                        fit: BoxFit.fill,
                        alignment: Alignment.center),
                    boxShadow: [
                      BoxShadow(offset: Offset(10, 10), blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: description,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: fontColor),
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: TextButton(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        counter('-');
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: TextButton(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        counter('+');
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.black,
                child: TextButton(
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    if (title.text.isEmpty || description.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(milliseconds: 3000),
                          backgroundColor: Colors.black,
                          content: Text(
                            'Add Author and Quote',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )));
                    }

                    productItem = ProductItem.a(
                        title: title.text,
                        color: currentColor.value,
                        data: DateTime.now().toString(),
                        description: description.text,
                        font_color: fontColor.value,
                        type: 'sad',
                        saved: 0,
                        image: borderList[count]);

                    pro.addItem(productItem);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 3000),
                        backgroundColor: Colors.black,
                        content: Text(
                          'Quote Added',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  fontColors() {
    showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Font a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor1,
            onColorChanged: changeColor1,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() {
                fontColor = pickerColor1;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      context: context,
    );
  }

  pickerColors() {
    showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() {
                currentColor = pickerColor;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      context: context,
    );
  }
}
