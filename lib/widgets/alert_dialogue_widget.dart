import 'package:flutter/material.dart';

class AlertDailogueWidget extends StatelessWidget {
  final String contentText;
  final Function confirmFunction;
  final Function declineFunction;

  AlertDailogueWidget({
    this.contentText,
    this.confirmFunction,
    this.declineFunction,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        contentText,
      ),
      actions: [
        TextButton(
          onPressed: declineFunction,
          child: Text('No'),
        ),
        TextButton(
          onPressed: confirmFunction,
          child: Text('Yes'),
        )
      ],
    );
  }
}
