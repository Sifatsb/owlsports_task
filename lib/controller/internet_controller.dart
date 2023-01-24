import 'dart:io';
import 'package:get/get.dart';

class InternetController extends GetxController{
  var internet = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    internetConnection();
  }

  Future internetConnection() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet.value = true;
      }
    } on SocketException catch (_) {
      internet.value = false;
    }
  }
}