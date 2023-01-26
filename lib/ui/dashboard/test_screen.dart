// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Sort the customers list by interest paid
//     customers.sort((a, b) => (calculateInterest(b) - calculateInterest(a)).toInt());
//     return MaterialApp(
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: DataTable(
//             columns: [
//               DataColumn(label: Text("Name")),
//               DataColumn(label: Text("Principal Amount")),
//               DataColumn(label: Text("Interest Paid")),
//             ],
//             rows: [
//               for (var customer in customers)
//                 DataRow(
//                   cells: [
//                     DataCell(Text("${customer['First Name']} ${customer['Last Name']}")),
//                     DataCell(Text("\$${customer['Principal Amount']}")),
//                     DataCell(Text("\$${calculateInterest(customer)}")),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Function to calculate the interest paid
//   double calculateInterest(Map<String, dynamic> customer) {
//     var principal = customer['Principal Amount'];
//     var rate = customer['Annual Interest Rate'] / 100;
//     var tenure = customer['Tenures in Month'] / 12;
//     return principal * rate * tenure;
//   }
// }
//
// // List of customers
// List<Map<String, dynamic>> customers = [
// {
// "First Name": "David",
// "Last Name": "Brros",
// "Annual Interest Rate": 11,
// "Principal Amount": 10000000,
// "Tenures in Month": 37
// },
// {
// "First Name": "Tempa",
// "Last Name": "Tukus",
// "Annual Interest Rate": 4,
// "Principal Amount": 99000000.89,
// "
