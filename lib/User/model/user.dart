import 'package:books/Book/model/book.dart';
import 'package:flutter/material.dart';

class User{
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final List<Book> myFavoriteBooks;

  User({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoURL,
    this.myFavoriteBooks
  });

}