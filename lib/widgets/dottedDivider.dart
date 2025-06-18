import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget dottedDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      60,
          (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: Container(
          width: 2,
          height: 2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}