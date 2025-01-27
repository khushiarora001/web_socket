abstract class AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String mobile;
  SendOtpEvent(this.mobile);
}

class VerifyOtpEvent extends AuthEvent {
  final String mobile;
  final String sessionId;
  final String otp;
  VerifyOtpEvent(this.mobile, this.sessionId, this.otp);
}
