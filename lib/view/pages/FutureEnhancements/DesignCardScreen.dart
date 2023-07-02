
import '../../../view/widgets/AppButtons.dart';
import '../../../view/widgets/Constants.dart';
import '../../../view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';

class DesignCardScreen extends StatefulWidget {
  const DesignCardScreen({super.key});

  @override
  _DesignCardScreenState createState() => _DesignCardScreenState();
}

class _DesignCardScreenState extends State<DesignCardScreen> {
  Gradient selectedGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.blue.shade100, Colors.blue.shade800],
  ); // Default selected gradient
  Gradient? savedGradient; // Variable to store the saved gradient

  void changeCardGradient(Gradient gradient) {
    setState(() {
      selectedGradient = gradient;
    });
  }

  void saveCardGradient() {
    setState(() {
      savedGradient = selectedGradient;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Design Card'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200, // Adjust the height of the card
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: selectedGradient,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.credit_card,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Text(
                              'AuroPay',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Balance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Rs 5,000.00',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'John Doe',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Select Gradient:',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                GradientOption(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).hintColor,
                      Theme.of(context).hintColor.withOpacity(0.6),
                    ],
                  ),
                  isSelected: selectedGradient ==
                      LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).hintColor,
                          Theme.of(context).hintColor.withOpacity(0.6),
                        ],
                      ),
                  onGradientSelected: changeCardGradient,
                ),
                GradientOption(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.red.shade200,
                      Colors.red.shade200.withOpacity(0.6),
                    ],
                  ),
                  isSelected: selectedGradient ==
                      LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.red.shade200,
                          Colors.red.shade200.withOpacity(0.6),
                        ],
                      ),
                  onGradientSelected: changeCardGradient,
                ),
                GradientOption(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0XFF98C6EC),
                      const Color(0XFF98C6EC).withOpacity(0.6),
                    ],
                  ),
                  isSelected: selectedGradient ==
                      LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0XFF98C6EC),
                          const Color(0XFF98C6EC).withOpacity(0.6),
                        ],
                      ),
                  onGradientSelected: changeCardGradient,
                ),
                GradientOption(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey,
                      Colors.grey.withOpacity(0.6),
                    ],
                  ),
                  isSelected: selectedGradient ==
                      LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey,
                          Colors.grey.withOpacity(0.6),
                        ],
                      ),
                  onGradientSelected: changeCardGradient,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: appButtonFunc(
                  margin: const EdgeInsets.only(bottom: 20),
                  context,
                  gradient(context),
                  'Save',
                  saveCardGradient,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientOption extends StatelessWidget {
  final Gradient gradient;
  final bool isSelected;
  final Function(Gradient) onGradientSelected;

  const GradientOption({super.key,
    required this.gradient,
    required this.isSelected,
    required this.onGradientSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onGradientSelected(gradient),
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
