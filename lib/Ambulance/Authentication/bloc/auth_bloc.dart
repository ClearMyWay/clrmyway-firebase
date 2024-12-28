import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class FormBloc extends Bloc<FormEvent, AuthFormState> {
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FormBloc() : super(const CurrentFormState(FormType.login)) {
    on<InitialiseForm>(_onInitializeForm);
    on<LoginEvent>(_onLoginEvent);
    on<UpdateFormEvent>(_onUpdateFormEvent);
  }

  Future<void> _onInitializeForm(
    InitialiseForm event,
    Emitter<AuthFormState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    // Try to get the form state from local cache (SharedPreferences)
    final formState = prefs.getString('formState') ?? 'login';  // Default to 'login' if not found

    // Map the form state to the corresponding FormType
    FormType formType;
    switch (formState) {
      case 'signup':
        formType = FormType.signup;
        break;
      case 'otp':
        formType = FormType.otp;
        break;
      case 'driver':
        formType = FormType.driver;
        break;
      case 'vehicle':
        formType = FormType.vehicle;
        break;
      case 'pass':
        formType = FormType.pass;
        break;
      default:
        formType = FormType.login;  // Default form type
    }

    // Emit the current form state based on the saved value
    emit(CurrentFormState(formType));
  }

  // Save the form state
  Future<void> saveFormState(FormType formType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('formState', formType.toString().split('.').last);  // Save the form state as a string
  }

  // Handle login event
  void _onLoginEvent(LoginEvent event, Emitter<AuthFormState> emit) {
    final vehicleNumber = event.vehicleNumber;
    final password = event.password;

    // Here, you would validate the login credentials (e.g., Firebase authentication)
    if (vehicleNumber == "valid_vehicle" && password == "valid_password") {
      // Simulating a successful login and moving to OTP form
      emit(CurrentFormState(FormType.otp));  // Move to OTP form after successful login
    } else {
      // Handle login failure, show error message or retry logic
      print('Invalid vehicle number or password');
    }
  }

  // Handle form update event (e.g., switching to signup form)
  void _onUpdateFormEvent(UpdateFormEvent event, Emitter<AuthFormState> emit) {
    emit(CurrentFormState(event.formType));  // Emit new form state
  }
}
