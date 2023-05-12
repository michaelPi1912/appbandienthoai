import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/UserModel.dart';
import '../variable.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});


  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  String? _dropDownValue;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    fullNameController.dispose();
    nickNameController.dispose();
    countryController.dispose();
    super.dispose();
  }

  updateProfile(String fullname, String country,String gender, String nickName) async {
    Map data = {
      'birthDate': null,
      'country': country,
      'fullName': fullname,
      "gender": gender,
      "nickName": nickName
    };
    Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*", "Authorization": "Bearer " + token!};
    var jsonResponse = null;
    var response = await http.put(Uri.parse('https://phone-s.herokuapp.com/api/user/profile/changeInfo'),
                             body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200) {
      Navigator.pop(context,"update");
    }
    else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, "aaa"),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              const Text("Update Profile"),
              Table(
              border: TableBorder.all(color: Colors.white),
              children: [
                TableRow(
                  children:[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Full Name:")),
                    TextField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      hintText: "Enter your name"
                    ),
                    )
                  ]),
                  TableRow(
                  children:[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child:Text("Gender:")),
                    DropdownButton(
                        hint: _dropDownValue == null
                            ? const Text('Gender', textAlign: TextAlign.center,)
                            : Text(
                                _dropDownValue!,
                                style: TextStyle(color: Colors.blue),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: const TextStyle(color: Colors.blue),
                        items: ['Nam','Nữ','Khác'].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValue = val!;
                            },
                          );
                        },
                      )
                  ]),
                  TableRow(
                  children:[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child:Text("Country:")),
                    TextField(
                      controller: countryController,
                      decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      hintText: "Enter your country"
                    ),
                    )
                  ]),
                  TableRow(
                  children:[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child:Text("Nick Name:",)),
                    TextField(
                      controller: nickNameController,
                      decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      hintText: "Enter your Nick name"
                    ),
                    )
                  ])
              ],),
              ElevatedButton(onPressed: (){
                updateProfile(fullNameController.text, countryController.text, _dropDownValue.toString(), nickNameController.text);
              }, child: const Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}