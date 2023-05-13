// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_final/network/networkApi.dart';
import 'package:project_final/screen/historyPage.dart';
import 'package:project_final/screen/inforPage.dart';
import 'package:project_final/screen/wishPage.dart';
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
        child: FutureBuilder(
          future: fetchUser(token!),
          builder: (context, snapshot){
            if (snapshot.hasData) {
                    return Column(
                      children:[
                        //Avatar
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data!.img.toString()),
                            radius: 100,
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              alignment: Alignment.centerLeft,
                              primary: Color.fromARGB(100, 22, 44, 33),
                          ),
                          icon: const Icon(Icons.person),
                          onPressed: () {
                          setState(() {
                            Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InforPage()));
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
                              Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const HistoryPage()));
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
                          Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const WishPage()));
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
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              alignment: Alignment.centerLeft,
                              primary: Color.fromARGB(100, 22, 44, 33),
                          ),
                          icon: const Icon(Icons.password),
                          onPressed: () {
                          
                        },label: const Text("Đổi Mật Khẩu"),),
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
                        ]);
                  } else if (snapshot.hasError) {
                    setState(() {
                      isLogin =false;
                      sharedPreferences.clear;
                      sharedPreferences.commit();
                    });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
            
          }
          
        ),
      ),
    );
  }
  //isLogin == false
  Widget LoginForm() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(13, 71, 161, 1),
            Color.fromRGBO(21, 101, 192, 1),
            Color.fromRGBO(25, 118, 210, 1),
            Color.fromRGBO(30, 136, 229, 1),
          ],
        ),
      ),
      child: Center(
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      signIn(phoneController.text, passwordController.text);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      _showAlertDialogRegister(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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


 
 