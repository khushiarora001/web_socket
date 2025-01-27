
import 'package:flutter/material.dart';

BoxShadow boxShadow = const BoxShadow(
    color: Color.fromRGBO(255, 255, 255, 1),
    blurRadius: 1,
    spreadRadius: 1,
    offset: Offset(0, 1.0));

BoxShadow allSideBoxShadow({Color color = Colors.grey}) => BoxShadow(
      color: color,
      blurRadius: 5,
      offset: const Offset(0, 1),
    );
