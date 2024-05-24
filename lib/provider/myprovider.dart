import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/model/devicesModel.dart';

class MyProvider with ChangeNotifier {
  // items for specific one .
  List<Devices>? items;

  List<Devices> cart = [];

  // saved credentials
  String? saved_email;
  String? saved_password;

  // get items function .
  Future getItems({required String supplier_id}) async {
    if (items != null) {
      items!.clear();
      notifyListeners();
    }
    //  get data .
    items = await FirebaseFirestore.instance
        .collection("Devices")
        .where("supplierId", isEqualTo: supplier_id)
        .get()
        .then((value) =>
            value.docs.map((e) => Devices.fromMap(e.id, e.data())).toList());

    print("data length is : ${items != null ? items!.length : "List is null"}");
    notifyListeners();
  }

  void additem({required Devices item}) {
    cart.add(item);
    print("the cart has ${cart.length}");

    notifyListeners();
  }

  void deleteitem({required int index}) {
    print("Tap 1: ${cart.length}");
    cart.removeAt(index);
    print("Tap 2: ${cart.length}");
    notifyListeners();
  }

  // save data .
  Future SaveUserlogin(
      {required String email, required String password}) async {
    // get instacne
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // save the email.
    await prefs.setString("user_email", email.trim());

    // save the password .
    await prefs.setString("user_password", password.trim());

    print("the Svaing proccess has been done successFully!");
  }

  //  Get save data .
  Future<List> GetUserlogin() async {
    // get instacne
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // save the email.
    saved_email = await prefs.getString("user_email");

    // save the password .
    saved_password = await prefs.getString("user_password");

    List<String> data = [];

    if (saved_email != null && saved_password != null) {
      data = [saved_email!, saved_password!];
    }

    notifyListeners();

    print("the Getting  proccess has been done successFully!");

    return data;
  }

  //  Get save data .
  Future DeleteSavedUserLogin() async {
    // get instacne
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("user_email");
    saved_email = null;

    await prefs.remove("user_password");
    saved_password = null;

    print("the deleteing proccess has been done successFully!");

    notifyListeners();
  }
}
