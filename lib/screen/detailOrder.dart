import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_final/model/oderModel.dart';

import '../variable.dart';

class DetailOrder extends StatefulWidget {
  DetailOrder({super.key, required this.index, required this.order});


  Order order;
  int index;

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {

  Order? order;
  int? index;

  @override
  void initState() {
    order = widget.order;
    index = widget.index;
    super.initState();
  }

  deleteOrder() async {
    Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + token!};
    var jsonResponse = null;
    var response = await http.delete(Uri.parse('https://phone-s.herokuapp.com/api/user/order/delete/${order!.orderId}'), headers: headers);
    if(response.statusCode == 200) {
      Navigator.pop(context,"cancle");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context,"aaaa"),
        ),
      ),
      body: Center(
        child: Column(children: [
          Text(order!.total.toString()),
          ElevatedButton(
            onPressed: (){
              deleteOrder();
            }, child: Text("Hủy đơn"))
        ]),
      ),
    );
  }
}