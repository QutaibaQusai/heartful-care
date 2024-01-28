import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double Radius})
      : _painter = _CirclePainter(color, Radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double Radius;

  _CirclePainter(Color color, this.Radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - Radius - 5);
    canvas.drawCircle(circleOffset, Radius, _paint);
  }
}

class DetailedNurseCenter extends StatefulWidget {
  @override
  State<DetailedNurseCenter> createState() => _DetailedNurseCenterState();
}

class _DetailedNurseCenterState extends State<DetailedNurseCenter>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.phoneFlip,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                      color: Color(0xFF1C8892),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.width / 3.7,
                      child: Image.asset(
                        "images/WhatsApp_Image_2024-01-27_at_13.11.06_132c59dc-removebg-preview.png",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Text(
                      "AL SAKHA Center",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 3,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "8PM - 10PM",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            TabBar(
                              controller: _tabController,
                              labelColor: Colors.black,
                              labelPadding:
                                  const EdgeInsets.only(left: 5, right: 50),
                              isScrollable: true,
                              unselectedLabelColor:
                                  Color(0xFF1C8892), // Change the color here
                              indicator: CircleTabIndicator(
                                color: Colors.black,
                                Radius: 4,
                              ),
                              tabs: [
                                Tab(text: 'Description'),
                                Tab(text: 'Reviews'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20, // Add space between Description and Reviews
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 300,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                            itemCount: 1, // Replace with your actual item count
                            itemBuilder: (_, index) {
                              return Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.symmetric(vertical: 7),
                                child: Center(
                                  child: Text('Description $index'),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 1, // Replace with your actual item count
                            itemBuilder: (_, index) {
                              return Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: Text('Review $index'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1C8892)),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Fill form".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
