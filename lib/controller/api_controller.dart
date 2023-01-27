// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_controller.dart';
import 'internet_controller.dart';


var internetController    = Get.put(InternetController());
var appController      = Get.put(MapController());

var baseUrl = 'https://www.jsonkeeper.com/b/XK4L';


