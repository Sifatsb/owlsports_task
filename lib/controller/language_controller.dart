import 'package:get/get.dart';
class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {
        'en_US': {
          'phone'                   : 'Your Phone number*',
          'password'                : 'Your Password*',
          'login'                   : 'Login Now',
        },
        'bn_BN': {
          'phone'                   : 'আপনার মোবাইল নাম্বার*',
          'password'                : 'আপনার পাসওয়ার্ড*',
          'login'                   : 'প্রবেশ করুন',

        }
      };
}