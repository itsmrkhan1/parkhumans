import 'package:flutter/material.dart';
import 'package:phproject/components/product_tile.dart';
import 'package:phproject/components/shop_drawer.dart';
import 'package:phproject/models/shop.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {

    // access products in shop
    final products = context.watch<Shop>().shop;

return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          "E X C L U S I V E S",
          style: TextStyle(color: Colors.white), // Change title text color to white
        ),
        backgroundColor: const Color.fromARGB(255, 0, 136, 255), // Change AppBar color to blue
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 1)),
        centerTitle: true,
        actions: [
          // go to cart button
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart_page'),
            icon: const Icon(Icons.shopping_cart_outlined),
          )
        ],
        ),
        drawer: const ShopDrawer(),
        body: ListView(
          children: [
            const SizedBox(height: 25),
            // shop title

            //shop subtitle
            const Center(
              child: Text(
                "ParkHumans Exclusive Events",
                style: TextStyle(
                  color: Colors.black
              ),),
              ),

            // product list
            SizedBox(
              height: 550,
              child: ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  // get each individual product from shop
                  final product = products[index];
          
                  // return as a product tile UI
                  return MyProductTile(product: product);
          
            },
          ),
        ),

          ],
        ),
    );
  }
}