import 'package:flutter/material.dart';
import 'package:test/sections/MedicalDevicesSection/checkout.dart';

class ItemCart extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  final String itemOption;
  final int quantity;
  final int weeks;
  final String userEmail;
  final String deviceImage1;

  const ItemCart({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.itemOption,
    required this.quantity,
    required this.weeks,
    required Null Function() onItemAddedToCart,
    required this.userEmail,
    required this.deviceImage1,
  }) : super(key: key);

  @override
  State<ItemCart> createState() => _ItemCart();
}

class _ItemCart extends State<ItemCart> {
  List<Map<String, dynamic>> cartItems = [];
  double deliveryFees = 2;

  @override
  void initState() {
    super.initState();
    cartItems.add({
      'name': widget.itemName,
      'price': widget.itemPrice,
      'option': widget.itemOption,
      'quantity': widget.quantity,
      'weeks': widget.weeks,
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice();
    double paymentAmount = totalPrice + deliveryFees;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Curved background
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 200,
                color: Color(0xFF1C8892),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Your Orders',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          7,
                        ), // Adjust border radius as needed
                        side: BorderSide(
                          color: Colors.grey,
                        ), // Border color
                      ),
                      color: Colors.white, // Background color of the card
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ), // Adjust border radius as needed
                                    image: DecorationImage(
                                      image: NetworkImage(widget.deviceImage1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 9),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItems[index]['name'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      cartItems[index]['option'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: decrementQuantity,
                                          icon: Icon(Icons.remove),
                                        ),
                                        Text(
                                          cartItems[index]['quantity']
                                              .toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        IconButton(
                                          onPressed: incrementQuantity,
                                          icon: Icon(
                                            Icons.add,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            removeItem(index);
                                          },
                                          icon: Icon(Icons.delete),
                                          //color: Color(0xFF1C8892),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Order details section
            Container(
              padding: EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$totalPrice JD',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery fees',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$deliveryFees JD', // Display delivery fees
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$paymentAmount JD', // Display payment amount including delivery fees
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // You can add more order details here if needed
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Colors.transparent))),
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(0xFF1C8892), // Button background color
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Checkout(
                    paymentAmount: paymentAmount,
                    userEmail: widget.userEmail,
                  ), // Pass payment amount to Checkout screen
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Checkout".toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void incrementQuantity() {
    setState(() {
      cartItems.forEach((item) {
        item['quantity']++;
      });
    });
  }

  void decrementQuantity() {
    setState(() {
      cartItems.forEach((item) {
        if (item['quantity'] > 1) {
          item['quantity']--;
        }
      });
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double calculateTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += double.parse(item['price']) * item['quantity'] * item['weeks'];
    }
    return total;
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    var controlPoint = Offset(70, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
