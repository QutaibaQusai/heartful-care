import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';

class SupplierOrderDetails extends StatefulWidget {
  final int index;

  const SupplierOrderDetails({Key? key, required this.index}) : super(key: key);

  @override
  State<SupplierOrderDetails> createState() => _SupplierOrderDetailsState();
}

class _SupplierOrderDetailsState extends State<SupplierOrderDetails> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<MyProvider>();
    provider.getCartItems(provider.orders![widget.index].id);
  }

  void updateOrderStatus(BuildContext context, int status) {
    final provider = context.read<MyProvider>();
    provider
        .updateOrderStatus(provider.orders![widget.index].id, status)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            status == 1 ? 'Order accepted' : 'Order rejected',
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Order Details",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Consumer<MyProvider>(
          builder: (context, provider, child) {
            if (provider.cartItems == null) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color(0xFF1C8892),
              ));
            }
            if (provider.cartItems!.isEmpty) {
              return Center(child: Text("No items in this order"));
            }
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF1C8892),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Color(0xFF1C8892), shape: BoxShape.circle),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(70),
                              child: provider.orders![widget.index].userImage
                                      .isNotEmpty
                                  ? Image.network(
                                      provider.orders![widget.index].userImage,
                                      fit: BoxFit.cover)
                                  : Image.network(
                                      "https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png",
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "${provider.orders![widget.index].userEmail}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "Phone number 0795999114",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "Street ${provider.orders![widget.index].userStreet}",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "Area ${provider.orders![widget.index].userArea}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.cartItems!.length,
                    itemBuilder: (context, index) {
                      final item = provider.cartItems![index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(item.deviceName),
                            leading: ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(25),
                                child: Image.network(item.deviceImages[0],
                                    fit: BoxFit.cover),
                              ),
                            ),
                            subtitle: Text(item.deviceDescription),
                            trailing: Text(item.deviceBuyPrice.isNotEmpty
                                ? 'JOD ${item.deviceBuyPrice}'
                                : 'JOD ${item.deviceRentPrice} per week'),
                          ),
                          Divider()
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF1C8892),
                      ),
                    ),
                    onPressed: () {
                      print("Accept order");
                      updateOrderStatus(context, 1);
                    },
                    child: Text(
                      "Accept order",
                      style: TextStyle(color: Colors.white),
                    ))),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF1C8892), // Button background color
                      ),
                    ),
                    onPressed: () {
                      print("Reject order");
                      updateOrderStatus(context, 2);
                    },
                    child: Text(
                      "Reject order",
                      style: TextStyle(color: Colors.white),
                    ))),
          ]),
        ),
      ),
    );
  }
}
