import 'package:equatable/equatable.dart';
import 'auth_state.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseForm extends FormEvent {
  @override
  List<Object?> get props => [];
}

// Event to handle login
class LoginEvent extends FormEvent {
  final String vehicleNumber;
  final String password;

  const LoginEvent({
    required this.vehicleNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [vehicleNumber, password];
}

// Event to update the form type (e.g., switch between login, signup, etc.)
class UpdateFormEvent extends FormEvent {
  final FormType formType;

  const UpdateFormEvent(this.formType);

  @override
  List<Object?> get props => [formType];
}
