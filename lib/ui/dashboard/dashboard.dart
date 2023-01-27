import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

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
                title: Text('OWL Sports', style: AppStyle.title3,),
                centerTitle: true,
                backgroundColor: AppColors.secondaryColor,
                elevation: 3,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      AppFunctions().nearestTabaqCoffeeShop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: w*0.28),
                      child: Card(
                        elevation: 5,
                        color: Colors.white12,
                        child: Container(
                          height: h * 0.22,
                          width: w * 0.5,
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              border: Border.all(
                                  color: AppColors.primaryColor
                              ),
                              borderRadius: BorderRadius.circular(5)
                          ),

                          child: Column(
                            children: [
                              Image.asset('assets/images/coffee_shop.jpg'),
                              SizedBox(height: h*0.04,),
                              Text('Tabaq Coffee Shop',style: TextStyle(fontSize: h * 0.018, fontWeight: FontWeight.w600, color: Colors.black),textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
          ) : Center(child: Container(height: h, color: Colors.white, child: Lottie.asset('assets/images/no_internet.json'))))),
    );
  }
}
