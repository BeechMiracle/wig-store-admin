import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled1_admin/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<File> images = [];

  final dateTime = DateTime.now();

  // bool dismissible = false;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productRatingController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  void clearField() {
    productNameController.clear();
    productCategoryController.clear();
    productQuantityController.clear();
    productRatingController.clear();
    productDescriptionController.clear();
    productPriceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        TextField(
          controller: productNameController,
          cursorColor: kButtonColor.withOpacity(0.2),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          style: kTitleTextStyle.copyWith(fontWeight: FontWeight.normal),
          decoration: textFieldStyle.copyWith(
            labelText: 'Name',
            labelStyle:
                kTitleTextStyle.copyWith(fontSize: 12, letterSpacing: 0),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        TextField(
          controller: productCategoryController,
          cursorColor: kButtonColor.withOpacity(0.2),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          style: kTitleTextStyle.copyWith(fontWeight: FontWeight.normal),
          decoration: textFieldStyle.copyWith(
            labelText: 'Category',
            labelStyle:
                kTitleTextStyle.copyWith(fontSize: 12, letterSpacing: 0),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              height: 50,
              child: TextField(
                controller: productQuantityController,
                cursorColor: kButtonColor.withOpacity(0.2),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                style: kTitleTextStyle.copyWith(fontWeight: FontWeight.normal),
                decoration: textFieldStyle.copyWith(
                  labelText: 'Quantity',
                  labelStyle:
                      kTitleTextStyle.copyWith(fontSize: 12, letterSpacing: 0),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: TextField(
                controller: productRatingController,
                cursorColor: kButtonColor.withOpacity(0.2),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                style: kTitleTextStyle.copyWith(fontWeight: FontWeight.normal),
                decoration: textFieldStyle.copyWith(
                  labelText: 'Rating',
                  labelStyle:
                      kTitleTextStyle.copyWith(fontSize: 12, letterSpacing: 0),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        TextField(
          controller: productDescriptionController,
          maxLines: 10,
          cursorColor: kButtonColor.withOpacity(0.2),
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          style: kTitleTextStyle.copyWith(fontWeight: FontWeight.normal),
          decoration: textFieldStyle.copyWith(
            labelText: 'Description',
            labelStyle:
                kTitleTextStyle.copyWith(fontSize: 12, letterSpacing: 0),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              height: 50,
              child: TextField(
                controller: productPriceController,
                cursorColor: kButtonColor.withOpacity(0.2),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                style: kTitleTextStyle.copyWith(fontWeight: FontWeight.normal),
                decoration: textFieldStyle.copyWith(
                  labelText: 'Price',
                  labelStyle:
                      kTitleTextStyle.copyWith(fontSize: 12, letterSpacing: 0),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () {
                getMultipleImage();
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: kInactiveColor.withOpacity(0.5),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera,
                      color: kSecondaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add image',
                      style: kTitleTextStyle.copyWith(
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            width: double.infinity,
            height: 200,
            child: images.isEmpty
                ? const Center(
                    child: Text('No images found'),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150,
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: Image.file(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    itemCount: images.length,
                  )),
        const SizedBox(
          height: 50,
        ),
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: kInactiveColor,
                ),
              ),
              barrierDismissible: false,
            );
            for (int i = 0; i < images.length; i++) {
              String imageUrl = await uploadFile(images[i]);
              downloadUrls.add(imageUrl);

              if (i == images.length - 1) {
                storeData(
                  downloadUrls,
                  productNameController.text,
                  productCategoryController.text,
                  productQuantityController.text,
                  productRatingController.text,
                  productDescriptionController.text,
                  productPriceController.text,
                  dateTime,
                );
              }
            }
            clearField();
            setState(() {
              images = [];
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Product details is saved successfully.'),
            ));
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: kButtonColor,
            fixedSize: const Size(450, 50),
            elevation: 5,
          ),
          child: Text(
            'Save',
            style: kTitleTextStyle.copyWith(color: kSecondaryColor),
          ),
        )
      ],
    );
  }

  List<String> downloadUrls = [];

  final ImagePicker _picker = ImagePicker();

  getMultipleImage() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();

    // if (pickedImages == null) return;
    //
    // String fileName = DateTime.now().millisecondsSinceEpoch.toString();\
    //
    // Reference refRoot = FirebaseStorage.instance.ref();
    // Reference refDirImages = refRoot.child('images');
    // Reference uploadRefImage = refDirImages.child('name');
    //
    // try {
    // await uploadRefImage.putFile(File(pickedImages!.toString()));
    //
    // imageUrl = await uploadRefImage.getDownloadURL();
    // } catch (error) {return error;}

    if (pickedImages != null) {
      pickedImages.forEach((e) {
        images.add(File(e.path));
      });

      setState(() {});
    }
  }

  Future<String> uploadFile(File file) async {
    final refRoot = FirebaseStorage.instance.ref();
    Reference refImages =
        refRoot.child('images/${DateTime.now().microsecondsSinceEpoch}.jpg');
    final uploadRefImage = refImages.putFile(file);

    final imageSnapshot = await uploadRefImage.whenComplete(() => null);
    String url = await imageSnapshot.ref.getDownloadURL();
    return url;
  }

  storeData(
    List<String> imageUrls,
    String productName,
    String productCategory,
    String productQuantity,
    String productRating,
    String productDescription,
    String productPrice,
    DateTime now,
  ) {
    FirebaseFirestore.instance.collection('Product').add({
      'Image': imageUrls,
      'Name': productName,
      'Category': productCategory,
      'Quantity': productQuantity,
      'Rating': productRating,
      'Description': productDescription,
      'Price': productPrice,
      'time-stamp': now,
    }).then((value) {
      if (kDebugMode) {
        print(value.id);
      }
    });
  }
}
