import 'package:flutter/material.dart';
import 'package:phproject/components/shop_list_tile.dart';

class ShopDrawer extends StatelessWidget {
  const ShopDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [// drawer header: logo
          const DrawerHeader(
            child: Center(
              child: Icon(
                Icons.shopping_bag,
                size: 72,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // shop tile
          ShopListTile(
            text: "Shop",
            icon: Icons.home,
            color: Colors.white,
            onTap: () {
              //pop drawer first
            Navigator.pop(context);
            
              Navigator.pushNamed(context, '/shop_page');
            
  },),

          // cart tile
          ShopListTile(
            text: "Cart",
            icon: Icons.shopping_cart,
            color: Colors.white,
            onTap: () {
              // pop drawer first
              Navigator.pop(context);

              //go to cart page
              Navigator.pushNamed(context, '/cart_page');
  },),],),

          // exit shop tile
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: ShopListTile(
              text: "Exit",
              icon: Icons.logout,
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, '/home_page', (route) => false), color: Colors.white,
            ),
          ),
      ],
      ),
    );
  }
}