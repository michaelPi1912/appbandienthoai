// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    bool isLogin = false;


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
                    setState(() {
                      isLogin = false;
                    });
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
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
                  setState(() { 
                    isLogin = true;
                  });
                },
              child: const Text("Login", style: TextStyle(color: Colors.white70),),),
          ],
          
        ),
      ),
    );
  }
}

 
 