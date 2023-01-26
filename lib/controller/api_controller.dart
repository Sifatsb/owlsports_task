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
Future getLoadInfo() async {

  var response = await http.get(Uri.parse("https://www.jsonkeeper.com/b/XK4L"));
  if (response.statusCode == 200) {

    var data = jsonDecode(response.body);
    return data;

  } else {
    print("Error getting data");
  }


  // var request = http.Request('GET', Uri.parse('https://www.jsonkeeper.com/b/XK4L'));
  // http.StreamedResponse response = await request.send();
  // LoanData loanData = loanDataFromJson(await response.stream.bytesToString()) as LoanData;
  //
  // if (response.statusCode == 200) {
  //   debugPrint(await response.stream.bytesToString());
  //   return loanData.toString();
  //
  // }
  // else {
  //   debugPrint(response.reasonPhrase);
  // }

}


// Future getLoadInfo() async {
//   final url = Uri.parse('https://www.jsonkeeper.com/b/XK4L');
//
//   try {
//     final response = await http.get(url);
//     final map = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       LoanData loanData = LoanData.fromJson(map);
//
//       return loanData;
//
//     } else {
//       print('can not fetch url');
//     }
//   } catch (err) {
//     rethrow;
//   }
// }
