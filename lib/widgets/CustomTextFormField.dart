// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/widgets/CustumText.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  final String hint;

  final String Function(String) onSave;
  final String Function(String) validator;

  CustomTextFormField({
    this.text,
    this.hint,
    this.onSave,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: text,
            fontSize: 14,
            color: Colors.grey.shade900,
          ),
          TextFormField(
            onSaved: onSave,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              fillColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
