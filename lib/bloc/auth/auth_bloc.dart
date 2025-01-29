import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_assetment/utils/api_utils/api_status.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final success = await authRepository.sendOtp(event.mobile);
        if (success.apiStatus == ApiStatus.REQUEST_SUCCESS) {
          emit(OtpSent(success.data['sessionId'])); // Pass the sessionId here
        } else {
          emit(LoginError("Something went wrong"));
        }
      } catch (e) {
        emit(AuthError("An error occurred: ${e.toString()}"));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final isLoggedIn = await authRepository.verifyOtp(
          event.mobile,
          event.sessionId,
          event.otp,
        );
        if (isLoggedIn.apiStatus == ApiStatus.REQUEST_SUCCESS) {
          emit(LoginSuccess());
        } else {
          emit(AuthError("Invalid OTP."));
        } // Add a new state for OTP error
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
