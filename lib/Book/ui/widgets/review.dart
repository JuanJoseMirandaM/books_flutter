import 'package:flutter/material.dart';

class Review extends StatelessWidget {

  String pathImage = "assets/img/people.jpg";
  String name = "Varuna Yasas";
  String comment = "There is an amazing place in Sri Lanka";

  Review(this.pathImage, this.name, this.comment);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final userComment = Container(
      margin: EdgeInsets.only(
          left: 20.0
      ),

      child: Text(
        comment,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: "Lato",
            fontSize: 13.0
        ),

      ),

    );

    final userName = Container(
      margin: EdgeInsets.only(
          left: 20.0
      ),

      child: Text(
        name,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: "Lato",
            fontSize: 17.0,
            fontWeight: FontWeight.w900
        ),

      ),

    );

    final userDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        userName,
        userComment

      ],
    );

    final photo = Container (
      margin: EdgeInsets.only(
          top: 20.0,
          left: 20.0
      ),

      width: 80.0,
      height: 80.0,

      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(pathImage)
          )
      ),

    );

    return Row (
      children: <Widget>[
        photo,
        userDetails

      ],
    );

  }

}