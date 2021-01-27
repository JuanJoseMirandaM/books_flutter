import 'package:books/Book/model/book.dart';
import 'package:books/Book/ui/widgets/card_image.dart';
import 'package:books/User/model/user.dart';
import 'package:books/User/repository/cloud_firestore_api.dart';
import 'package:books/User/ui/widgets/profile_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _cloudFirestoreAPI.updateUserData(user);
  // Future<void> updateBookData(Book book) => _cloudFirestoreAPI.updateBookData(book);

  List<ProfileBook> buildMyFavoriteBooks(List<DocumentSnapshot> booksListSnapshot) => _cloudFirestoreAPI.buildMyFavoriteBooks(booksListSnapshot);
  List<Book> buildBooks(List<DocumentSnapshot> booksListSnapshot, User user) => _cloudFirestoreAPI.buildBooks(booksListSnapshot, user);

  List<Book> listBooks(List<DocumentSnapshot> booksListSnapshot) => _cloudFirestoreAPI.listBooks(booksListSnapshot);

  Future likeBook(Book book, String uid) => _cloudFirestoreAPI.likeBook(book,uid);
}