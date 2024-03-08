// import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

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

  Future<String> saveProfileSupplierImg({required Uint8List file}) async {
    String resp = "Error Occurred";
    try {
      String imageUrl = await uploadImageToStorage('profileSupplierImg', file);
      await fireStore.collection("Suppliers").add({
        "imageLink": imageUrl,
      });
      resp = "success";
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
