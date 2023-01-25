// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/loan_borrower.dart';
import 'internet_controller.dart';


var internetController    = Get.put(InternetController());

var baseUrl = 'https://www.jsonkeeper.com/b/XK4L';


/// Loan Borrowers Data Get
Future getLoadData() async {

  var request = http.Request('GET', Uri.parse('https://www.jsonkeeper.com/b/XK4L'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    debugPrint(await response.stream.bytesToString());
  }
  else {
    debugPrint(response.reasonPhrase);
  }

}
