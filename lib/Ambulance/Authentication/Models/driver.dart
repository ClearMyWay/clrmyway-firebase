class Driver {
  final String driverName; // Name of the driver
  final String gender; // Gender of the driver (Male/Female)
  final String dob; // Date of birth in dd/mm/yyyy format
  final String email; // Email address
  final String phoneNumber; // 10-digit phone number
  final String licenseNumber; // License number in Indian standard format
  final String photo; // Path or URL of the driver's license's photo

  Driver({
    required this.driverName,
    required this.gender,
    required this.dob,
    required this.email,
    required this.phoneNumber,
    required this.licenseNumber,
    required this.photo,
  });

  // Validation for gender (Male or Female)
  static bool validateGender(String gender) {
    return gender == "Male" || gender == "Female";
  }

  // Validation for DOB (dd/mm/yyyy format)
  static bool validateDOB(String dob) {
    final dobRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    return dobRegex.hasMatch(dob);
  }

  // Validation for email
  static bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  // Validation for phone number (10 digits)
  static bool validatePhoneNumber(String phoneNumber) {
    return phoneNumber.toString().length == 10;
  }

  // Validation for license number (Indian standard format)
  static bool validateLicenseNumber(String licenseNumber) {
    final licenseNumberRegex = RegExp(r'^[A-Z]{2}\d{2}[A-Z]{2}\d{4}$');
    return licenseNumberRegex.hasMatch(licenseNumber);
  }

  // Validation for photo (ensures it's not empty)
  static bool validatePhoto(String photo) {
    return photo.isNotEmpty;
  }

  // Method to validate all fields
  bool validate() {
    return validateGender(gender) &&
        validateDOB(dob) &&
        validateEmail(email) &&
        validatePhoneNumber(phoneNumber) &&
        validateLicenseNumber(licenseNumber) &&
        validatePhoto(photo);
  }

    Map<String, dynamic> toJson() {
    return {
      'name': driverName,
      'gender': gender,
      'dob': dob,
      'email': email,
      'phoneNumber': phoneNumber,
      'licenseNumber': licenseNumber,
      'licensePhotoUrl': photo,
    };
  }

  // Factory method to create a Driver object from JSON
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverName: json['name'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      licenseNumber: json['licenseNumber'] ?? '',
      photo: json['licensePhotoUrl'] ?? '',
    );
  }
}

