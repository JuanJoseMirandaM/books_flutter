import 'package:flutter/material.dart';
import 'package:books/Book/ui/screens/header_appbar.dart';
import 'package:books/Book/ui/widgets/description_book.dart';
import 'package:books/Book/ui/widgets/review_list.dart';

class HomeBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            DescriptionBook(),
            // ReviewList()
          ],
        ),
        HeaderAppBar()
      ],
    );
  }

}