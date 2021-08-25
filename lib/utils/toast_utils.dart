import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showErrorToast(String? msg) {
  if (msg != null)
  Fluttertoast.showToast(
      msg: "$msg !!",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.red.withOpacity(0.5),
      textColor: Colors.white);
}

showSuccessToast(String? msg) {
  if (msg != null)
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.grey[400],
        textColor: Colors.white);
}

Widget progressIndicator() {
  return Container(child: Center(child: Container(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(backgroundColor: Colors.blue,)),),);
}