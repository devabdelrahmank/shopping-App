//-defult-TextFormFiled--

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defultTextFromFiled({
  bool obscureText = false, // T
  required TextEditingController? controller, // T
  required String? text, // T
  IconData? iconDataPrifix, // left
  IconData? iconDataSuffix, // right
  Color? containerColor, // T
  Function()? onTap, // T
  TextInputType? type, // T
  required String? Function(String?)? valeditor, // T
  String? Function(String?)? onchanged,
  double radius = 12, // T
  double? fontSizelabel, // T
  Function()? onPressedSufexicon, // logic العين
  Color? colorstyle, // T
  double? sizeHieht,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: containerColor,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(25),
        labelText: text,
        labelStyle: TextStyle(
          fontSize: fontSizelabel,
          fontWeight: FontWeight.bold,
          color: colorstyle,
        ),
        prefixIcon: Icon(iconDataPrifix),
        suffixIcon: IconButton(
          onPressed: onPressedSufexicon,
          icon: Icon(iconDataSuffix),
        ),
        border: const OutlineInputBorder(),
      ),
      keyboardType: type,
      obscureText: obscureText,
      onChanged: onchanged,
      controller: controller,
      validator: valeditor,
      onTap: onTap,
    ),
  );
}

Widget defultText({
  required String text,
  required double size,
  required Color color,
}) =>
    Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );

Widget defultButton({
  required String text,
  required Color color,
  required Function()? onPressed,
}) =>
    MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: color,
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );

ToastMessage({
  required ToastStates state,
  required String text,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates {
  // ignore: constant_identifier_names
  SUCCESS,
  // ignore: constant_identifier_names
  ERROR,
  // ignore: constant_identifier_names
  WARNING,
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}
