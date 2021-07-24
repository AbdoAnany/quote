import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem {
 late String image, title, anime, type, description;
 late int color, font_color;
 late String data;
 late int saved;
 late int? amount, id;
  ProductItem.a({
     this.id,
    required this.data,
    required this.saved,
    required  this.font_color,
    required  this.description,
    required  this.type,
    required  this.image,
    required  this.color,
    required   this.title,
  });

  ProductItem(dynamic obj) {
    id = obj['id'];
    data = obj['data'];
    saved = obj['saved'];
    description = obj['description'];
    image = obj['image'];
    type = obj['type'];
    font_color = obj['font_color'];
    color = obj['color'];
    title = obj['title'];
  }
  ProductItem.fromMap(Map<String, dynamic> obj) {
    id = obj['id'];
    data = obj['data'];
    saved = obj['saved'];
    font_color = obj['font_color'];
    description = obj['description'];
    type = obj['type'];
    image = obj['image'];
    color = obj['color'];
    title = obj['title'];
  }
  Map<String, dynamic> toMaps() => {
        'id': id,
        'title': title,
        'data': data,
        'saved': saved,
        'description': description,
        'color': color,
        'type': type,
        'image': image,
        'font_color': font_color
      };
}

// [
// ' Intelligence',
// ' Fast',
// ' Strong',
// ' Magic',
// ' Power'
// ]
List<ProductItem> products = [
  ProductItem.a(
    title: " William W. Purkey",
    saved: 0,
    type: 'Sad',
    data: DateTime.now().toString(),
    color: 0xff000000,
    font_color: 0xff000000,
    image: "assets/s0.png",
    description:
        'You\'ve gotta dance like there\'s nobody watching,Love like you\'ll'
        ' never be hurt, Sing like there\'s nobody listening,And live like it\'s heaven on earth.'
        'You\'ve gotta dance like there\'s nobody watching,Love like you\'ll'
        ' never be hurt, Sing like there\'s nobody listening,And live like it\'s heaven on earth.',
  ),
  ProductItem.a(
    title: "Oscar Wilde",
    saved: 0,
    type: 'Sad',
    data: DateTime.now().toString(),
    color: 0xff000000,
    font_color: 0xff000000,
    image: "assets/s4.png",
    description: 'Be yourself; everyone else is already taken.',
  ),
  ProductItem.a(
    title: "Sheryl Sandberg",
    saved: 0,
    type: 'Sad',
    data: DateTime.now().toString(),
    color: 0xff000000,
    font_color: 0xff000000,
    image: "assets/s3.png",
    description:
        'If you\'re offered a seat on a rocket ship, don\'t ask what seat! Just get on.',
  ),
  ProductItem.a(
    title: "Les Brown",
    saved: 0,
    type: 'Sad',
    data: DateTime.now().toString(),
    color: 0xff000000,
    font_color: 0xff000000,
    image: "assets/s1.png",
    description:
        'Too many of us are not living our dreams because we are living our fears.',
  ),
  ProductItem.a(
    title: "Florence Nightingale",
    saved: 0,
    type: 'Sad',
    data: DateTime.now().toString(),
    color: 0xff000000,
    font_color: 0xff000000,
    image: "assets/s2.png",
    description:
        'I attribute my success to this: I never gave or took any excuse.',
  ),
];
