import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'otp.dart';
import 'AmbulanceForm.dart';

class AmbulanceLogin extends StatefulWidget {
  @override
  _AmbulanceLoginState createState() => _AmbulanceLoginState();
}

class _AmbulanceLoginState extends State<AmbulanceLogin> {
  final TextEditingController _vehicleNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final vehicleNumber = _vehicleNumberController.text.trim();
    final password = _passwordController.text.trim();

    if (vehicleNumber.isEmpty || password.isEmpty) {
      _showError('Please fill in all fields.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Authenticate user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: '$vehicleNumber@ambulance.com', // Use vehicle number as email
        password: password,
      );

      // Fetch owner's phone number from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('ambulances')
          .where('vehicleNumber', isEqualTo: vehicleNumber)
          .limit(1)
          .get()
          .then((value) => value.docs.first);

      if (snapshot.exists) {
        final ownerNumber = snapshot.get('ownerNumber');

        // Navigate to OTP verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(phoneNumber: ownerNumber.toString()),
          ),
        );
      } else {
        _showError('No ambulance found with this vehicle number.');
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Login failed. Please try again.');
    } catch (e) {
      _showError('An error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 400,
                  height: 200,
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Vehicle Number Input
                      _buildTextField(
                        controller: _vehicleNumberController,
                        label: 'Vehicle Number',
                        hint: 'Enter your vehicle number',
                        prefixIcon: Icon(Icons.directions_car),
                      ),
                      SizedBox(height: 20),

                      // Password Input
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                        obscureText: true,
                      ),
                      SizedBox(height: 10),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      ),

                      // Login Button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF008F4C),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Signup Link
                      GestureDetector(
                        onTap: () {
                          // Navigate to Add Vehicle screen and replace the current screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => VehicleForm()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an Account? ",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'SignUp',
                                style: TextStyle(
                                  color: Color(0xFF008F4C),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required Icon prefixIcon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
