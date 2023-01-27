// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/api_controller.dart';

class AppFunctions {
  List months = ['January', 'February', 'March', 'April', 'May','June','July','August','September','October','November','December'];
  int limit = 4;

  ///Nearest Mosque
  nearestTabaqCoffeeShop() async {
    try {
      launch("https://www.google.com/maps/search/Tabaq Coffee/@${appController.latitude},${appController.longitude},16.4746z");
    } on PlatformException catch(e) {
      launch("https://www.google.com/maps/search/Tabaq Coffee/@${appController.latitude},${appController.longitude},16.4746z");
    } finally {
      launch("https://www.google.com/maps/search/Tabaq Coffee/@${appController.latitude},${appController.longitude},16.4746z");
    }
  }

}