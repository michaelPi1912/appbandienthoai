// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_final/model/productModel.dart';
import 'package:project_final/screen/cartPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../variable.dart';

class detailProduct extends StatefulWidget {
  const detailProduct({super.key, required this.product});

  final Product product;

  @override
  State<detailProduct> createState() => _detailProductState();
}

class _detailProductState extends State<detailProduct> {

  late Product product;
  
  

  int _countProduct = 1;
  @override
  void initState() {
    super.initState();
    product = widget.product;
    getToken();
  }
  getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.getString("token");
    });
  }

  @override
  Widget build(BuildContext context) {
    
    bool IsAdd = false;
    
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: ListView(
        children: <Widget>[ 
          // IconButton(onPressed: (){
          //   if(IsAdd){
          //     Navigator.pop(context, "refresh");
          //   }else{
          //     Navigator.pop(context, "aaa");
          //   }
          // }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20, bottom: 5.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white
              ),
              child: Column(   
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name.toString(), 
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  Row(
                    children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.all(4.0),
                         child: Column(
                            children: <Widget>[
                              //Image.network(product.image.toString(), width: 250,height: 250,),
                              Image.network(product.img!.isNotEmpty ? product.img![0].toString(): product.image.toString(), width: MediaQuery.of(context).size.width*0.4,
                              height: 250,)
                            ],
                          ),
                       ),
                       Container(
                        decoration: BoxDecoration(
                          // color: Colors.amber
                          ),
                         child: SizedBox(
                            height: 250,
                            width: MediaQuery.of(context).size.width*0.45,
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text("ROM"),
                                  const SizedBox(height: 5,),
                                  //lai du lieu rom tren json
                                  Row(
                                    children: [
                                      ElevatedButton(onPressed: (){}, child: Text(product.listAttributeOption![0].values![0].value.toString())),
                                      // const SizedBox(width: 10,),
                                      // ElevatedButton(onPressed: (){}, child: Text(product.listAttributeOption![0].values![1].value.toString())),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      ElevatedButton(onPressed: () {
                                          decreaseProduct();
                                      }, child: Text("-")),
                                      SizedBox(width: 5,),
                                      SizedBox(
                                        height: 20,
                                        width: 35,
                                        child: DecoratedBox(                                        
                                          decoration: const BoxDecoration(color: Colors.white60,),
                                          child:  Center(child: Text(_countProduct.toString())),
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      ElevatedButton(onPressed: () {
                                          increaseProduct();
                                        }, child: Text("+")),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Tổng tiền: "+(product.price!*_countProduct).toString()+"đ",
                                      style:  const TextStyle(
                                        // color: Colors.red, 
                                        fontSize: 16),
                                        )
                                  ),
                                  const SizedBox(height: 5,),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green, // Background color
                                    ),
                                    onPressed: (){
                                      if(token !=null){
                                        addProducttoCart();
                                        IsAdd = true;
                                      }else{
                                        print("add failse");
                                      }
                                    }, 
                                    child: RichText(
                                    text: const TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Icon(Icons.shopping_basket),
                                          ),
                                        ),
                                        TextSpan(text: 'Thêm vào giỏ hàng'),
                                      ],
                                    ),
                                  )),
                                  const SizedBox(height: 5,),
                                  ElevatedButton(onPressed: (){}, 
                                  child: RichText(
                                    text: const TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Icon(Icons.favorite),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))     
                                ],
                              ),
                           ),
                         ),
                       ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Mô Tả Sản Phẩm", 
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(product.description.toString(),
                      style: TextStyle(
                        fontSize: 14
                      ),
                      )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  // increase Product void
  void increaseProduct() {
    setState(() {
      _countProduct++;
      if(_countProduct > 5)
        _countProduct = 5;
    });
    
  }
  //decrease Product void
  void decreaseProduct() {
    setState(() {
      _countProduct--;
      if(_countProduct < 1)
        _countProduct = 1;
    });
    
  }
  
  void addProducttoCart() async{
    Map data = {
      "listAttribute": [
        product.listAttributeOption![0].values![0].id
      ],
      "productId": product.id,
      "quantity": _countProduct
    };
    Map<String,String> headers ={"content-type" : "application/json",
                              "accept" : "*/*","Authorization": "Bearer " + token!};
    var res = await   http.post(Uri.parse('https://phone-s.herokuapp.com/api/user/cart/insert'),
                             body: jsonEncode(data), headers: headers);
    var json =null;
    if(res.statusCode == 200){
      // json = json.decode(res.body);
      print("add success");
    }else{
      print(res.body);
    }                      
  }
}



