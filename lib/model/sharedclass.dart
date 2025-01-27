import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
SharedPref.internal();
static final sharedInst=SharedPref.internal();
factory SharedPref(){
return sharedInst;

}

String sharedInstanceUSer='';
Future<void>sharedisntancefucniton() async {
  final temp = await SharedPreferences.getInstance();
  sharedInstanceUSer = temp.getString('UserVal')!;
}


  static sharedprefset(String username,String email) async {
    final value = await SharedPreferences.getInstance();
    value.setString('UserVal', email);
 log('shared pref value set');
   
  }

  
}