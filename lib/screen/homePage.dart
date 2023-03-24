// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../network/networkApi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        child: 
        FutureBuilder(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Image.network(snapshot.data![index].image.toString()),
                    title: Text(snapshot.data![index].name.toString()),
                    subtitle: Text(snapshot.data![index].description.toString()),
                    onTap: (){
                    },
                  );
                })
                );
            }else if(snapshot.hasError){
              return Container(
                child: Center(
                  child: Text("Not Found Data"),
                ),
              );
            }else{
              return Container(
                child: Center(
                  child: CircularProgressIndicator()),
              );
            }
          }),
      ),
    );
  }
}