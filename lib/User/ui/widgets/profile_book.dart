import 'package:books/Book/model/book.dart';
import 'package:books/widgets/floating_action_button_green.dart';
import 'package:flutter/material.dart';
import 'package:books/User/ui/widgets/profile_book_info.dart';
import 'package:books/User/ui/widgets/profile_book.dart';

class ProfileBook extends StatelessWidget {

  Book book;

  ProfileBook(this.book);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final photoCard = Container(
      margin: EdgeInsets.only(
          top: 10.0,
          bottom: 70.0
      ),
      height: 400.0,
      width: screenWidth * 0.60,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(book.urlImage)
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.red,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: Offset(0.0, 5.0)
            )
          ]
      ),
    );

    return Stack(
      alignment: Alignment(0.9, 0.65),
      children: <Widget>[
        photoCard,
        // FloatingActionButtonGreen(iconData: Icons.favorite, onPressed: ()=>{},)
        ProfileBookInfo(book)
      ],
    );
  }

}