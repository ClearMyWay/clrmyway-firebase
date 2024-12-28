class Ambulance {
  final String agency; // Agency name
  final String vehicleNumber; // Vehicle number in specified format
  final String vehicleModel; // Model of the vehicle
  final String ownerName; // Name of the vehicle owner
  final String vehicleColor; // Color of the vehicle
  final int ownerNumber; // 10-digit mobile number of the owner
  final String rcNumber; // RC number in Indian format
  final String photo; // Path or URL of the vehicle's photo

  Ambulance({
    required this.agency,
    required this.vehicleNumber,
    required this.vehicleModel,
    required this.ownerName,
    required this.vehicleColor,
    required this.ownerNumber,
    required this.rcNumber,
    required this.photo
  });

  // Add validation to ensure vehicle number matches the required format
  static bool validateVehicleNumber(String vehicleNumber) {
    final vehicleNumberRegex = RegExp(r'^[A-Z]{2}\d{2}[A-Z]\d{3}$');
    return vehicleNumberRegex.hasMatch(vehicleNumber);
  }

  // Add validation to ensure RC number matches Indian standard format
  static bool validateRcNumber(String rcNumber) {
    final rcNumberRegex = RegExp(r'^[A-Z]{2}\d{2}[A-Z]{2}\d{4}$');
    return rcNumberRegex.hasMatch(rcNumber);
  }

  // Validation for a 10-digit owner number
  static bool validateOwnerNumber(int ownerNumber) {
    return ownerNumber.toString().length == 10;
  }

  // Method to validate all fields
  bool validate() {
    return validateVehicleNumber(vehicleNumber) &&
        validateRcNumber(rcNumber) &&
        validateOwnerNumber(ownerNumber);
  }
}
