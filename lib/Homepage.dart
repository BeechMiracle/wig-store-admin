import 'package:flutter/material.dart';
import 'package:untitled1_admin/constants.dart';
import 'package:untitled1_admin/nav%20screens/orders%20screen.dart';
import 'package:untitled1_admin/nav%20screens/products%20screen.dart';
import 'package:untitled1_admin/nav%20screens/users%20screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        CustomPageButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductList(),
              ),
            );
          },
          title: 'Products',
          img: 'images/product.jpg',
        ),
        const SizedBox(
          height: 40,
        ),
        CustomPageButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserList(),
              ),
            );
          },
          title: 'Users',
          img: 'images/customer.jpg',
        ),
        const SizedBox(
          height: 40,
        ),
        CustomPageButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderList(),
              ),
            );
          },
          title: 'Orders',
          img: 'images/order.jpg',
        ),
      ],
    );
  }
}

class CustomPageButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String img;
  const CustomPageButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.cover,
          ),
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: kInactiveColor.withOpacity(0.5),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: kAppBarTextStyle.copyWith(
                  fontSize: 20,
                  color: kButtonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
