// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_final/model/UserModel.dart';
import 'package:project_final/variable.dart';
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

  User? _user; 

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if( sharedPreferences.getString("token") == null){
      setState(() {
        isLogin = false;
      });
    }else{
      setState(() {
        token = sharedPreferences.getString("token");
        isLogin = true;
      });
    }
  }
    
  @override
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
          token = jsonResponse['data']['accessToken'];
          isLogin = true;
        });
        sharedPreferences.setString("token", jsonResponse['data']['accessToken']);
        //fetch User data
        _user = parseUser(response.body);
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
                  //Logic Sai!!!
                  // Text(_user!.email.toString()),
                  // Text(token??"not token"),
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
                        primary: const Color.fromARGB(100, 22, 44, 33),
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
                        // token = "";
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
        height: (MediaQuery.of(context).size.height - 56)*0.6,
        width: MediaQuery.of(context).size.width*0.6,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () { 
                        signIn(phoneController.text, passwordController.text);
                    },
                  child: const Text("Login", style: TextStyle(color: Colors.white70),),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                  onPressed: () { 
                        _showAlertDialogRegister(context);
                    },
                  child: const Text("Register", style: TextStyle(color: Colors.white70),),),
              ),
            ),
          ],
          
        ),
      ),
    );
  }
}

//Dialog Register
Future<void> _showAlertDialogRegister(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog( // <-- SEE HERE
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text("Register"),
              TextField(
                
              ),
              TextField(),
              TextField(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: const Text('Register')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: const Text('Cancel')),
              )
            ],
          ),
        ),
      );
    },
  );
}

User parseUser(String body) {
  final Map<String, dynamic> jsonMap = jsonDecode(body);
  User user = User.fromJson(jsonMap["data"]["user"]);
  return user;
}

 
 