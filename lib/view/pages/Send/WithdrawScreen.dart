import 'package:auropay/view/Theme/appColors.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
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
      extendBodyBehindAppBar: true,
      appBar: myAppBar(context, 'Withdraw'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,  // Changed background color to give a "disabled" feel.
      body: Stack(
        children: [
          Image.asset(
            "assets/images/shapes/gradHM.png",
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 130.0, 20.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16.0),
                Container(
                  decoration: border(context,
                      colorbg: Colors.white54,
                      borderColor: Colors.transparent,
                      borderRadius: 20),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: '   Amount',
                      filled: false,
                      fillColor: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'You can only withdraw once you finish the course or when leaving the university in any other circumstances.',
                  style: TextStyle(
                    color: Colors.red,  // You can adjust the color as per your preference.
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                appButtonFunc(
                  margin: EdgeInsets.only(bottom: 20.0),
                  context,
                  BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  'Withdraw',
                      () {
                    print('Attempting to withdraw: ${_controller.text}');
                  },
                  isEnabled: false,   // Disabled the button.
                  disabledColor: Colors.grey  // Greyed out the button for a disabled look.
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
