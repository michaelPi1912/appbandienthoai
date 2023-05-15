import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../variable.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  ChangePassword() async {
    Map data = {
      "confirmPassword": oldPasswordController.text,
      "newPassword": newPasswordController.text,
      "oldPassword": confirmPasswordController.text
    };
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer " + token!
    };
    var jsonResponse = null;
    var response = await http.put(
        Uri.parse('https://phone-s.herokuapp.com/api/user/profile/changePassword'),
        body: jsonEncode(data),
        headers: headers);
    if (response.statusCode == 200) {
      print("change success");
      Navigator.pop(context);
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: <Widget>[
              const Text("Change Password"),
              const SizedBox(
                  height:
                      16), // Add some spacing between the text and text fields
              TextField(
                obscureText: true,
                controller: oldPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Old Password', // Provide a label for the text field
                  border:
                      OutlineInputBorder(), // Add a border around the text field
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Hide the password input
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      ChangePassword();
                    },
                    child: const Text('Change Password'),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     primary:
                  //         Colors.grey[400], // Use a different background color
                  //   ),
                  //   child: const Text('Cancel'),
                  // ),
                ],
              ),
            ],),
      ),
    );
  }
}