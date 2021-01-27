import 'package:books/Book/model/book.dart';
import 'package:books/Book/ui/widgets/book_card.dart';
import 'package:books/User/bloc/bloc_user.dart';
import 'package:books/User/model/user.dart';
import 'package:books/widgets/gradient_back.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class SearchBooks extends StatefulWidget {

  @override
  _SearchBooksState createState() => _SearchBooksState();
}
UserBloc userBloc;

class _SearchBooksState extends State<SearchBooks> {
  TextEditingController _searchController = TextEditingController();


  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);

    return Container(
        height: 450.0,
        child: StreamBuilder(
            stream: userBloc.booksStream,
            builder: (context, AsyncSnapshot snapshot){
              switch (snapshot.connectionState){
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                case ConnectionState.done:
                  return listViewBooks(userBloc.listBooks(snapshot.data.docs));
                default:
                  print("PLACESLIST: DEFAULT");
              }
            }
        )
    );


  }

  Widget listViewBooks(List<Book> books) {
    _resultsList = books;
    return Stack(
      children: [
        GradientBack(height:110.0),
        Container(
          margin: EdgeInsets.only(
            top: 50.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 30.0
                ) ,
                child: Text(
                    "Buscar libros",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    )
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
              //   child: TextField(
              //     onChanged: (value){
              //       print("FDFDFDFD"+value);
              //     },
              //     controller: _searchController,
              //     decoration: InputDecoration(
              //         prefixIcon: Icon(Icons.search)
              //     ),
              //   ),
              // ),
              Expanded(
                child: ListView.builder(
                  itemCount: _resultsList.length,
                  itemBuilder: (BuildContext context, int index) => BookCard(_resultsList[index]),
                )
              ),
            ],
          ),
        )
      ],
    );
  }
}
