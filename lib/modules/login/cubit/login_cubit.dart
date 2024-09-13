import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:formz/formz.dart';

import '../../../config/colors.dart';
import '../../../models/login_model.dart';
import '../../../network/repositories/authentication.dart';
import 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final _storage = const FlutterSecureStorage();
  LogInCubit() : super(const LogInState());

  void emailChanged(String emailvalue) {
    final email = Email.dirty(emailvalue);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String passwordValue) {
    final password = Password.dirty(passwordValue);
    emit(state.copyWith(
        email: state.email,
        password: password,
        status: Formz.validate([state.email, password])));
  }

  Future<dynamic> submitLoginForm(BuildContext context) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    }
    try {
      Map<String, Object> jsonData = {
        "formData": jsonEncode(
            {'email': state.email.value, 'password': state.password.value})
      };
      final result = await AuthenticationRepo().submitLoginForm(jsonData);

      if (result != null && result.containsKey('login_subcription')) {
        if (result['login_subcription'] == 'Expired') {
          emit(
            state.copyWith(
                errorMessage: "Subscription Ended",
                status: FormzStatus.submissionFailure),
          );

          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Subscription Ended',
                  style:
                      TextStyle(color: blackColor, fontWeight: FontWeight.w600),
                ),
                content:
                    const Text('Unable to login,Your subscription has ended.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: blueColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              );
            },
          );
        }
      } else if (result != null && result.containsKey('token')) {
        await _storage.write(key: 'token', value: result['token']);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(
          state.copyWith(
              errorMessage: "Login failed...",
              status: FormzStatus.submissionFailure),
        );
      }
    } catch (e, _) {
      emit(
        state.copyWith(
            errorMessage: "Login failed...",
            status: FormzStatus.submissionFailure),
      );
      print(e);
      print(_);
    }
  }
}
