import 'package:flutter/material.dart';
import 'DriverForm.dart';
import '../Models/ambulance.dart';
import '../../../Sevices/firebase_services.dart';

class VehicleForm extends StatefulWidget {
  @override
  _VehicleFormState createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final _agencyController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _vehicleModelController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _vehicleColorController = TextEditingController();
  final _ownerNumberController = TextEditingController();
  final _rcNumberController = TextEditingController();
  String _photoUrl = ''; // URL after uploading photo
  bool _isUploadingPhoto = false;

  Future<void> _pickAndUploadPhoto() async {
    try {
      setState(() {
        _isUploadingPhoto = true;
      });

      final photoUrl = await FirebaseService.pickAndUploadPhoto();
      setState(() {
        _photoUrl = photoUrl;
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
      if (_photoUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please upload a photo")),
        );
        return;
      }

      final ambulance = Ambulance(
        agency: _agencyController.text,
        vehicleNumber: _vehicleNumberController.text,
        vehicleModel: _vehicleModelController.text,
        ownerName: _ownerNameController.text,
        vehicleColor: _vehicleColorController.text,
        ownerNumber: int.parse(_ownerNumberController.text),
        rcNumber: _rcNumberController.text,
        photo: _photoUrl,
      );

      if (!ambulance.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please check all validations")),
        );
        return;
      }

      await FirebaseService.saveAmbulanceDetails(ambulance);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ambulance details saved successfully!")),
      );
      Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AddDriverDetails()),
                          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_agencyController, 'Agency', 'Enter agency name'),
            _buildTextField(_vehicleNumberController, 'Vehicle No.', 'Enter vehicle number', validator: (value) {
              return Ambulance.validateVehicleNumber(value ?? '') ? null : 'Invalid vehicle number format';
            }),
            _buildTextField(_vehicleModelController, 'Vehicle Model', 'Enter vehicle model'),
            _buildTextField(_ownerNameController, 'Owner Name', 'Enter owner name'),
            _buildTextField(_vehicleColorController, 'Vehicle Colour', 'Enter vehicle colour'),
            _buildTextField(_ownerNumberController, 'Owner Number', 'Enter owner number', keyboardType: TextInputType.number, validator: (value) {
              return Ambulance.validateOwnerNumber(int.tryParse(value ?? '') ?? 0) ? null : 'Owner number must be 10 digits';
            }),
            _buildTextField(_rcNumberController, 'RC Number', 'Enter RC number', validator: (value) {
              return Ambulance.validateRcNumber(value ?? '') ? null : 'Invalid RC number format';
            }),
            SizedBox(height: 16),
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
                      : (_photoUrl.isEmpty
                          ? Icon(Icons.camera_alt, color: Colors.grey, size: 50)
                          : Image.network(_photoUrl, fit: BoxFit.cover)),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveForm,
              child: Center(child: Text('Submit')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
