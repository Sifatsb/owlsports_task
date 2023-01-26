// ignore_for_file: use_build_context_synchronously

import 'dart:math';

class AppFunctions {
  List months = ['January', 'February', 'March', 'April', 'May','June','July','August','September','October','November','December'];
  int limit = 4;
}


double calculateCompoundInterest(Map<String, dynamic> customer) {
  var principal = double.parse(customer['Principal Amount']);
  var rate = double.parse(customer['Annual Interest Rate']) / 100;
  var tenure = double.parse(customer['Tenures in Month']) / 12;
  return principal * pow((1 + rate), tenure);
}