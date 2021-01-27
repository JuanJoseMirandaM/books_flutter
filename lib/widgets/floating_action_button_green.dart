import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {

  final IconData iconData;
  final VoidCallback onPressed;

  FloatingActionButtonGreen({
    Key key,
    @required this.iconData,
    @required this.onPressed
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingActionButtonGreen();
  }

}


class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen> {

  // bool _pressed = false;
  //
  // void _onPressedFav() {
  //   setState(() {
  //     _pressed = !this._pressed;
  //   });
  //   Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //           content: this._pressed ? Text("Agregaste a tus favoritos") : Text("Quitaste de tus favoritos")
  //       )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      backgroundColor: Color(0xFFFFC300),
      mini: true,
      tooltip: "Fav",
      onPressed: widget.onPressed,
      child: Icon(widget.iconData),
      heroTag: null,
    );
  }

}