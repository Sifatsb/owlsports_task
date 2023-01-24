// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:owlsports_task/configure/app_colors.dart';

class AppWidgets {

  ///for button
  button(BuildContext context, {text, press, height, width, top, left, right, bottom, color, radius, style}){
    return Center(
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(top: top ?? 0, left: left ?? 0, right: right ?? 0, bottom: bottom ?? 0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 5)),
                primary: color ?? const Color(0xff0ce0ff)
            ),
            onPressed: press,
            child: Text(text,
              style: style ?? AppStyle.title1,
            )
        ),
      ),
    );
  }

  ///for input field
  inputField(BuildContext context, {controller, hintText, keyboardType, icon, autofillHints, obscureText, suffixIcon, readOnly, maxLine}){
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15, left: 25, right: 25),
      child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 1),
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSize.borderRadiusSize),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(1, 1),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.transparent,
                  offset: Offset(-1, -1),
                  blurRadius: 10,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 10, bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.35),
                                blurRadius: 2,
                                spreadRadius: 1.5,
                                offset: const Offset(0, 2.0))
                          ]),
                      child: icon
                  ),

                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: keyboardType,
                      obscureText: obscureText ?? false,
                      autofillHints: [autofillHints],
                      readOnly: readOnly ?? false,
                      textInputAction: TextInputAction.done,
                      maxLines: maxLine ?? 1,
                      style: const TextStyle(fontSize: 17, letterSpacing: 1),
                      decoration: InputDecoration(
                          hintText: hintText,
                          isCollapsed: true,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: suffixIcon,
                          contentPadding: const EdgeInsets.only(top: 8, bottom: 18, left: 10)),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  ///for snack bar
  successSnackBar(BuildContext context, String exp){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.secondaryColor,
        content: Text(
          exp,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  ///for wrong snack bar
  wrongSnackBar(BuildContext context, String exp){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.redColor,
        content: Text(
          exp,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal
          ),
        ),
      ),
    );
  }

  ///show loader dialog
  showLoaderDialog(BuildContext context) {
    AlertDialog alert=AlertDialog(
      backgroundColor: Colors.transparent,
      content:  Center(child: Lottie.asset('assets/images/circular_progress.json',height: 60)),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  ///for exit alert dialog
  exitAlertDialog(BuildContext context) async {
    bool exitApp = await showCupertinoDialog(
        context: context,
        builder: (context){
          return CupertinoAlertDialog(
            title: const Text('Confirmation'),
            content: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Are you sure want to exit from '),
                  TextSpan(
                    text: 'Owl Sports?',
                    style: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: ()=> Navigator.of(context).pop(false),
                  child: const Text('NO',style: TextStyle(color: AppColors.secondaryColor),)
              ),
              TextButton(
                  onPressed: ()=>SystemNavigator.pop(),
                  child: const Text('EXIT',style: TextStyle(color: AppColors.redColor),)
              ),
            ],
          );
        }
    );
    return exitApp;
  }

  ///No More Trainings are Available
  noMoreTrainings(hasMore){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: hasMore ? const CircularProgressIndicator() : const Text('No More Trainings are Available'),
      ),
    );
  }
}