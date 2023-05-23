import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Delayed function to navigate to the SuccessScreen after 3 seconds


    return Scaffold(
      backgroundColor: const Color(0xFF151316),
      body: Stack(
        children: [
          Image.asset('assets/images/HomePage.png',),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                SizedBox(height: height * 0.1),
                //rectangle contaning terxt trxn completd successfully
                Container(
                  height: height * 0.1,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xFF232323),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const Center(
                    child: Text(
                      "Transaction completed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                //text amount white and bold text
                SizedBox(height: height * 0.05),
                const Center(
                  child: Text(
                    "₹ 5000",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
                //now 4 columns containing from , to , date , remaining balance
                SizedBox(height: height * 0.05),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white54,
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 10),
                              const Text(
                                "From",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                ),
                              ),

                            ],
                          ),
                          const Text(
                            "Savings",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white54,
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 10),
                              const Text(
                                "To",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                ),
                              ),

                            ],
                          ),
                          const Text(
                            "Irin Machahen",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white54,
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 10),
                              const Text(
                                "Date",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "12/12/2021",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white54,
                                child: Icon(
                                  Icons.attach_money,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 10),
                              const Text(
                                "Remaining",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "₹ 5000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),




                SizedBox(height: height * 0.1),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(width * 0.9, height * 0.07),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.1),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
