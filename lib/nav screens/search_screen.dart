import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled1_admin/constants.dart';

class SmallSearchScreen extends StatefulWidget {
  final List<Product> searchResults;

  const SmallSearchScreen({
    Key? key,
    required this.searchResults,
  }) : super(key: key);

  @override
  State<SmallSearchScreen> createState() => _SmallSearchScreenState();
}

class _SmallSearchScreenState extends State<SmallSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'Search results..',
              style: kAppBarTextStyle.copyWith(fontSize: 15),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 200,
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: widget.searchResults.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: Text('No results found..', style: kAppBarTextStyle),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.searchResults.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.searchResults[index].imageUrl[0]),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.searchResults[index].productName,
                                    style:
                                        kAppBarTextStyle.copyWith(fontSize: 12),
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  RatingBar.builder(
                                      initialRating: double.parse(
                                        widget
                                            .searchResults[index].productRating,
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
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    '#${widget.searchResults[index].productPrice}',
                                    style:
                                        kAppBarTextStyle.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
