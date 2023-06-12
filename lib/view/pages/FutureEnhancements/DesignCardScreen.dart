import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Design Card',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200, // Adjust the height of the card
              child: Card(
                elevation: 4,
                color: selectedColor, // Use selected color for the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\$10,000.00',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
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
            SizedBox(height: 16),
            Text(
              'Select Color:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 16),
            Center( // Center the "Save" button
              child: ElevatedButton(
                onPressed: saveCardColor,
                child: Text('Save'),
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
        margin: EdgeInsets.symmetric(horizontal: 4),
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
