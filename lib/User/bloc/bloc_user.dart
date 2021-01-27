import 'dart:async';

import 'package:books/Book/model/book.dart';
import 'package:books/Book/ui/widgets/card_image.dart';
import 'package:books/User/repository/auth_repository.dart';
import 'package:books/User/repository/cloud_firestore_api.dart';
import 'package:books/User/repository/cloud_firestore_repository.dart';
import 'package:books/User/ui/widgets/profile_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:books/User/model/user.dart' as Model;

class UserBloc implements Bloc {

  final _auth_repository = AuthRepository();

  //flujo de datos - streams
  //Stream - Firebase
  //StreamController
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;
  User get currentUser => FirebaseAuth.instance.currentUser;

  //Caso de uso
  //1. sigin with google
  Future<User> sigIn(){
    return _auth_repository.sigInGmail();
  }

  //2. registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(Model.User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);

  // Future<void> updatePlaceData(Place place) => _cloudFirestoreRepository.updatePlaceData(place);
  Stream<QuerySnapshot> booksListStream = FirebaseFirestore.instance.collection(CloudFirestoreAPI().BOOK).orderBy("likes", descending: true).snapshots();
  Stream<QuerySnapshot> get booksStream => booksListStream;
  List<Book> buildBooks(List<DocumentSnapshot> booksListSnapshot, Model.User user) => _cloudFirestoreRepository.buildBooks(booksListSnapshot, user);

  List<Book> listBooks(List<DocumentSnapshot> booksListSnapshot) => _cloudFirestoreRepository.listBooks(booksListSnapshot);

  Stream<QuerySnapshot> myFavoriteBooksListSream(String uid) =>
      FirebaseFirestore.instance.collection(CloudFirestoreAPI().BOOK)
          .where("usersLiked", arrayContains: FirebaseFirestore.instance.doc("${CloudFirestoreAPI().USERS}/$uid"))
          .snapshots();
  List<ProfileBook> buildMyFavoriteBooks(List<DocumentSnapshot> booksListSnapshot) => _cloudFirestoreRepository.buildMyFavoriteBooks(booksListSnapshot);


  // final _firebaseStorageRepository = FirebaseStorageRepository();
  // Future<StorageUploadTask> uploadFile(String path, File image) => _firebaseStorageRepository.uploadFile(path, image);

  Future likeBook(Book book, String uid) => _cloudFirestoreRepository.likeBook(book,uid);

  StreamController<Book> bookSelectedStreamController =  StreamController<Book>();
  Stream<Book> get bookSelectedStream => bookSelectedStreamController.stream;
  StreamSink<Book> get bookSelectedSink =>  bookSelectedStreamController.sink;

  signOut(){
    _auth_repository.signOut();
  }

  @override
  void dispose() {

  }
}