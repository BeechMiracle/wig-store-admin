import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled1_admin/constants.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Products',
              style: kAppBarTextStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 150,
              child: TextField(
                textInputAction: TextInputAction.search,
                cursorColor: const Color(0xFF141414),
                style: kAppBarTextStyle,
                decoration: searchTextField,
                onSubmitted: (value) {
                  smallSearchProducts(value, context);
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('Product').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFE9E9E9),
                  ),
                );
              }
              if (snapshot.hasData) {
                List<Product> products = snapshot.data!.docs.map((product) {
                  return Product(
                      id: product.get('id'),
                      productName: product.get('Name'),
                      productCategory: product.get('Category'),
                      productDescription: product.get('Description'),
                      productRating: product.get('Rating'),
                      productPrice: product.get('Price'),
                      imageUrl: [
                        product.get('Image')[0],
                        product.get('Image')[1],
                        product.get('Image')[2],
                        product.get('Image')[2],
                      ]);
                }).toList();
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 300,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    Product product = products[index];

                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 200,
                                child: Image.network(product.imageUrl[0]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                product.productName,
                                style: kAppBarTextStyle.copyWith(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "#${product.productPrice}",
                                style: kAppBarTextStyle.copyWith(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              RatingBar.builder(
                                  initialRating: double.parse(
                                    product.productRating,
                                  ),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 15,
                                  itemPadding:
                                      const EdgeInsets.only(right: 2.0),
                                  itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 5,
                                      ),
                                  onRatingUpdate: (rating) {
                                    if (kDebugMode) {
                                      print(rating);
                                    }
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return Center(
                child: Text(
                  'Product is not available yet!',
                  style: kAppBarTextStyle,
                ),
              );
            }),
      ),
    );
  }
}
