// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:project_final/model/productModel.dart';
import 'package:http/http.dart' as http;

List<Product> parseProduct(String resBody){
  var list = json.decode(resBody) as List<dynamic>;
  List<Product> products = list.map((model) => Product.fromJson(model)).toList();
  return products;
}

Future<List<Product>> fetchProducts() async{
  final res = await http.get(Uri.parse('https://phone-s.herokuapp.com/api/product/all'));
  if(res.statusCode == 200){
    return compute(parseProduct, res.body);
  }else{
    throw Exception('Request API error');
  }
}