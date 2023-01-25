import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

import '../../configure/app_colors.dart';
import '../../configure/app_widgets.dart';
import '../../controller/api_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  DateTime timeBackPressed = DateTime.now();


  @override
  void initState() {
    getLoadData();
    super.initState();
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
                backgroundColor: AppColors.secondaryColor,
                elevation: 3,
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: h*0.4,),
                    const Text('Owl Sports', textAlign: TextAlign.center,)
                  ],
                ),
              )
          ) : Center(child: Container(height: h, color: Colors.white, child: Lottie.asset('assets/images/no_internet.json'))))),
    );
  }
}
