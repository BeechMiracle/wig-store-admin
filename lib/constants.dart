import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'nav screens/search_screen.dart';

const kPrimaryColor = Color(0xFFE9E9E9);
const kButtonColor = Color(0xFF141414);
const kSecondaryColor = Colors.white;
const kInactiveColor = Color(0xFF707070);
const kTitleTextStyle = TextStyle(
  color: kButtonColor,
  fontSize: 15,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
);
TextStyle kAppBarTextStyle = GoogleFonts.roboto(
  textStyle: const TextStyle(
    color: Color(0xFF141414),
    fontSize: 15,
    fontWeight: FontWeight.normal,
  ),
);

final searchTextField = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 16,
    ),
    isDense: true,
    filled: true,
    fillColor: const Color(0xFFFFFFFF),
    hintStyle: TextStyle(
      color: const Color(0xFF141414).withOpacity(0.2),
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
    prefixIcon: const Icon(
      Icons.search,
      color: Color(0xFF141414),
      size: 15,
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none));

final textFieldStyle = InputDecoration(
    filled: true,
    fillColor: kSecondaryColor,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ));

class Product {
  final String id;
  final String productName;
  final String productCategory;
  final String productDescription;
  final String productRating;
  final String productPrice;
  final List<String> imageUrl;

  Product({
    required this.id,
    required this.productName,
    required this.productCategory,
    required this.productDescription,
    required this.productRating,
    required this.productPrice,
    required this.imageUrl,
  });
  factory Product.fromSnapshot(DocumentSnapshot doc) {
    return Product(
      id: doc.get('id'),
      productName: doc.get('Name'),
      productDescription: doc.get('Description'),
      productPrice: doc.get('Price'),
      productCategory: doc.get('Category'),
      productRating: doc.get('Rating'),
      imageUrl: [
        doc.get('Image')[0],
        doc.get('Image')[1],
        doc.get('Image')[2],
        doc.get('Image')[3],
      ],
    );
  }
}

Future<void> smallSearchProducts(String query, BuildContext context) async {
  try {
    List<Product> foundProducts = [];
    final productsSnapshot =
        await FirebaseFirestore.instance.collection('Product').get();
    for (var productDoc in productsSnapshot.docs) {
      final product = Product.fromSnapshot(productDoc);
      if (product.productName.toLowerCase().contains(query.toLowerCase())) {
        foundProducts.add(product);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SmallSearchScreen(searchResults: foundProducts),
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print('Error searching products: $e');
    }
    // show error dialog or snackBar
  }
}
