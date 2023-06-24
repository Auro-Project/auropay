import 'package:auropay/view/Theme/appColors.dart';
import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:auropay/view/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Theme/theme_provider.dart';

class DesignCardScreen extends StatefulWidget {
  @override
  _DesignCardScreenState createState() => _DesignCardScreenState();
}

class _DesignCardScreenState extends State<DesignCardScreen> {
  Color selectedColor = Colors.blue; // Default selected color
  Color? savedColor; // Variable to store the saved color

  void changeCardColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void saveCardColor() {
    setState(() {
      savedColor = selectedColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
   
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
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFA4AAEE), Color(0xFF8FB4EC)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
                              'Auropay',
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
              'Select Color:',
              style: TextStyle(color: Theme.of(context).cardColor, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ColorOption(
                  color: Colors.blue,
                  isSelected: selectedColor == Colors.blue,
                  onColorSelected: changeCardColor,
                ),
                ColorOption(
                  color: Colors.red,
                  isSelected: selectedColor == Colors.red,
                  onColorSelected: changeCardColor,
                ),
                ColorOption(
                  color: Colors.green,
                  isSelected: selectedColor == Colors.green,
                  onColorSelected: changeCardColor,
                ),
                ColorOption(
                  color: Colors.yellow,
                  isSelected: selectedColor == Colors.yellow,
                  onColorSelected: changeCardColor,
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
                    gradient(context), 'Save', saveCardColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final Function(Color) onColorSelected;

  const ColorOption({
    required this.color,
    required this.isSelected,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onColorSelected(color),
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
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
