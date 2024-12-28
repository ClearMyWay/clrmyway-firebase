import 'package:equatable/equatable.dart';

enum FormType { login, signup, otp, driver, vehicle, pass }
// Base State Class
abstract class AuthFormState extends Equatable {
  const AuthFormState();

  @override
  List<Object?> get props => [];
}

// State to represent a specific form type
class CurrentFormState extends AuthFormState {
  final FormType currentForm;

  const CurrentFormState(this.currentForm);

  @override
  List<Object?> get props => [currentForm];
}
