import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_final/model/UserModel.dart';
import 'package:project_final/network/networkApi.dart';
import 'package:http/http.dart' as http;

import '../model/cartModel.dart';
import '../variable.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, required this.listProduct, required this.listCart, required this.total});

  final List<Cart> listProduct;
  final List<String> listCart;
  final int total;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  late List<Cart> listProduct;
  late List<String> listCart;
  late int total;
  late String address;
  late Future<List<Address>> _futureAddress;
  late String idAddress;

  @override
  void initState() {
    listCart = widget.listCart;
    listProduct = widget.listProduct;
    total = widget.total;
    getAddress();
    getIdAddress();
    super.initState();
  }
  void getAddress(){
    _futureAddress = fetchAddress(token!);
  }
  void getIdAddress(){
    _futureAddress.then((value) => {
      idAddress= value[0].id!
    });
  }
  Order() async {
    Map data = {
      "address": idAddress,
      "listCart": listCart,
      "nullVoucher": true,
      "payment": 1,
      "ship": 1,
      "voucher": ""
    };
    Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + token!};
    var jsonResponse = null;
    var response = await http.post(Uri.parse('https://phone-s.herokuapp.com/api/user/order/insert'),
                             body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200) {
      print("order success");
      // ignore: use_build_context_synchronously
      Navigator.pop(context, "success");
    }
    else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(onPressed:() => Navigator.pop(context, "back"), child: const Text("back")),
          ElevatedButton(onPressed: () {
          Order();
        }, child: const Text("Thanh toan khi giao hang")),
        ]
        
      ),
    );
  }
}