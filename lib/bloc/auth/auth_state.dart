abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class OtpSent extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

class LoginLoading extends AuthState {}
