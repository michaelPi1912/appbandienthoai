
// ignore_for_file: file_names

import 'package:flutter/material.dart';
class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Order'),
    );
  }
}