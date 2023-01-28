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

  var textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
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
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            title: const Text('Owl Sports', style: AppStyle.title3,),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
            elevation: 3,
          ),

          body: Column(
            children: [

              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {

                    return
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Hello world', textAlign: TextAlign.right, style: TextStyle(color: AppColors.textColor, fontSize: 16),),
                      );

                  },
                ),
              ),


              Card(
                color: Colors.white54,
                child: Row(
                  children: [

                    AppWidgets().iconButton(context, press: (){

                    }, icon: const Icon(Icons.arrow_forward_ios_outlined, color: AppColors.secondaryColor,)),

                    Expanded(
                      child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: w*0.65,
                                child: AppWidgets().msgInputField(context,
                                    controller: textController,
                                    minLine: 1,
                                    maxLine: 3,
                                    hintText: 'Aa',
                                    icon: AppWidgets().iconButton(context,
                                        press: (){},
                                        icon: const Icon(Icons.emoji_emotions_outlined, color: AppColors.secondaryColor,) )),


                              ),
                            ),
                            Positioned(
                              right: 32,
                              bottom: 1,
                              child: GestureDetector(
                                onTap: (){
                                },
                                child: Container(
                                    height: h*0.05,
                                    width: h*0.05,
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(right: 10, bottom: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: AppColors.secondaryColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(.35),
                                              blurRadius: 2,
                                              spreadRadius: 1.5,
                                              offset: const Offset(0, 2.0))
                                        ]),
                                    child: const Icon(Icons.thumb_up_alt_outlined, color: Colors.white,)
                                ),
                              ),
                            ),
                            Positioned(
                              right: -10,
                              bottom: 1,
                              child: GestureDetector(
                                onTap: (){
                                },
                                child: Container(
                                    height: h*0.05,
                                    width: h*0.05,
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(right: 10, bottom: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: AppColors.secondaryColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(.35),
                                              blurRadius: 2,
                                              spreadRadius: 1.5,
                                              offset: const Offset(0, 2.0))
                                        ]),
                                    child: const Icon(Icons.send, color: Colors.white,)
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),

                  ],
                ),
              ),


            ],
          )

      ),
    );
  }
}
