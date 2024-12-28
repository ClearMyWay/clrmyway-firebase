import 'package:flutter/material.dart';
import 'SignUp.dart';
import '../Models/driver.dart';
import '../../../Sevices/firebase_services.dart';

class AddDriverDetails extends StatefulWidget {
  @override
  _AddDriverDetailsState createState() => _AddDriverDetailsState();
}

class _AddDriverDetailsState extends State<AddDriverDetails> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licenseController = TextEditingController();
  final _dobController = TextEditingController();
  String _gender = '';
  String _licensePhotoUrl = '';
  bool _isUploadingPhoto = false;

  Future<void> _pickAndUploadPhoto() async {
    try {
      setState(() {
        _isUploadingPhoto = true;
      });

      final photoUrl = await FirebaseService.pickAndUploadPhoto();
      setState(() {
        _licensePhotoUrl = photoUrl;
        _isUploadingPhoto = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Photo uploaded successfully')),
      );
    } catch (e) {
      setState(() {
        _isUploadingPhoto = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading photo: $e')),
      );
    }
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      if (_licensePhotoUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please upload a license photo")),
        );
        return;
      }

      final driver = Driver(
        driverName: _nameController.text,
        gender: _gender,
        dob: _dobController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        licenseNumber: _licenseController.text,
        photo: _licensePhotoUrl,
      );

      await FirebaseService.saveDriverDetails(driver);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Driver details saved successfully!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DriverSignUp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Driver Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(_nameController, 'Driver Name', 'Enter driver name'),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                        items: [
                          DropdownMenuItem(value: '', child: Text('Gender')),
                          DropdownMenuItem(value: 'male', child: Text('Male')),
                          DropdownMenuItem(value: 'female', child: Text('Female')),
                          DropdownMenuItem(value: 'other', child: Text('Other')),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(_dobController, 'DOB', 'DD/MM/YYYY'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildTextField(_emailController, 'Email', 'Enter your Email'),
                SizedBox(height: 16),
                _buildTextField(_phoneController, 'Phone Number', 'Enter 10 digit phone number'),
                SizedBox(height: 16),
                _buildTextField(_licenseController, 'License Number', 'Enter license number'),
                SizedBox(height: 16),
                Text('Add Driving License Photo', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Center(
                  child: GestureDetector(
                    onTap: _isUploadingPhoto ? null : _pickAndUploadPhoto,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: _isUploadingPhoto
                          ? Center(child: CircularProgressIndicator())
                          : (_licensePhotoUrl.isEmpty
                              ? Icon(Icons.camera_alt, color: Colors.grey, size: 50)
                              : Image.network(_licensePhotoUrl, fit: BoxFit.cover)),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveForm,
                  child: Center(child: Text('Submit')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
