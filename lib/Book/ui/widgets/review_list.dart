import 'package:flutter/material.dart';
import 'package:books/Book//ui/widgets/review.dart';

class ReviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Review("assets/img/people.jpg", "Varuna Yasas", "There is an amazing place in Sri Lanka"),
        Review("assets/img/ann.jpg", "Anahí Salgado", "There is an amazing place in Sri Lanka"),
        Review("assets/img/girl.jpg", "Gissele Thomas", "There is an amazing place in Sri Lanka"),

      ],
    );
  }

}