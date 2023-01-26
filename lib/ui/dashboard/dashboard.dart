import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:owlsports_task/model/loan_borrower_model.dart';
import 'package:http/http.dart' as http;
import '../../configure/app_colors.dart';
import '../../configure/app_function.dart';
import '../../configure/app_widgets.dart';
import '../../controller/api_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  DateTime timeBackPressed = DateTime.now();
  bool isLoading = false;

  var customerData;
  static const int compoundingFrequency = 12;

  @override
  void initState() {
    isLoading = true;
    _getData();

    super.initState();
  }

  _getData() async {
    var response = await http.get(Uri.parse("https://www.jsonkeeper.com/b/XK4L"));
    if (response.statusCode == 200) {
      setState(() {
        customerData = jsonDecode(response.body);
        customerData.sort((a, b) => (calculateCompoundInterest(b) - calculateCompoundInterest(a)).toInt());
      });
    } else {
      print("Error getting data");
    }
  }




  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{
        final differ = DateTime.now().difference(timeBackPressed);
        final exitWarning = differ >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if(exitWarning){
          AppWidgets().exitAlertDialog(context);
          return false;
        }else{
          return true;
        }
      },
      child: SafeArea(
          child: Obx(() => internetController.internet == true ? Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('OWL Sports'),
                centerTitle: true,
                backgroundColor: AppColors.secondaryColor,
                elevation: 3,
              ),
            body: customerData != null
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text("Name")),
                      DataColumn(label: Text("Principal Amount")),
                      DataColumn(label: Text("Interest Paid")),
                    ],
                    rows: [

                      for (var customer in customerData)
                        DataRow(
                          cells: [
                            DataCell(Text("${customer['First Name']} ${customer['Last Name']}")),
                            DataCell(Text("\$${customer['Principal Amount']}")),
                            DataCell(Text("\$${calculateCompoundInterest(customer)}")),
                          ],
                        ),
                    ],
                  ),
                )
                : const Center(
              child: CircularProgressIndicator(),
            ),
          ) : Center(child: Container(height: h, color: Colors.white, child: Lottie.asset('assets/images/no_internet.json'))))),
    );
  }
}
