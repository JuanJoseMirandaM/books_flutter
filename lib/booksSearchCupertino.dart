import 'package:books/Book/ui/screens/search_books.dart';
import 'package:books/Book/ui/screens/home_books.dart';
import 'package:books/User/bloc/bloc_user.dart';
import 'package:books/User/ui/screens/profile_books.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class BooksSearchCupertino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.indigo),
                  title: Text("")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search, color: Colors.indigo),
                  title: Text("")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.indigo ),
                  title: Text("")
              ),
            ]
        ),

        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return BlocProvider(
                    child: HomeBooks(),
                    bloc: UserBloc());
                },
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return BlocProvider(
                      child: SearchBooks(),
                      bloc: UserBloc());
                },
              );
              break;
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context){
                  return BlocProvider(
                      child: ProfileBooks(),
                      bloc: UserBloc());
                },
              );
              break;

          }

        },
      ),
    );
  }

}