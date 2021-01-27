import 'package:books/User/bloc/bloc_user.dart';
import 'package:books/User/model/user.dart';
import 'package:books/booksSearchCupertino.dart';
import 'package:books/widgets/button_green.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:books/widgets/gradient_back.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:books/User/model/user.dart' as Model;


class SignInScreen extends StatefulWidget {

  @override
  State createState() {
    return _SignInScreen();
  }
}


class _SignInScreen extends State<SignInScreen> {

  UserBloc userBloc;
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screenWidth = MediaQuery.of(context).size.width;
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData || snapshot.hasError) {
          return signInGoogleUI();
        }else{
          return BooksSearchCupertino();
        }
      }
    );
  }

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(height: null,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 350.0,
                child: Image.asset(
                  "assets/img/logos.png",
                  fit: BoxFit.contain,
                ),
              ),
              // Flexible(
              //     child: Container(
              //       width: screenWidth,
              //       child: Text("GESTOR DE DESCARGA DE UNA BIBLIOTECA",
              //         style: TextStyle(
              //             fontSize: 37.0,
              //             fontFamily: "Lato",
              //             color: Colors.white,
              //             fontWeight: FontWeight.bold
              //         ),
              //       ),
              //     )
              // ),
              // SizedBox(height: 15.0),
              ButtonGreen(
                text: "Login with Gmail",
                onPressed: (){
                  userBloc.signOut();
                  userBloc.sigIn().then((Firebase.User user) {
                    userBloc.updateUserData(Model.User(
                      uid: user.uid,
                      name: user.displayName,
                      email: user.email,
                      photoURL: user.photoURL
                    ));
                  });
                },
                width: 300.0,
                height: 50.0,
              ),
              // SignInButton(
              //   Buttons.Google,
              //   onPressed: () {},
              // )
            ],
          )
        ],
      ),
    );
  }


}