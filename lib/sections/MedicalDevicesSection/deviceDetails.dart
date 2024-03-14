import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeviceDetails extends StatefulWidget {
  const DeviceDetails({Key? key}) : super(key: key);

  @override
  State<DeviceDetails> createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  bool isExpanded = false;
  int quantity = 1;
  int currentPage = 0; // Current page index for PageView

  final List<String> images = [
    "https://lynemouthpharmacy.co.uk/wp-content/uploads/2022/03/blood_pressure-02.jpg",
    // Add your other image URLs here
    "https://example.com/image2.jpg",
    "https://example.com/image3.jpg",
  ];

  String priceOption = 'Buy'; // Default price option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Details"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Add functionality here
            },
            icon: Icon(
              FontAwesomeIcons.cartShopping,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10), // Circular border radius
              ),
              child: PageView.builder(
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => buildDot(index),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wheelchair",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  isExpanded
                      ? Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce id sodales eros, et fermentum risus Fusce id sodales eros, et fermentum risusFusce id sodales eros, et fermentum risus.",
                          style: TextStyle(fontSize: 16),
                        )
                      : Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce id sodales eros, et fermentum risus Fusce id sodales eros, et fermentum risusFusce id sodales eros, et fermentum risus. ",
                          style: TextStyle(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? "Read less" : "Read more",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price Details:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Buy',
                                groupValue: priceOption,
                                onChanged: (value) {
                                  setState(() {
                                    priceOption = value!;
                                  });
                                },
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                activeColor: Color(0xFF1C8892),
                              ),
                              Text('Buy for \$100'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Rent',
                                groupValue: priceOption,
                                onChanged: (value) {
                                  setState(() {
                                    priceOption = value!;
                                  });
                                },
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                activeColor: Color(
                                    0xFF1C8892), // Color for the selected Radio button
                              ),
                              Text('Rent per week for \$30'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), // Border radius
                border: Border.all(
                  width: 1, // Border width
                  color: Colors.grey, // Border color
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: decrementQuantity,
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: incrementQuantity,
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add to cart functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1C8892),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }
}
