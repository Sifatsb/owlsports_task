// To parse this JSON data, do
//
//     final loanData = loanDataFromJson(jsonString);

import 'dart:convert';

List<LoanData> loanDataFromJson(String str) => List<LoanData>.from(json.decode(str).map((x) => LoanData.fromJson(x)));

String loanDataToJson(List<LoanData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoanData {
  LoanData({
    required this.firstName,
    required this.lastName,
    required this.annualInterestRate,
    required this.principalAmount,
    required this.tenuresInMonth,
  });

  String firstName;
  String lastName;
  String annualInterestRate;
  String principalAmount;
  String tenuresInMonth;

  factory LoanData.fromJson(Map<String, dynamic> json) => LoanData(
    firstName: json["First Name"],
    lastName: json["Last Name"],
    annualInterestRate: json["Annual Interest Rate"],
    principalAmount: json["Principal Amount"],
    tenuresInMonth: json["Tenures in Month"],
  );

  Map<String, dynamic> toJson() => {
    "First Name": firstName,
    "Last Name": lastName,
    "Annual Interest Rate": annualInterestRate,
    "Principal Amount": principalAmount,
    "Tenures in Month": tenuresInMonth,
  };
}
