import 'package:flutter/material.dart';

class AppColors{
  static const primaryColor       = Color(0xFFEC8612);
  static const secondaryColor     = Color(0xFFC9731C);
  static const backgroundColor    = Color(0xFFffffff);
  static const iconColor          = Color(0xFF18181B);
  static var shadowColor          = Colors.grey.shade200;
  static const appBarColor        = Colors.white;
  static const redColor           = Colors.redAccent;
  static const greyColor          = Colors.grey;
  static const textColor          = Colors.white;
  static const grayLight          = Color(0xFF8b97a2);
  static final gradientColor      = [primaryColor, secondaryColor];
}

class AppStyle{
  static const titleText          = TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: AppColors.textColor);
  static const timingText         = TextStyle(color: Colors.white);
  static const appTitle           = 'Owl Sports';
  static const checkOutStyle      = TextStyle(fontWeight: FontWeight.w600, fontSize: 15);
  static const checkOutTextStyle  = TextStyle(fontWeight: FontWeight.w300, fontSize: 16);
  static const title1             = TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: AppColors.textColor);
  static const title3             = TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.textColor);
  static const title3Override     = TextStyle(fontWeight: FontWeight.w200, fontSize: 14, color: AppColors.textColor);
  static final title1Override     = TextStyle(fontWeight: FontWeight.w200, fontSize: 28, color: Colors.white.withOpacity(0.8));
  static const bodyText1          = TextStyle(fontWeight: FontWeight.w200, fontSize: 14, color: AppColors.grayLight);
  static const bodyText1Override  = TextStyle(fontWeight: FontWeight.w200, fontSize: 14, color: AppColors.textColor, letterSpacing: 1);
}

class AppSize{
  static const borderRadiusSize = 8.00;
}