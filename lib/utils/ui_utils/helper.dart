import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_socket_assetment/constant/color_constant.dart';

class Helper {
  ///Function to check internet connectivity in app.
  static Future<bool> isNetworkAvailable() async {
    //Checking for the connectivity
    List<ConnectivityResult> connection =
        await Connectivity().checkConnectivity();

    //If connected to mobile data or wifi
    if (connection.contains(ConnectivityResult.mobile) ||
        connection.contains(ConnectivityResult.wifi) ||
        connection.contains(ConnectivityResult.ethernet)) {
      //Returning result as true
      return true;
    } else {
      //Returning result as false
      return false;
    }
  }

  ///ONLY FOR LOGGING PURPOSE - Function to print the JSON object in logs in proper format.
  ///[data] -> Decoded JSON body
  static printJSONData(var data) {
    final prettyString = const JsonEncoder.withIndent(' ').convert(data);
    log(prettyString);
  }

  // Insert the overlay

  static void showCustomerEditPopup(BuildContext context) async {}
  // Modify the method to accept a widget parameter
  static Future<void> showPopup(
      BuildContext context, Widget popupWidget) async {
    await showGeneralDialog(
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return popupWidget; // Return the passed widget
      },
    );
  }

  static void hideLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void showCustomToast(BuildContext context,
      {required String message, Color color = Colors.black, int duration = 2}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG, // Duration of the toast
      gravity:
          ToastGravity.CENTER, // Position of the toast (top, center, bottom)
      timeInSecForIosWeb: duration, // Duration for iOS and Web
      backgroundColor: color, // Background color of the toast
      textColor: Colors.white, // Text color
      fontSize: 16, // Font size of the toast text
    );
  }

  //Show Loader
  static void showLoaderDialog(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      backgroundColor: whiteColor,
      content: Row(
        children: [
          SizedBox(
              height: 50,
              width: 80,
              child: Center(child: CircularProgressIndicator())),
          Text(
            "pleaseWaitTxt",
          )
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
