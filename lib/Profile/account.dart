import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test/User%20Settings/YourAccountInfoPage.dart';
import 'package:test/model/userInfo.dart';
import 'package:test/provider/myprovider.dart';

class Account extends StatefulWidget {
  final String userEmail;

  const Account({
    Key? key,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    super.initState();
    if (widget.userEmail.isNotEmpty) {
      context.read<MyProvider>().getUserInfo(userEmail: widget.userEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO if the user not fill his data
    final isGuest = widget.userEmail.isEmpty;
    // final userData = context.read<MyProvider>().userInfo != null;
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Color(0xFF1C8892),
      onRefresh: () async {
        if (!isGuest) {
          await context
              .read<MyProvider>()
              .getUserInfo(userEmail: widget.userEmail);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          title: Text(
            'Profile',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF1C8892),
          actions: [
            if (!isGuest)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    color: Color(0xFF1C8892),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YourAccountInfoPage(
                            userEmail: widget.userEmail,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Consumer<MyProvider>(
            builder: (context, value, child) {
              if (isGuest) {
                return _buildGuestProfile();
              }

              if (value.userInfo == null) {
                return Center(child: CircularProgressIndicator());
              }

              final userInfo = value.userInfo!;
              return _buildUserProfile(context, userInfo);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGuestProfile() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.0,
              color: Color(0xFF1C8892),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.42,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 6,
                          backgroundImage: AssetImage("images/profile.webp"),
                        ),
                      ),
                      Text(
                        'GUEST',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _buildGuestCard(Icons.email, 'Email', 'Guest'),
                            _buildGuestCard(
                                Icons.call, 'Phone Number', 'Guest'),
                            _buildGuestCard(FontAwesomeIcons.idCard,
                                'National ID', 'Guest'),
                            _buildGuestCard(FontAwesomeIcons.calendar,
                                'Date of Birth', 'Guest'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGuestCard(IconData icon, String title, String subtitle) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        leading: Icon(icon),
        iconColor: Color(0xFF1C8892),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, UserInfo userInfo) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.0,
              color: Color(0xFF1C8892),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.42,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 6,
                          backgroundImage: userInfo.userImage != null &&
                                  userInfo.userImage.isNotEmpty
                              ? NetworkImage(userInfo.userImage)
                              : AssetImage("images/profile.webp")
                                  as ImageProvider<Object>,
                        ),
                      ),
                      Text(
                        userInfo.userName.toUpperCase(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _buildUserCard(
                                Icons.email, 'Email', widget.userEmail),
                            _buildUserCard(Icons.call, 'Phone Number',
                                userInfo.phoneNumber),
                            _buildUserCard(FontAwesomeIcons.idCard,
                                'National ID', userInfo.nationalId),
                            _buildUserCard(
                                FontAwesomeIcons.calendar,
                                'Date of Birth',
                                userInfo.dateOfBirth != null &&
                                        userInfo.dateOfBirth!.isNotEmpty
                                    ? formatDate(
                                        DateTime.parse(userInfo.dateOfBirth!),
                                        [dd, '/', mm, '/', yyyy])
                                    : 'Not provided'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserCard(IconData icon, String title, String subtitle) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        leading: Icon(icon),
        iconColor: Color(0xFF1C8892),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle.isNotEmpty ? subtitle : 'Not provided'),
      ),
    );
  }
}
