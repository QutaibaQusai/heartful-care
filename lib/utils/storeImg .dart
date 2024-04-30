import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class StoreImg {
  // covert images to string
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

  Future<List<String>> uploadDeviceImages({
    required List<Uint8List> files,
    required String supplierEmail,
    required String deviceName,
    required String storagePath,
  }) async {
    List<String> imageUrls = [];
    for (int i = 0; i < files.length; i++) {
      String fileChildPath =
          '$storagePath/${Uri.encodeComponent(supplierEmail)}/${Uri.encodeComponent(deviceName)}/image$i';
      String imageUrl = await uploadImageToStorage(fileChildPath, files[i]);
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  Future<String> uploadNurseProfile({
    required Uint8List file,
    required String nurseId,
    required String storagePath,
  }) async {
    String resp = "Error Occurred";
    try {
      String fileChildPath = '$storagePath/${Uri.encodeComponent(nurseId)}';

      String imageUrl = await uploadImageToStorage(fileChildPath, file);
      await fireStore.collection("Nurses").doc(nurseId).update({
        "nurseProfileImage": imageUrl,
      });
      resp = "success";
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

  // save center profile image
  Future<String> saveProfileCenterImg({
    required Uint8List file,
    required String centerEmail,
    required String storagePath,
  }) async {
    String resp = "Error Occurred";
    try {
      String fileChildPath = '$storagePath/${Uri.encodeComponent(centerEmail)}';

      String imageUrl = await uploadImageToStorage(fileChildPath, file);
      QuerySnapshot querySnapshot = await fireStore
          .collection("centers")
          .where('Email', isEqualTo: centerEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String centerId = querySnapshot.docs.first.id;
        await fireStore.collection("centers").doc(centerId).update({
          "centerProfileImage": imageUrl,
        });
        resp = "success";
      } else {
        resp = "Supplier with email $centerEmail not found";
      }
      print(resp + "=====================================================");
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
