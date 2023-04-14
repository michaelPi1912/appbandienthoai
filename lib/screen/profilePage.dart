// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_final/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  late SharedPreferences sharedPreferences;
  bool isLogin = false;
  //anh xa textfield
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  User? user; 
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null){
      setState(() {
        isLogin = false;
      });
    }else{
      setState(() {
        isLogin = true;
      });
    }
  }
    
  
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneController.dispose();
    super.dispose();
  }

  void disposeP() {
    // Clean up the controller when the widget is disposed.
    passwordController.dispose();
    super.dispose();
  }
  //Sign In Void
  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'phone': email,
      'password': pass
    };
    Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*",};
    var jsonResponse = null;
    var response = await http.post(Uri.parse('https://phone-s.herokuapp.com/api/auth/login'),
                             body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        //Xu ly data User from body
        setState(() {
          isLogin = true;
        });
        sharedPreferences.setString("token", jsonResponse['data']['accessToken']);
      }
    }
    else {
      setState(() {
        isLogin = false;
      });
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
          child: Container(
            color: Colors.red,
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 56,
            width: MediaQuery.of(context).size.width,
            child: isLogin ? detailProfilePage() : LoginForm(),
          ),
        ),
      ]),
    );
  }
  //isLogin == true
  Widget detailProfilePage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://i.pinimg.com/736x/d0/0c/5a/d00c5aac0b36935bdb01d05aea3da010.jpg"),
            fit: BoxFit.cover,
          ),),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:[
                  //Avatar
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://i.pinimg.com/736x/d0/0c/5a/d00c5aac0b36935bdb01d05aea3da010.jpg'),
                      radius: 120,
                    ),
                  ),
                  // Text(user!.email.toString()),
                  //Info
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        alignment: Alignment.centerLeft,
                        primary: Color.fromARGB(100, 22, 44, 33),
                    ),
                    icon: const Icon(Icons.person),
                    onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                  },label: const Text("Thông tin tài khoản"),),
                  //History
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        alignment: Alignment.centerLeft,
                        primary: Color.fromARGB(100, 22, 44, 33),
                    ),
                    icon: const Icon(Icons.history),
                    onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                  },label: const Text("Lịch sử mua hàng"),),
                  //Notice
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        alignment: Alignment.centerLeft,
                        primary: Color.fromARGB(100, 22, 44, 33),
                    ),
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                  },label: const Text("Thông báo"),),
                  // Favorite Product
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        alignment: Alignment.centerLeft,
                        primary: Color.fromARGB(100, 22, 44, 33),
                    ),
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                  },label: const Text("Sản phẩm yêu thích"),),
                  // Discount
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        alignment: Alignment.centerLeft,
                        primary: Color.fromARGB(100, 22, 44, 33),
                    ),
                    icon: const Icon(Icons.discount),
                    onPressed: () {
                    
                  },label: const Text("Ưu đãi của bạn"),),
                  //Logout
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        alignment: Alignment.centerLeft,
                        primary: Color.fromARGB(100, 22, 44, 33),
                    ),
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      sharedPreferences.clear;
                      sharedPreferences.commit();
                      setState(() {
                        isLogin = false;
                      });
                  },label: const Text("Log out"),),
                  ]),
      ),
    );
  }
  //isLogin == false
  Widget LoginForm() {
    return Container(
      // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/100),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://wallpaperaccess.com/full/1838440.jpg"),
            fit: BoxFit.cover,
          ),),
      child: 
        Container(
        color:  Color.fromARGB(100, 22, 44, 33),
        height: (MediaQuery.of(context).size.height - 56)/2,
        width: MediaQuery.of(context).size.width/2,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Log In" ,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70),
                      ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () { 
                    signIn(phoneController.text, passwordController.text);
                },
              child: const Text("Login", style: TextStyle(color: Colors.white70),),),
          ],
          
        ),
      ),
    );
  }
}

 
 