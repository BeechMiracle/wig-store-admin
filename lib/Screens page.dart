import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1_admin/Homepage.dart';
import 'package:untitled1_admin/add%20product%20screen.dart';
import 'package:untitled1_admin/constants.dart';
import 'package:untitled1_admin/request%20screen.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Center(
          child: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 150,
                  child: Image(
                    image: AssetImage('images/image1.png'),
                  ),
                ),
                PopupMenuButton(
                  padding: const EdgeInsets.only(top: 10.0),
                  constraints: const BoxConstraints(
                    maxWidth: 50,
                  ),
                  position: PopupMenuPosition.under,
                  color: Colors.white,
                  icon: const Icon(
                    Icons.more_horiz,
                    color: kButtonColor,
                  ),
                  iconSize: 30,
                  itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: const Icon(
                        Icons.notifications,
                        size: 25,
                        color: kButtonColor,
                      ),
                      onTap: () {},
                    ),
                    const PopupMenuDivider(
                      height: 10,
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Icon(
                        Icons.logout,
                        size: 25,
                        color: kButtonColor,
                      ),
                      onTap: () => FirebaseAuth.instance.signOut(),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'New Products',
              style: kAppBarTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Order Status Requests',
              style: kAppBarTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ][currentPageIndex],
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
            bottom: 8,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                <Widget>[
                  const HomeScreen(),
                  const AddProduct(),
                  const RequestScreen(),
                ][currentPageIndex],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        height: 60,
        elevation: 3,
        backgroundColor: kButtonColor,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.dashboard,
              size: 30,
              color: kSecondaryColor,
            ),
            icon: Icon(
              Icons.dashboard,
              size: 30,
              color: kInactiveColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.add_circle,
              size: 50,
              color: kSecondaryColor,
            ),
            icon: Icon(
              Icons.add_circle,
              size: 50,
              color: kInactiveColor,
            ),
            label: 'Add Item',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.request_page,
              size: 30,
              color: kSecondaryColor,
            ),
            icon: Icon(
              Icons.request_page_outlined,
              size: 30,
              color: kInactiveColor,
            ),
            label: 'Status Request',
          ),
        ],
      ),
    );
  }
}
