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

  Future<String> saveProfileSupplierImg({
    required Uint8List file,
    required String supplierEmail,
    required String storagePath,
    required String firestoreCollectionName,
    required String supplierFireStoreFiledName,
  }) async {
    String resp = "Error Occurred";
    try {
      String fileChildPath =
          '$storagePath/${Uri.encodeComponent(supplierEmail)}';

      String imageUrl = await uploadImageToStorage(fileChildPath, file);
      QuerySnapshot querySnapshot = await fireStore
          .collection(firestoreCollectionName)
          .where('Email', isEqualTo: supplierEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String supplierId = querySnapshot.docs.first.id;
        await fireStore
            .collection(firestoreCollectionName)
            .doc(supplierId)
            .update({
          supplierFireStoreFiledName: imageUrl,
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

  Future<String> saveSupplierDevicesImages({
    required Uint8List file,
    required String supplierEmail,
    required String storagePath,
    required String firestoreCollectionName,
    required String supplierFireStoreFiledName,
  }) async {
    String resp = "Error Occurred";
    try {
      String fileChildPath =
          '$storagePath/${Uri.encodeComponent(supplierEmail)}';

      String imageUrl = await uploadImageToStorage(fileChildPath, file);
      QuerySnapshot querySnapshot = await fireStore
          .collection(firestoreCollectionName)
          .where('Email', isEqualTo: supplierEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String supplierId = querySnapshot.docs.first.id;
        await fireStore
            .collection(firestoreCollectionName)
            .doc(supplierId)
            .update({
          supplierFireStoreFiledName: imageUrl,
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


    Future<String> saveUserProfile({
    required Uint8List file,
    required String supplierEmail,
    required String storagePath,
    required String firestoreCollectionName,
    required String supplierFireStoreFiledName,
  }) async {
    String resp = "Error Occurred";
    try {
      String fileChildPath =
          '$storagePath/${Uri.encodeComponent(supplierEmail)}';

      String imageUrl = await uploadImageToStorage(fileChildPath, file);
      QuerySnapshot querySnapshot = await fireStore
          .collection(firestoreCollectionName)
          .where('email', isEqualTo: supplierEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String supplierId = querySnapshot.docs.first.id;
        await fireStore
            .collection(firestoreCollectionName)
            .doc(supplierId)
            .update({
          supplierFireStoreFiledName: imageUrl,
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
