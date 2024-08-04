import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Orders',
            style: kAppBarTextStyle.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Orders').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFE9E9E9),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!.docs
                        .map(
                          (orders) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Name:',
                                              style: kAppBarTextStyle.copyWith(
                                                  color:
                                                      const Color(0xFF707070),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${orders.get('First Name')} ${orders.get('Last Name')}',
                                                style:
                                                    kAppBarTextStyle.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Email:',
                                              style: kAppBarTextStyle.copyWith(
                                                  color:
                                                      const Color(0xFF707070),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                orders.get('Email'),
                                                style: kAppBarTextStyle
                                                    .copyWith(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Phone Number:',
                                              style: kAppBarTextStyle.copyWith(
                                                  color:
                                                      const Color(0xFF707070),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                orders.get('Phone Number'),
                                                style: kAppBarTextStyle
                                                    .copyWith(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Total Price:',
                                              style: kAppBarTextStyle.copyWith(
                                                  color:
                                                      const Color(0xFF707070),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                orders.get('Price'),
                                                style: kAppBarTextStyle
                                                    .copyWith(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Order No./Reference No.:',
                                              style: kAppBarTextStyle.copyWith(
                                                  color:
                                                      const Color(0xFF707070),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                orders.get('Reference'),
                                                style: kAppBarTextStyle
                                                    .copyWith(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Delivery Address:',
                                              style: kAppBarTextStyle.copyWith(
                                                  color:
                                                      const Color(0xFF707070),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                orders.get('Address'),
                                                style: kAppBarTextStyle
                                                    .copyWith(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Date & Time:',
                                              style: kAppBarTextStyle.copyWith(
                                                  color:
                                                      const Color(0xFF707070),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${orders.get('time-stamp').toDate().toString()} UTC+1',
                                                style: kAppBarTextStyle
                                                    .copyWith(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: List<String>.from(
                                          orders.get('Product Name'))
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      margin: const EdgeInsets.all(8),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image(
                                              image: NetworkImage(
                                                  orders.get('imgUrl')[index]),
                                              height: 150,
                                              width: 150,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    orders.get(
                                                        'Product Name')[index],
                                                    style: kAppBarTextStyle
                                                        .copyWith(fontSize: 12),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    orders.get(
                                                        'Product Price')[index],
                                                    style: kAppBarTextStyle
                                                        .copyWith(fontSize: 12),
                                                  ),
                                                  Text(
                                                    orders
                                                        .get('Quantity')[index],
                                                    style: kAppBarTextStyle
                                                        .copyWith(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
                return Center(
                  child: Text(
                    'Order is empty!',
                    style: kAppBarTextStyle,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
