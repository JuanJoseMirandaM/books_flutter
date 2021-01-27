import 'package:books/Book/model/book.dart';
import 'package:books/User/bloc/bloc_user.dart';
import 'package:books/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:books/Book/ui/widgets/card_image.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class CardImageList extends StatefulWidget {
  User user;

  CardImageList(@required this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CardImageList();
  }
}
UserBloc userBloc;

class _CardImageList extends State<CardImageList> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    userBloc = BlocProvider.of(context);

    return Container(
        height: 450.0,
        child: StreamBuilder(
          stream: userBloc.booksStream,
          builder: (context, AsyncSnapshot snapshot){
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
                print("PLACESLIST: WAITING");
                return CircularProgressIndicator();
              case ConnectionState.none:
                print("PLACESLIST: NONE");
                return CircularProgressIndicator();
              case ConnectionState.active:
                print("PLACESLIST: ACTIVE");
                return listViewBooks(userBloc.buildBooks(snapshot.data.docs, widget.user));
            //return listViewPlaces(userBloc.buildPlaces(snapshot.data.documents));
              case ConnectionState.done:
                print("PLACESLIST: DONE");
                return listViewBooks(userBloc.buildBooks(snapshot.data.docs, widget.user));

              default:
                print("PLACESLIST: DEFAULT");

            }
          }
        )
    );
  }

  Widget listViewBooks(List<Book> books){

    void setLiked(Book book){
      setState(() {
        book.liked = !book.liked;
        userBloc.likeBook(book, widget.user.uid);
        book.likes = book.liked?book.likes+1:book.likes-1;
        userBloc.bookSelectedSink.add(book);
      });
    }

    IconData iconDataLiked = Icons.favorite;
    IconData iconDataLike = Icons.favorite_border;
    return ListView(
      padding: EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: books.map((book){
        return GestureDetector(
          onTap: (){
            print("CLICK BOOK: ${book.title}");
            userBloc.bookSelectedSink.add(book);
          },
          child: CardImage(
            pathImage: book.urlImage,
            width: 200.0,
            height: 400.0,
            left: 20.0,
            iconData: book.liked?iconDataLiked:iconDataLike,
            onPressedFabIcon: (){
              setLiked(book);
            },
          ),
        );
      }).toList(),
    );
  }



}