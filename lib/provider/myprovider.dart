import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/model/devicesModel.dart';
import 'package:test/model/userCenterSubscription.dart';
import 'package:test/model/userInfo.dart';
import 'package:test/model/usersOrderRequest.dart';

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
    cart.removeAt(index);
    notifyListeners();
  }

  Future<void> saveCartItems(String orderId) async {
    for (var item in cart) {
      await FirebaseFirestore.instance
          .collection('Device_order')
          .doc(orderId)
          .collection('CartItems')
          .add(item.toMap());
    }
  }

////////////////////////////////////////////////////
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

////////////////////////////////////////////////////
  UserInfo? userInfo;
  // get user info  function .
  Future getUserInfo({required String userEmail}) async {
    //  get data .
    userInfo = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get()
        .then((value) =>
            UserInfo.fromMap(value.docs.first.id, value.docs.first.data()));
    notifyListeners();
  }

  ////////////////////////////////////////////////////
  UserCenterSubscription? userSubscription;

  Future<void> fetchAndCheckUserSubscription({
    required String userEmail,
    required String centerId,
  }) async {
    // Fetch data from Firestore
    userSubscription = await FirebaseFirestore.instance
        .collection("Subscription")
        .where("userEmail", isEqualTo: userEmail)
        .where("centerId", isEqualTo: centerId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return UserCenterSubscription.fromMap(
            value.docs.first.id, value.docs.first.data());
      } else {
        return null; // No subscription found
      }
    });

    // Notify listeners if subscription found
    if (userSubscription != null) {
      notifyListeners();
      // // Check subscription status
      // DateTime now = DateTime.now();
      // DateTime endDate = DateTime.parse(userSubscription!.endDate);

      // if (endDate.isBefore(now)) {
      //   userSubscription!.subscriptionStatus = 0;
      //   notifyListeners();

      //   // Update the subscription status in Firestore
      //   await FirebaseFirestore.instance
      //       .collection("Subscription")
      //       .doc(userSubscription!.Id)
      //       .update(
      //           {'subscriptionStatus': userSubscription!.subscriptionStatus});
      // }
    } else {
      notifyListeners();
    }
  }
  ////////////////////////////////////////////////////

  // Orders list
  List<DeviceRequest>? orders;
    // CartItems list for an order
  List<Devices>? cartItems;

  Future getOrder({required String supplier_id}) async {
    orders = await FirebaseFirestore.instance
        .collection("Device_order")
        .where("supplierId", isEqualTo: supplier_id)
        .get()
        .then((value) => value.docs
            .map((e) => DeviceRequest.fromMap(e.id, e.data()))
            .toList());
    notifyListeners();
  }
    // Get CartItems for a specific order
  Future<void> getCartItems(String orderId) async {
    cartItems = await FirebaseFirestore.instance
        .collection('Device_order')
        .doc(orderId)
        .collection('CartItems')
        .get()
        .then((value) =>
            value.docs.map((e) => Devices.fromMap(e.id, e.data())).toList());

    notifyListeners();
  }
  // Update order status
  Future<void> updateOrderStatus(String orderId, int status) async {
    await FirebaseFirestore.instance
        .collection('Device_order')
        .doc(orderId)
        .update({'orderStatus': status});
    
    // Update the local order list
    orders = orders?.map((order) {
      if (order.id == orderId) {
        return DeviceRequest(
          id: order.id,
          supplierId: order.supplierId,
          userName: order.userName,
          userImage: order.userImage,
          userEmail: order.userEmail,
          userOrderTimeAndDate: order.userOrderTimeAndDate,
          userArea: order.userArea,
          userStreet: order.userStreet,
          orderStatus: status, // Make sure to add this field to your model
        );
      }
      return order;
    }).toList();
    
    notifyListeners();
  }

}
