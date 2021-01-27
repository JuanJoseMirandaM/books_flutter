import 'package:books/User/bloc/bloc_user.dart';
import 'package:books/User/ui/screens/sign_in_screen.dart';
import 'package:books/booksSearchCupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: UserBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          home: SignInScreen(),
        )
    );

  }
}