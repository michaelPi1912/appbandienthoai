// ignore_for_file: file_names

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:project_final/screen/cartPage.dart';
import 'package:project_final/screen/homePage.dart';
import 'package:project_final/screen/profilePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> _pages;
  int currentIndex = 0;
  late List<BottomNavigationBarItem> _items;
  late BottomNavigationBar bottomNavigationBar;


  _updatePages(){
    _pages = [
      const HomePage(),
      const CartPage(),
      const ProfilePage(),
    ];
    _items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      backgroundColor: Colors.white,
      ),
      const BottomNavigationBarItem(
      icon: Icon(Icons.add_shopping_cart),
      label: 'Cart',
      backgroundColor: Colors.white,
      ),
      const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Profile',
      backgroundColor: Colors.white,
      ),
    ];
    bottomNavigationBar = BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) =>setState(() => currentIndex=index),
      backgroundColor: Colors.amber,
      items: _items);
    assert(_pages.length == _items.length);
  }
  @override
  void initState() {
    _updatePages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack( 
        index: currentIndex,
        children: _pages,),
        bottomNavigationBar: bottomNavigationBar
    );
  }
}