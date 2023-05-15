// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class UpdateAddressPage extends StatefulWidget {
//   const UpdateAddressPage({super.key});

//   @override
//   State<UpdateAddressPage> createState() => _UpdateAddressPageState();
// }

// class _UpdateAddressPageState extends State<UpdateAddressPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context, "aaa"),
//         ),
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 "Update Profile",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               Table(
//                 border: TableBorder.all(color: Colors.grey),
//                 defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                 columnWidths: const {
//                   0: FlexColumnWidth(),
//                   1: FlexColumnWidth(),
//                 },
//                 children: [
//                   _buildTableRow(
//                       'Full Name:',
//                       TextField(
//                         controller: fullNameController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your name',
//                           hintStyle: TextStyle(color: Colors.blue),
//                           border: InputBorder.none,
//                         ),
//                       )),
//                   _buildTableRow(
//                       'Gender:',
//                       DropdownButton(
//                         hint: _dropDownValue == null
//                             ? const Text('Gender', textAlign: TextAlign.center)
//                             : Text(
//                                 _dropDownValue!,
//                                 style: TextStyle(color: Colors.blue),
//                               ),
//                         isExpanded: true,
//                         iconSize: 30.0,
//                         style: const TextStyle(color: Colors.blue),
//                         items: ['Nam', 'Nữ', 'Khác'].map(
//                           (val) {
//                             return DropdownMenuItem<String>(
//                               value: val,
//                               child: Text(val),
//                             );
//                           },
//                         ).toList(),
//                         onChanged: (val) {
//                           setState(() {
//                             _dropDownValue = val!;
//                           });
//                         },
//                       )),
//                   _buildTableRow(
//                       'Country:',
//                       TextField(
//                         controller: countryController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your country',
//                           hintStyle: TextStyle(color: Colors.blue),
//                           border: InputBorder.none,
//                         ),
//                       )),
//                   _buildTableRow(
//                       'Nick Name:',
//                       TextField(
//                         controller: nickNameController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your nick name',
//                           hintStyle: TextStyle(color: Colors.blue),
//                           border: InputBorder.none,
//                         ),
//                       )),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                 },
//                 child: const Text("Update"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// TableRow _buildTableRow(String label, Widget child) {
//     return TableRow(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Text(
//             label,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: child,
//         ),
//       ],
//     );
//     }