import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final Function handler;

  AdaptiveTextField(this.text, this.controller, this.handler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            placeholder: 'Amount',
            controller: controller,
            onSubmitted: (_) => handler,
            keyboardType: TextInputType.number,
          )
        : TextField(
            controller: controller,
            onChanged: (value) {
              // amountInput = value;
            },
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => handler,
          );
  }
}
