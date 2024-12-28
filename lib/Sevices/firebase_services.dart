import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../Ambulance/Authentication/Models/ambulance.dart';
import '../Ambulance/Authentication/Models/driver.dart';

class FirebaseService {
  static Future<String> pickAndUploadPhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) throw "No image selected";

    final file = File(pickedImage.path);
    final storageRef = FirebaseStorage.instance.ref().child('ambulance_photos/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = await storageRef.putFile(file);

    return await uploadTask.ref.getDownloadURL();
  }

  static Future<void> saveAmbulanceDetails(Ambulance ambulance) async {
    try {
      await FirebaseFirestore.instance.collection('ambulances').add({
        'agency': ambulance.agency,
        'vehicleNumber': ambulance.vehicleNumber,
        'vehicleModel': ambulance.vehicleModel,
        'ownerName': ambulance.ownerName,
        'vehicleColor': ambulance.vehicleColor,
        'ownerNumber': ambulance.ownerNumber,
        'rcNumber': ambulance.rcNumber,
        'photo': ambulance.photo,
      });
    } catch (e) {
      print('Error saving ambulance details: $e');
      rethrow;
    }
  }

    static Future<void> saveDriverDetails(Driver driver) async {
    try {
      await FirebaseFirestore.instance.collection('drivers').add(driver.toJson());
    } catch (e) {
      print('Error saving driver details: $e');
      rethrow;
    }
  }
}
