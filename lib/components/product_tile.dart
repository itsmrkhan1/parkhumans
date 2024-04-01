import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phproject/models/product.dart';
import 'package:phproject/models/shop.dart';
import 'package:provider/provider.dart';

class MyProductTile extends StatelessWidget {
  final Product product;

  const MyProductTile({
    super.key,
    required this.product,
  });

  // add to cart button pressed
  void addToCart(BuildContext context) {
    // show a dialog box to ask user to confirm to add to cart
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: const Text("Add this item to your cart?"),
        actions: [
          // cancel button
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          // yes button
          MaterialButton(
            onPressed: () {
              // pop dialog box
              Navigator.pop(context);

              // add to cart
              context.read<Shop>().addToCart(product);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue,
      borderRadius: BorderRadius.circular(12), 
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
            // product image
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                child: const Icon(Icons.star_border),
                ),
          ),

          const SizedBox(height: 25),

          // product name
          Text(
            product.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
          ),
          ),

          const SizedBox(height: 10),

          // product description
          Text(product.description,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 25),],),

          // product price + add to cart button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // product price
              Text('\$' + product.price.toStringAsFixed(2)),

              // add to cart button
              Container(
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => addToCart(context),
                  icon: const Icon(Icons.add),
                  ),
              ),
            ],
          ),
        ],
      )
    );
  }
}