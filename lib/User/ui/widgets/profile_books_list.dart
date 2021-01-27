import 'package:books/Book/model/book.dart';
import 'package:books/User/bloc/bloc_user.dart';
import 'package:books/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:books/User/ui/widgets/profile_book.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileBooksList extends StatelessWidget {

  UserBloc userBloc;
  User user;
  ProfileBooksList(@required this.user);

  Book book = new Book(
    title: "Los sueños se cumplen",
    author: "Rachel Galsan",
    category: "Ficción adulto joven",
    description: "",
    urlImage: "https://static.megustaleer.com/images/libros_650_x/EAL86031.jpg"
  );
  Book book2 = new Book(
    title: "Ciudade de papel",
    author: "John Green",
    description: "romantica",
    urlImage: "https://www.aboutespanol.com/thmb/HORNUW8kOEo3BJyUKuBG5qdphZ0=/768x0/filters:no_upscale():max_bytes(150000):strip_icc()/ciudades-de-papel-nube-de-tinta-56a5a5515f9b58b7d0ddd015.JPG"
  );

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      margin: EdgeInsets.only(
          top: 10.0,
          left: 20.0,
          right: 20.0,
          bottom: 10.0
      ),
      child: StreamBuilder(
        stream: userBloc.myFavoriteBooksListSream(user.uid),
        builder: (context, AsyncSnapshot snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              return CircularProgressIndicator();
            case ConnectionState.done:
            case ConnectionState.active:
            default:
              return Column(
                  children: userBloc.buildMyFavoriteBooks(snapshot.data.docs)
              );
          }
        }
      ),

      // child: Column(
      //   children: <Widget>[
      //     ProfileBook(book),
      //     ProfileBook(book2),
      //   ],
      // ),
    );
  }

}