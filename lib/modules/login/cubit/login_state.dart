import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../models/login_model.dart';

class LogInState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  const LogInState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage = ''});
  @override
  List<Object?> get props => [email, password, status, errorMessage];

  LogInState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return LogInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
