import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_final/network/networkApi.dart';
import 'package:project_final/screen/detailOrder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/oderModel.dart';
import '../variable.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key,});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  late Future<List<Order>> _listPOrder;
  late Future<List<Order>> _listDOrder;
  late Future<List<Order>> _listSOrder;
  late Future<List<Order>> _listCOrder;
  
  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") !=null){
      token = sharedPreferences.getString("token");
      setState(() {
        _listPOrder = fetchPOder(token!);
        _listDOrder = fetchDOder(token!); 
        _listSOrder = fetchSOder(token!);
        _listCOrder = fetchCOder(token!);
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, 
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
              tabs: [
                Tab(
                   text: ("Đang xử lý"),
                ),
                Tab(
                  text: ("Đang vận chuyển"),
                ),
                Tab(text: ("Đã giao"),
                ),
                Tab(text: ("Đã hủy"),
                )
              ],
            ),
        ),
        body: TabBarView(children: [
          ListOrder(_listPOrder, 0),
          ListOrder(_listDOrder, 1),
          ListOrder(_listSOrder, 2),
          ListOrder(_listCOrder, 3)
        ]), 
      ));
  }

  Column ListOrder(Future<List<Order>> listOrder, int index){
    return Column(
            children: [    
              Container( 
                child: FutureBuilder(
                    future: listOrder,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                    String rs = await Navigator.push(context,MaterialPageRoute(
                                    builder: (context) => DetailOrder(index: index,order: snapshot.data![index],)));   
                                    if(rs == "cancle"){
                                      setState(() {
                                        _listPOrder = fetchPOder(token!);
                                        _listDOrder = fetchDOder(token!); 
                                        _listSOrder = fetchSOder(token!);
                                        _listCOrder = fetchCOder(token!);
                                      });
                                    }
                                    },
                              child: Card(
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Text(snapshot.data![index].name.toString())), 
                                          ],
                                        ), 
                                      ],
                                    ) 
                                  ]),
                              ),
                            );
                          },
                        );
                      }else if(snapshot.hasError){
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                  }),
              ),
            ],
          );
  }
}