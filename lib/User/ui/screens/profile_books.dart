import 'package:books/User/bloc/bloc_user.dart';
import 'package:books/User/model/user.dart';
import 'package:books/User/ui/widgets/profile_books_list.dart';
import 'package:flutter/material.dart';
import 'package:books/User/ui/screens/profile_header.dart';
import 'package:books/User/ui/widgets/profile_background.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileBooks extends StatelessWidget {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
          case ConnectionState.none:
            return CircularProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.done:
            return showProfileData(snapshot);

          default:

        }
      },
    );

    // return Stack(
    //   children: <Widget>[
    //     ProfileBackground(),
    //     ListView(
    //       children: <Widget>[
    //         ProfileHeader(),
    //         ProfileBooksList()
    //
    //       ],
    //     ),
    //   ],
    // );

  }

  Widget showProfileData(AsyncSnapshot snapshot){
    if(!snapshot.hasData || snapshot.hasError){
      print("No logeado");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              Text("Usuario no logeado. Haz Login")

            ],
          ),
        ],
      );
    }else {
      print("Logeado");
      print(snapshot.data);
      var user = User(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL
      );

      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              ProfileHeader(user),//User datos
              ProfileBooksList(user)//User uid

            ],
          ),
        ],
      );
    }

  }

}