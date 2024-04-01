import 'package:flutter/material.dart';
import 'package:phproject/auth/auth.dart';
import 'package:phproject/models/shop.dart';
import 'package:phproject/pages/cart_page.dart';
import 'package:phproject/pages/shop_intro_page.dart';
import 'package:phproject/pages/shop_page.dart';
import 'package:phproject/auth/login_or_register.dart';
import 'package:phproject/pages/home_page.dart';
import 'package:phproject/pages/profile_page.dart';
import 'package:phproject/pages/users_page.dart';
import 'package:phproject/theme/dark_mode.dart';
import 'package:phproject/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(
    ChangeNotifierProvider(create: (context) => Shop(),
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors
      home: const AuthPage(),
      theme: LightMode,
      darkTheme: DarkMode,
      routes: {
      
        '/login_register_page':(context) => const LoginOrRegister(),
        '/home_page':(context) => HomePage(),
        '/profile_page':(context) => ProfilePage(),
        '/users_page':(context) => const UsersPage(),
        '/shop_intro_page':(context) => const IntroPage(),
        '/shop_page':(context) => const ShopPage(),
        '/cart_page': (context) => const CartPage(),
      },
    );
  }
}
