import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProductsProvider with ChangeNotifier {
  List<ProductModel> productsList = [];

  Future<void> getProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      productsList = [];
      for (var element in productsSnapshot.docs) {
        productsList.add(
          ProductModel(
            productId: element.get('productId'),
            title: element.get('title'),
            quantity: element.get('quantity'),
            productCategoryName: element.get('productCategoryName'),
            isFavorite: element.get('isFavorite'),
            isPopular: element.get('isPopular'),
            price: element.get('price'),
            imageUrl: element.get('imageUrl'),
            description: element.get('description'),
            brand: element.get('brand'),
          ),
        );
      }
    }).catchError((error) {});
  }

  List<ProductModel> findByCategory({
    required String categoryName,
  }) {
    List<ProductModel> categoriesList = productsList
        .where((element) => element.productCategoryName!
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return categoriesList;
  }

  List<ProductModel> findByBrand({
    required String brandName,
  }) {
    List<ProductModel> brandsList = [];
    brandsList = productsList
        .where((element) =>
            element.brand!.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
    if (brandName == 'All') {
      for (int i = 0; i < productsList.length; i++) {
        if (productsList[i].brand != 'No Brand') {
          brandsList.add(productsList[i]);
        }
      }
    }
    return brandsList;
  }

  List<ProductModel> get popularProduct {
    return productsList.where((element) => element.isPopular!).toList();
  }

  ProductModel findById(String productId) {
    return productsList.firstWhere((element) =>
        element.productId!.toLowerCase() == productId.toLowerCase());
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> searchList = productsList
        .where((element) => element.productCategoryName!
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  File? productImage;
  void getProductImage({
    required ImageSource source,
  }) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      productImage = File(pickedImage.path);
      notifyListeners();
    }
  }

  var uuid = const Uuid();

  Future<void> uploadProduct({
    required String title,
    required double price,
    required String categoryName,
    required String brandName,
    required String description,
    required String quantity,
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(productImage!.path).pathSegments.last}')
        .putFile(productImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            ProductModel model = ProductModel(
              productId: uuid.v4(),
              userId: userId,
              title: title,
              price: price,
              imageUrl: value,
              brand: brandName,
              description: description,
              isFavorite: false,
              isPopular: false,
              productCategoryName: categoryName,
              quantity: 0,
              createdAt: Timestamp.now().toString(),
            );
            FirebaseFirestore.instance
                .collection('products')
                .doc(uuid.v4())
                .set(model.toJson());
          },
        );
      },
    );
  }

}
