import 'package:books/Book/model/book.dart';
import 'package:books/Book/ui/widgets/card_image.dart';
import 'package:books/User/ui/widgets/profile_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:books/User/model/user.dart' as Model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloudFirestoreAPI {
  final String USERS = 'users';
  final String BOOK = 'books';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(Model.User user) async{
    CollectionReference users = _firestore.collection(USERS);
    DocumentReference ref = users.doc(user.uid);
    return ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myFavoriteBooks': user.myFavoriteBooks,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));

  }

  // Future<void> updateBookData(Book book) async {
  //   CollectionReference refPlaces = _firestore.collection(BOOK);
  //
  //   await _auth.currentUser().then((User user) {
  //     refPlaces.add({
  //       'name': place.name,
  //       'description': place.description,
  //       'likes': place.likes,
  //       'urlImage': place.urlImage,
  //     }).then((DocumentReference dr) {
  //       dr.get().then((DocumentSnapshot snapshot) {
  //         //ID Place REFERENCIA ARRAY
  //         DocumentReference refUsers = _firestore.collection(USERS).doc(
  //             user.uid);
  //         refUsers.update({
  //           'myPlaces': FieldValue.arrayUnion(
  //               [_firestore.doc("${BOOK}/${snapshot.documentID}")])
  //         });
  //       });
  //     });
  //   });
  // }

  List<ProfileBook> buildMyFavoriteBooks(List<DocumentSnapshot> placesListSnapshot){
    List<ProfileBook> profileBooks = List<ProfileBook>();
    placesListSnapshot.forEach((p) {

      profileBooks.add(ProfileBook(
        Book(
            title: p.data()['title'],
            author: p.data()['author'],
            category: p.data()['category'],
            description: p.data()['description'],
            urlImage: p.data()['urlImage'],
            urlPdf: p.data()['urlPdf'],
            likes: p.data()['likes']
        ),

      ));

    });

    return profileBooks;


  }

  List<Book> buildBooks(List<DocumentSnapshot> booksListSnapshot, Model.User user){
    List<Book> books = List<Book>();
    booksListSnapshot.forEach((p)  {
      Book book = Book(id: p.id, title: p.data()["title"], author: p.data()["author"],
          description: p.data()["description"],
          category: p.data()["category"], urlPdf: p.data()["urlPdf"],
          urlImage: p.data()["urlImage"],likes: p.data()["likes"],
          liked: p.data()["liked"]
      );
      List usersLikedRefs =  p.data()["usersLiked"];
      book.liked = false;
      usersLikedRefs?.forEach((drUL){
        if(user.uid == drUL.id){
          book.liked = true;
        }
      });
      books.add(book);
    });
    return books;
  }

  List<Book> listBooks(List<DocumentSnapshot> booksListSnapshot){
    List<Book> books = List<Book>();
    booksListSnapshot.forEach((p)  {
      Book book = Book(id: p.id, title: p.data()["title"], author: p.data()["author"],
          description: p.data()["description"],
          category: p.data()["category"], urlPdf: p.data()["urlPdf"],
          urlImage: p.data()["urlImage"],likes: p.data()["likes"]
      );
      books.add(book);
    });
    return books;
  }

  Future likeBook(Book book, String uid) async {
    await _firestore.collection(BOOK).doc(book.id).get()
        .then((DocumentSnapshot ds){
      int likes = ds.data()["likes"];

      _firestore.collection(BOOK).doc(book.id)
          .update({
        'likes': book.liked?likes+1:likes-1,
        'usersLiked':
        book.liked?
        FieldValue.arrayUnion([_firestore.doc("${USERS}/${uid}")]):
        FieldValue.arrayRemove([_firestore.doc("${USERS}/${uid}")])
      });

      _firestore.collection(USERS).doc(uid)
        .update({
        'myFavoriteBooks':
        book.liked?
        FieldValue.arrayUnion([_firestore.doc("${BOOK}/${book.id}")]):
        FieldValue.arrayRemove([_firestore.doc("${BOOK}/${book.id}")])
        });
    });
  }

}