import 'package:books/Book/model/book.dart';
import 'package:books/User/bloc/bloc_user.dart';
import 'package:books/widgets/button_purple.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionBook extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    void descargar(String url) async{
      print(url);
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return StreamBuilder<Book>(
      stream: userBloc.bookSelectedStream,
      builder: (BuildContext context, AsyncSnapshot<Book> snapshot){
        if (snapshot.hasData) {
          print("BOOK SELECTED: ${snapshot.data.title}");
          Book book = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleStars(book),
              authWidget(book.author),
              descriptionWidget(book.description),
              categoryWidget(book.category),
              ButtonPurple(buttonText: "Descargar", onPressed: (){
                descargar(book.urlPdf);
              },)
            ],
          );
        }else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container (
                margin: EdgeInsets.only(
                  top: 450.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: 400.0
                ),

                child: Text(
                  "Selecciona un libro",
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900
                  ),
                  textAlign: TextAlign.left,
                ),

              )

            ],
          );
        }
      },
    );
  }

  Widget titleStars(Book book){
    return Row (
      children: <Widget>[
        Expanded(
            flex: 8,
            child: Container (
              margin: EdgeInsets.only(
                  top: 460.0,
                  left: 30.0,
                  right: 10.0
              ),

              child: Text(
                book.title,
                style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900
                ),
                textAlign: TextAlign.left,
              ),

            )
        ),
        Expanded(
            flex: 2,
            child: Container (
              margin: EdgeInsets.only(
                top: 460.0,
              ),

              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(
                    "${book.likes}",
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.amber
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              )

            )
        ),

      ],
    );
  }

  Widget authWidget(String authBook){
    return Container(
      margin: new EdgeInsets.only(
          top: 10.0,
          left: 30.0,
          right: 30.0
      ),
      child: new Text(
        authBook,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            // color: Colors.white12
        ),

      ),
    );
  }

  Widget descriptionWidget(String descriptionBook){
    return Container(
      margin: new EdgeInsets.only(
          top: 20.0,
          left: 30.0,
          right: 30.0
      ),
      child: new Text(
        descriptionBook,
        textAlign: TextAlign.justify,
        style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 16.0,
            // fontWeight: FontWeight.bold,
            color: Color(0xFF56575a)
        ),

      ),
    );
  }

  Widget categoryWidget(String categoryBook){
    return Container(
      margin: new EdgeInsets.only(
          top: 20.0,
          left: 30.0,
          right: 30.0
      ),
      child: new Text(
        "Genero: ${categoryBook}",
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF56575a)
        ),

      ),
    );
  }

}