import 'package:books/Book/model/book.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {

  Book book;
  BookCard(this.book);
  double screenWidth;

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
        left: 10.0,
        right: 10.0,
      ),
      width: screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.black12
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
            Text(book.author)
          ],
        ),
      )
    );
  }
}
