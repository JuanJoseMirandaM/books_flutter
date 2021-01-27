import 'package:flutter/material.dart';

class Book {
  String id;
  String title;
  String author;
  String category;
  String description;
  String urlPdf;
  String urlImage;
  int likes;
  bool liked;
  int views;

  Book({
    Key key,
    @required this.id,
    @required this.title,
    @required this.author,
    this.category,
    @required this.description,
    this.urlPdf,
    this.urlImage,
    this.likes,
    this.liked,
    this.views
  });
}