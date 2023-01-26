// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:owlsports_task/controller/compound_interest_controller.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/loan_borrower_model.dart';
import 'internet_controller.dart';


var internetController    = Get.put(InternetController());
var interestController    = Get.put(InterestController());

var baseUrl = 'https://www.jsonkeeper.com/b/XK4L';


/// Loan Borrowers Data Get
// Future getLoadInfo() async {
//   var response = await http.get(Uri.parse("https://www.jsonkeeper.com/b/XK4L"));
//   if (response.statusCode == 200) {
//     var data = jsonDecode(response.body);
//     return data;
//   } else {
//     print("Error getting data");
//   }
// }