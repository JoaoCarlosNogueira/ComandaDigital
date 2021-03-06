import 'package:comanda_digital/Screens/RestaurantCommandOpenedListScreen.dart';
import 'package:comanda_digital/Screens/RestaurantCommandAddScreen.dart';
import 'package:comanda_digital/Screens/getrequest.dart';
import 'package:comanda_digital/Screens/itemAdddScreen.dart';
import 'package:comanda_digital/Screens/login/EmployeeListScreen.dart';
import 'package:comanda_digital/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      title: 'Flutter - Comanda Digital',
      initialRoute: '/login',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/additem': (context) => const ItemAddScreen(),
        '/listUsers': (context) => const EmployeeListScreen(),
        '/addcomanda': (context) => RestaurantCommandAddScreen(),
        '/getcomanda': (context) => const CommandOpenedListScreen(),
        // '/addpedido': (context) => RestaurantCommandAddScreen(),
        '/getRequest': (context) => GetRequest(),
      },
    );
  }
}
