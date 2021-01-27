import 'package:books/Book/model/book.dart';
import 'package:flutter/material.dart';
import 'package:books/widgets/floating_action_button_green.dart';

class ProfileBookInfo extends StatelessWidget {

  Book book;

  ProfileBookInfo(this.book);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final book = Text(
      this.book.title,
      style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
    );

    final bookInfo = Padding(
        padding: EdgeInsets.symmetric(
            vertical: 10.0
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.book.author,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                this.book.category,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    fontFamily: 'Lato',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold
                ),
              )
            ]
        )
    );

    final steps = Text(
      'Like: ${this.book.likes}',
      style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.amber
      ),
    );

    final card = Container(
      width: screenWidth * 0.60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white60 ,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: Offset(0.0, 5.0)
            )
          ]
      ),
      child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              book,
              bookInfo,
              steps
            ],
          )
      ),
    );

    return Stack(
      alignment: Alignment(0.9, 0.75),
      children: <Widget>[
        card,
        FloatingActionButtonGreen(iconData: Icons.favorite, onPressed: ()=>{},)
      ],
    );
  }

}