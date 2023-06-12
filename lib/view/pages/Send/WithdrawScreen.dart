import 'package:auropay/view/Theme/appColors.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:auropay/view/widgets/CustomField.dart';
import 'package:flutter/material.dart';

import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';

class WithdrawalScreen extends StatefulWidget {
  @override
  _WithdrawalScreenState createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Withdraw'),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16.0),
            myField(context, 'Amount', isNumber: false, _controller, false),
            SizedBox(height: 16.0),
            Spacer(),
            appButtonFunc(
                margin:EdgeInsets.only(bottom: 20.0),
                context, gradient(context), 'Withdraw', () {
              print('Attempting to withdraw: ${_controller.text}');
            }),
          ],
        ),
      ),
    );
  }
}
