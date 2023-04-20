
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_final/network/networkApi.dart';
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  //check dang nhap, xu ly lai logic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: 
              FutureBuilder(
                future: fetchCart(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Row(
                            children: [
                              Text(snapshot.data![index].name.toString())
                            ]),
                        );
                      },
                    );
                  }else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
              })
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {},
                child: const Text("Thanh Toán")),
              ),
            ))
        ],
      )
    );
  }
}