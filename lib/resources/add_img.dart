import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class StoreImg {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapShot = await uploadTask;
    String downloadUrl = await snapShot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveProfileSupplierImg(
      {required Uint8List file, required String supplierEmail}) async {
    String resp = "Error Occurred";
    try {
      String imageUrl = await uploadImageToStorage('profileSupplierImg', file);
      QuerySnapshot querySnapshot = await fireStore
          .collection("Suppliers")
          .where('Email', isEqualTo: supplierEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String supplierId = querySnapshot.docs.first.id;
        await fireStore.collection("Suppliers").doc(supplierId).update({
          "imageLink": imageUrl,
        });
        resp = "success";
      } else {
        resp = "Supplier with email $supplierEmail not found";
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
