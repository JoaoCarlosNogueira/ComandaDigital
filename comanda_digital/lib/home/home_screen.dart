import 'package:comanda_digital/Screens/RequestAddScreen.dart';
import 'package:comanda_digital/Screens/dashboard/dashboard_screen.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(DashboardScreen());
    // pageList.add(SecondPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App de Comanda Digital"),
      ),
      body: IndexedStack(
        children: pageList,
        index: _selectedPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: "Categorias"),
          // BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
