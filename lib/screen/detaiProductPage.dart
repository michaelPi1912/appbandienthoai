// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_final/model/productModel.dart';

class detailProduct extends StatefulWidget {
  const detailProduct({super.key, required this.product});

  final Product product;

  @override
  State<detailProduct> createState() => _detailProductState();
}

class _detailProductState extends State<detailProduct> {

  late Product product;
  
  int _countProduct =0;
  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: ListView(
        children: <Widget>[ 
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
                        decoration: BoxDecoration(color: Colors.amber),
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
                                  Row(
                                    children: [
                                      ElevatedButton(onPressed: (){}, child: Text(product.listAttributeOption![0].values![0].value.toString())),
                                      const SizedBox(width: 10,),
                                      ElevatedButton(onPressed: (){}, child: Text(product.listAttributeOption![0].values![1].value.toString())),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      ElevatedButton(onPressed: () {
                                          decreaseProduct();
                                      }, child: Text("-")),
                                      DecoratedBox(
                                        
                                        decoration: const BoxDecoration(color: Colors.blue),
                                        child:  Text(_countProduct.toString()),
                                      ),
                                      ElevatedButton(onPressed: () {
                                        increaseProduct();
                                      }, child: Text("+")),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Tổng tiền: "+product.price.toString()+"đ",
                                      style:  const TextStyle(
                                        // color: Colors.red, 
                                        fontSize: 16),
                                        )
                                  ),
                                  const SizedBox(height: 5,),
                                  ElevatedButton(onPressed: (){}, 
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
  
  // Widget totalProduct() {
  //   return Text(countProduct.toString());
  // }
  
  void increaseProduct() {
    setState(() {
      _countProduct++;
      if(_countProduct > 5)
        _countProduct = 5;
    });
    
  }
  void decreaseProduct() {
    setState(() {
      _countProduct--;
      if(_countProduct < 0)
        _countProduct = 0;
    });
    
  }
}



