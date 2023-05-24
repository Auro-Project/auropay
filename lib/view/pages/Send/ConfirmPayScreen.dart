import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmPayScreen extends StatelessWidget {
  const ConfirmPayScreen({Key? key}) : super(key: key);

  //create a widget which is showModalBottomSheet
  void showConfirmPay(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: Color(0xFF232323),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/confirm.png',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Confirm Payment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "amount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "₹ 5000",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //title with information of the user
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //label Paying to in grey, textfield with name of the user
                  Text(
                    'Paying to',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Zara Larson",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Reference Message',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Book",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Card for Operation',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //create a card with the information of the card, and balance
                  Container(
                    height: 150,
                    width: 360,
                    decoration: BoxDecoration(
                      color: const Color(0xFF909CDD),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        SvgPicture.asset(
                          'assets/images/icons/Logo.svg',
                          color: Colors.white,
                          height: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "**** **** **** 1234",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Balance: ₹ 5000",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Elevated button to confirm payment
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/progress');
                },
                child: const Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(360, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232323),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showConfirmPay(context);
          },
          child: const Text(
            'Confirm Payment',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size(360, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      ),
    );
  }
}
