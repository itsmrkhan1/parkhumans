import 'package:flutter/material.dart';
import 'package:phproject/models/product.dart';

class Shop extends ChangeNotifier {

  //products for sale
  final List<Product> _shop = [
    // product 1
    Product(name: "Name",
    price: 00.00,
    description: "description",
    imagePath: "" 
    ),
    // product 2
    Product(name: "Name",
    price: 00.00,
    description: "description",
    imagePath: "" 
    ),
    // product 3
    Product(name: "Name",
    price: 00.00,
    description: "description",
    imagePath: "" 
    ),

  ];


 // user cart
 List<Product> _cart = [];

 // get product list
 List<Product> get shop => _shop;

 //get user cart
 List<Product> get cart => _cart;

 // add item to cart
 void addToCart(Product item) {
  _cart.add(item);
  notifyListeners();
 }

 // remove item from cart
 void removedFromCar(Product item) {
  _cart.remove(item);
  notifyListeners();
 }

  void removeItemFromCart(Product product) {}

  void removeFromCart(Product product) {}

}