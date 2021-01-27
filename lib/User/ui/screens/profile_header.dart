import 'package:books/User/bloc/bloc_user.dart';
import 'package:books/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:books/User/ui/widgets/user_info.dart';
import 'package:books/User/ui/widgets/button_bar.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileHeader extends StatelessWidget {

  User user;

  ProfileHeader(@required this.user);

  @override
  Widget build(BuildContext context) {
    final title = Text(
      'Profile',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0
      ),
    );

    return Container(
      margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 50.0
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              title
            ],
          ),
          UserInfo(user),
          ButtonsBar()
        ],
      ),
    );

  }

  Widget showProfileData(AsyncSnapshot snapshot){
    if(!snapshot.hasData ||snapshot.hasError){
      print("No logueado");
      return Container(
        margin: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 50.0
        ),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("No se pudo cargar la informacion. Haz loguin")
          ],
        ),
      );
    }else{
      print("logueado");
      print(snapshot.data);
      user = User(name: snapshot.data.displayName, email: snapshot.data.email, photoURL: snapshot.data.photoURL);
      final title = Text(
        'Profile',
        style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0
        ),
      );

      return Container(
        margin: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 50.0
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                title
              ],
            ),
            UserInfo(user),
            ButtonsBar()
          ],
        ),
      );
    }
  }

}
