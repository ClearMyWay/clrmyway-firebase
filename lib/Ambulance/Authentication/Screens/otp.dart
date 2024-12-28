import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  OtpScreen({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(  // Wrap the body in a SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo at the top
            Image.asset(
              'assets/images/logo.png',
              height: 200,
              width: 500,
            ),
            const SizedBox(height: 30),

            // Display phone number at the top
            Text(
              'OTP sent to Phone Number: $phoneNumber',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // OTP TextField
            TextField(
              decoration: const InputDecoration(
                hintText: 'OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Verify OTP Button
            ElevatedButton(
              onPressed: () {},
              child: const Text('Verify OTP'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                backgroundColor: Color(0xFF008F4C),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),

            // Resend OTP Button
            ElevatedButton(
              onPressed: () {},
              child: const Text('Resend OTP'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                backgroundColor: Colors.grey,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
