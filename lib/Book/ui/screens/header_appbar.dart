import 'package:books/User/bloc/bloc_user.dart';
import 'package:books/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:books/widgets/gradient_back.dart';
import 'package:books/Book/ui/widgets/card_image_list.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    UserBloc userBloc;
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Center(child: CircularProgressIndicator(),);
          case ConnectionState.active:
          case ConnectionState.done:
          default:
            return showPlacesData(snapshot);
        }
      },
    );
  }

  Widget showPlacesData(AsyncSnapshot snapshot){
    if(!snapshot.hasData || snapshot.hasError){
      return Stack(
        children: <Widget>[
          GradientBack(height: 350.0),
          Text("Usuario no logeado. Haz Login")
        ],
      );
    } else {
      User user = User(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL
      );

      return Stack(
        children: <Widget>[
          GradientBack(height: 350.0),
          CardImageList(user)
        ],
      );
    }
  }

}