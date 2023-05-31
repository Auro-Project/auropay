import 'package:flutter/material.dart';
import 'SuccessAccountScreen.dart';

class ConfirmActivationCode extends StatelessWidget {
  const ConfirmActivationCode({Key? key, required String phoneNumber, required String countryCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(70.0),
                  child: Text(
                    'Enter Activation Code',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SF-Pro-Display',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                    (index) => Container(
                  width: 64,
                  height: 64,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // Handle code input
                      // You can store the entered code in a list or any other data structure as per your requirements
                      // For example, if you want to store it in a list, you can define a list and update it with the entered values
                      // Here's an example implementation:
                      // Define a list to store the entered code
                      List<String> enteredCode = List.filled(4, ''); // Initialize the list with empty strings
                      enteredCode[index] = value; // Update the entered value at the corresponding index
                      // You can then use this `enteredCode` list as per your requirements
                    },
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      border: InputBorder.none,
                      hintText: 'X', // Display a placeholder value or any other visual indicator
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white38,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Column(
              children: [
                Text(
                  'A code has been sent to your phone',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF-Pro-Display',
                    fontWeight: FontWeight.w500,
                    color: Colors.white38,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Request code again',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF-Pro-Display',
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurpleAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 200),
            Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color(0xFF9CA2E8), Color(0xFF7CABEC)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SuccessAccountScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
