import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubai/models/user_model.dart';

class DataBaseService {
  final String uid;
  DataBaseService({this.uid});

  final CollectionReference usersCollection =
      Firestore.instance.collection('users');
  final CollectionReference ordersCollection =
      Firestore.instance.collection('orders');
  final CollectionReference errorMessage =
      Firestore.instance.collection('error message');

  Future updateUserCollection(
    String name,
    String image,
    String phonNum,
    String address,
  ) async {
    return await usersCollection.document(uid).setData({
      'user name': name,
      'user image': image,
      'phone Number': phonNum,
      'address': address,
    });
  }

  Future addOrder({
    String userid,
    String name,
    String phoneNum,
    String address,
    String productName,
    String price,
  }) async {
    return await ordersCollection
        .document(userid)
        .collection('myOreder')
        .document()
        .setData({
      'user name': name,
      'phone number': phoneNum,
      'address': address,
      'product name': productName,
      'price': price,
    });
  }

  Future errorReport({
    String error,
  }) async {
    return await errorMessage.document().setData({
      'error': error,
    });
  }

  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      userName: snapshot.data['user name'],
      phoneNumber: snapshot.data['phone Number'],
      address: snapshot.data['address'],
    );
  }

  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
