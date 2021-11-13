import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/UserModel.dart';

class FireStoreUser {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> AddUserToFireStore(UserModel userModel) async {
    return await _userCollectionReference
        .doc(userModel.userId)
        .set(userModel.tojson());
  }
}
