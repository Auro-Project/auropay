import 'package:flutter/material.dart';
import '../../widgets/CustomAppBar.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: myAppBar(context, "Auro FAQ"),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: const [
          SizedBox(height: 90),
          ToggleQuestion(
            question: 'How do I create an AuroPay account?',
            answer:
            'To create an AuroPay account, download the AuroPay app from your app store and follow the on-screen instructions to sign up with your personal information, such as your name, email address, and phone number. You may also need to verify your identity through a verification process.',
          ),
          ToggleQuestion(
            question: 'What payment methods does AuroPay support?',
            answer:
            'AuroPay supports various payment methods, including bank transfers, debit cards, credit cards, and digital wallets such as PayPal or Google Pay. You can link your preferred payment method to your AuroPay account for easy and secure transactions.',
          ),
          ToggleQuestion(
            question: 'How can I add funds to my AuroPay account?',
            answer:
            'To add funds to your AuroPay account, navigate to the "Add Funds" section within the app. Choose your desired funding source, such as a linked bank account or a debit/credit card. Enter the amount you wish to add and follow the prompts to complete the transaction securely.',
          ),
          ToggleQuestion(
            question: 'How do I make a payment using AuroPay?',
            answer:
            'To make a payment with AuroPay, open the app and navigate to the "Send Money" or "Make Payment" section. Enter the recipient\'s details, including their AuroPay username or their linked email/phone number. Specify the amount to send and confirm the payment. AuroPay will securely process the transaction.',
          ),
          ToggleQuestion(
            question: 'Is my personal and financial information secure with AuroPay?',
            answer:
            'Yes, AuroPay takes the security of your personal and financial information seriously. The app implements robust security measures, including encryption, secure authentication, and monitoring systems, to protect your data. Additionally, AuroPay adheres to industry best practices and regulations to ensure the safety of your information.',
          ),
          ToggleQuestion(
            question: 'Can I transfer money internationally with AuroPay?',
            answer:
            'Currently, AuroPay supports domestic money transfers only. International money transfers are not available at this time. You can use AuroPay for transactions within your country or region.',
          ),
          ToggleQuestion(
            question: 'How can I track my transaction history on AuroPay?',
            answer:
            'AuroPay provides a transaction history feature within the app. You can access it by navigating to the "Transaction History" or "My Account" section. This feature displays your past transactions, including sent and received payments, along with details such as dates, amounts, and recipient information.',
          ),
          ToggleQuestion(
            question: 'What should I do if I encounter an issue or have a question related to AuroPay?',
            answer:
            'If you experience any issues or have questions about AuroPay, you can reach out to the AuroPay customer support team. Contact information is available within the app, typically in the "Help" or "Support" section. You can contact support via email, phone, or live chat for prompt assistance.',
          ),
          ToggleQuestion(
            question: 'Can I link multiple bank accounts or payment methods to my AuroPay account?',
            answer:
            'No, at the moment, AuroPay allows you to link and use only one bank account or payment method with your AuroPay account. You can select your preferred payment method during the account setup process or change it later in the app\'s settings.',
          ),
          ToggleQuestion(
            question: 'Are there any fees associated with using AuroPay?',
            answer:
            'AuroPay does not charge any fees for using its basic services, such as account creation, peer-to-peer payments, and checking transaction history. However, please note that certain premium features or additional services may have associated fees. It is recommended to review the AuroPay fee structure for detailed information on any applicable charges.',
          ),
        ],
      ),
    );
  }
}

class ToggleQuestion extends StatefulWidget {
  final String question;
  final String answer;

  const ToggleQuestion({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _ToggleQuestionState createState() => _ToggleQuestionState();
}

class _ToggleQuestionState extends State<ToggleQuestion> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          title: Text(
            widget.question,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          trailing: Icon(
            _expanded ? Icons.expand_less : Icons.expand_more,
            color: Colors.black54,
          ),
        ),
        if (_expanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.answer,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
