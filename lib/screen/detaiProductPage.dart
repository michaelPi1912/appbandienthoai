// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_final/model/productModel.dart';

class detailProduct extends StatelessWidget {
  const detailProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text(product.id.toString()),
          Text(product.name.toString()),
        ],
      ),
    );
  }
}
