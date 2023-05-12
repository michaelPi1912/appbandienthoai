
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_final/network/networkApi.dart';
import 'package:project_final/screen/detaiProductPage.dart';
import 'package:project_final/screen/homePage.dart';
import 'package:project_final/screen/orderPage.dart';
import 'package:project_final/variable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/cartModel.dart';
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> listCart = [];
  late List<Cart> listProduct;
  double total = 0;
  late Future<List<Cart>> _futureCart;
  String? name;

  @override
  void initState() {
    getToken(); 
    super.initState();
  }

  changeData(){
    setState(() {
      _futureCart = fetchCart(token!);
      
    });
  }

  void getData(){
    _futureCart.then((value) => {
      value.forEach((element) {
        listCart.add(element.id.toString());
        // listCart.add('"${element.id}"');
        total += (element.price!*element.quantity!);
      }),
      listProduct = value
    });
  }
  getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") != null){
      setState(() {
      token = sharedPreferences.getString("token");
      _futureCart = fetchCart(token!);
    });
    }
  }
  
  //check dang nhap, xu ly lai logic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          IconButton(onPressed: (){
            if(token!=null){
              setState(() {
                _futureCart = fetchCart(token!);
              });
            }
          }, icon: Icon(Icons.refresh, color: Colors.black,)),
          // Text(token??"aaa"),
          Expanded(
            child:
              // Check token
              token != null ? listCartBuilder()
              : const Text("Ban chua dang nhap") 
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () async {
                  if(token !=null){
                    getData();
                    chooseAllCart();
                  }
                },
                child: const Text("Mua Hàng")),
              ),
            )
          )
        ],
      )
    );
  }

  FutureBuilder listCartBuilder(){
    return FutureBuilder(
                future: _futureCart,
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
                              Row(
                                children: [
                                  Image.network(
                                    snapshot.data![index].image.toString(), 
                                    width: MediaQuery.of(context).size.width/2,
                                    height: MediaQuery.of(context).size.height/6,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(snapshot.data![index].name.toString())),
                                      
                                    ],
                                  ),
                                  ElevatedButton(onPressed: (){
                                    deleteCart(snapshot.data![index].id);
                                  }, child: Text("x"))
                                ],
                              )
                              
                            ]),
                        );
                      },
                    );
                  }else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
              });
  }
  
  deleteCart(String id) async {
    Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + token!};
    var jsonResponse = null;
    var response = await http.delete(Uri.parse('https://phone-s.herokuapp.com/api/user/cart/delete/'+id), headers: headers);
    if(response.statusCode == 200) {
      setState(() {
        _futureCart = fetchCart(token!);
      });
    }
      
  }

  chooseAllCart() async {
    Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + token!};

    var response = await http.put(Uri.parse('https://phone-s.herokuapp.com/api/user/cart/choose/all?status=true'), headers: headers);
    if(response.statusCode == 200){
      String order = await Navigator.push(context, MaterialPageRoute(builder: (context)
                                      => OrderPage(listCart: listCart, listProduct: listProduct,total: total,)));
      if(order == "success"){
        setState(() {
          _futureCart =fetchCart(token!);
        });
      }
      if(order =="back"){
        setState(() {
          listCart = [];
          listProduct =[];
          total =0;
        });
      }
    }else{
      print(response.body);
    }
  }
}