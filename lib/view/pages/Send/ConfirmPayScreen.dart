import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../services/database.dart';
import '../../../services/payments_service.dart';

class ConfirmPayScreen extends StatefulWidget {
  const ConfirmPayScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmPayScreen> createState() => _ConfirmPayScreenState();
}

class _ConfirmPayScreenState extends State<ConfirmPayScreen> {
  late TextEditingController amountController;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(); // Initialize the controller here
  }

  @override
  void dispose() {
    amountController.dispose(); // Dispose the controller here
    super.dispose();
  }

  //create a widget which is showModalBottomSheet
  void showConfirmPay(BuildContext context, String userId, String storeName, String productName, double amount) {
    amountController.text = amount.toString(); // Pre-fill the amount if you have it, or leave it empty for the user to enter

    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: const Color(0xFF232323),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/confirm.png',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Payment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Tuck Shop",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 18,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: amountController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'SF Pro Display',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //title with information of the user
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //label Paying to in grey, textfield with name of the user
                  const Text(
                    'Store Name',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Tuck Shop",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Product Name',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Book",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Card for Operation',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 18,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(
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
                        const SizedBox(
                          width: 30,
                        ),
                        SvgPicture.asset(
                          'assets/images/icons/Logo.svg',
                          color: Colors.white,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "**** **** **** 1234",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'SF Pro Display',
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
                                fontFamily: 'SF Pro Display',
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
            const SizedBox(
              height: 20,
            ),
            //Elevated button to confirm payment
            Center(
              child: Container(
                width: 360,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF9CA2E8),
                      Color(0xFF7CABEC),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Text(
                    'Pay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.bold,
                    ),
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
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 360,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF9CA2E8),
                Color(0xFF7CABEC),
              ],
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              showConfirmPay(context, '1234567890', 'Tuck Shop', 'Book', 100.0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: const Text(
              'Confirm Payment',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
