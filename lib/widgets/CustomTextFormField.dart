import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/widgets/CustumText.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  final String hint;

  final VoidCallback onSave;
  final VoidCallback validator;

  CustomTextFormField({
    required this.text,
    required this.hint,
    required this.onSave,
    required this.validator,
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
            //onSaved: onSave,
            // validator:  validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              fillColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
