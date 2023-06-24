import 'dart:js';

import 'package:flutter/material.dart';

import '../../Theme/appColors.dart';
import '../../widgets/CustomAppBar.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: myAppBar(context, "Privacy Policy"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            _buildText('This Privacy Policy governs the manner in which AuroPay collects, uses, maintains, and discloses information collected from users of the AuroPay mobile application. This Privacy Policy applies to the app and all services offered by AuroPay.', 16, true),
            _buildText('Information Collection:', 18, true),
            const SizedBox(height: 10),
            _buildText('AuroPay may collect personal and non-personal information from users in various ways, including but not limited to:', 16, false),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText('- Information provided during the account registration process, such as name, email address, phone number, and other relevant details.', 16, false),
                  _buildText('- Information collected when conducting transactions within the app, including recipient information, transaction history, and payment details.', 16, false),
                  _buildText('- Information obtained through the use of the app, such as device information, IP address, and usage statistics.', 16, false),
                ],
              ),
            ),
            _buildText('Information Usage:', 18, true),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText('- To provide and improve app functionality, features, and services.', 16, false),
                  _buildText('- To personalize user experience and display relevant content.', 16, false),
                  _buildText('- To process transactions and facilitate payments as per user instructions.', 16, false),
                  _buildText('- To communicate important updates, notifications, and promotional offers related to AuroPay.', 16, false),
                  _buildText('- To analyze app usage patterns, trends, and performance for internal purposes.', 16, false),
                ],
              ),
            ),
            _buildText('Information Protection:', 18, true),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _buildText('AuroPay implements appropriate security measures to protect user information from unauthorized access, alteration, disclosure, or destruction. These measures include encryption, secure data storage, and strict access controls. However, no data transmission or storage method can guarantee 100% security, and users acknowledge the inherent risks involved.', 16, false),
            ),
            _buildText('Information Sharing:', 18, true),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText('- With trusted third-party service providers who assist in app operations and services, subject to strict confidentiality obligations.', 16, false),
                  _buildText('- In response to a legal obligation, court order, or governmental request.', 16, false),
                  _buildText('- To protect the rights, property, or safety of AuroPay, its users, or others.', 16, false),
                  _buildText('- With user consent or as otherwise specified at the time of information collection.', 16, false),
                ],
              ),
            ),
            _buildText('Third-Party Links:', 18, true),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _buildText('The app may contain links to third-party websites, services, or advertisements that are not controlled or operated by AuroPay. Users may be directed to external websites or services with their privacy policies. AuroPay is not responsible for the privacy practices or content of such third-party entities.', 16, false),
            ),
            _buildText("Children's Privacy:", 18, true),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _buildText('AuroPay does not knowingly collect personal information from individuals under the age of 18. The app and its services are intended for users who are 18 years of age or older. If you are a parent or guardian and believe that your child has provided personal information, please contact AuroPay immediately to request the removal of such information.', 16, false),
            ),
            _buildText('Changes to this Privacy Policy:', 18, true),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _buildText('AuroPay reserves the right to update or modify this Privacy Policy at any time. Users will be notified of any changes through app notifications or other means. It is recommended to review this Privacy Policy periodically for any updates. Continued use of the app signifies your acceptance of the revised Privacy Policy.', 16, false),
            ),
            _buildText('Contact Us:', 18, true),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _buildText('If you have any questions, concerns, or requests regarding this Privacy Policy or the privacy practices of AuroPay, please contact us at hi.aurpay@gmail.com', 16, false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text, double fontSize, bool isBold) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: Theme.of(context as BuildContext).cardColor,
        ),
      ),
    );
  }
}
