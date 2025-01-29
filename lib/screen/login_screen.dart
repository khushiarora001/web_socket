import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_assetment/bloc/auth/auth_bloc.dart';
import 'package:web_socket_assetment/bloc/auth/auth_event.dart';
import 'package:web_socket_assetment/bloc/auth/auth_state.dart';
import 'package:web_socket_assetment/constant/constant.dart';
import 'package:web_socket_assetment/constant/route_constant.dart';
import 'package:web_socket_assetment/utils/ui_utils/helper.dart';

import '../utils/ui_utils/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginError) {
            Helper.hideLoader(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            if (state is AuthLoading) {
              Helper.showLoaderDialog(context);
            }
            // Retain OTP field if it was already sent
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          } else if (state is OtpSent) {
            Helper.hideLoader(context);
            // Show Toast on OTP Sent
            Fluttertoast.showToast(
              msg: "OTP sent successfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else if (state is LoginSuccess) {
            Helper.hideLoader(context);
            context.go(RouteConstant.eventsRoute);
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppConstants.loginTitle,
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Phone Number Input Field
                  if (context.watch<AuthBloc>().state is! OtpSent)
                    CustomTextField(
                      controller: phoneController,
                      labelText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      hintText: AppConstants.phoneNumberHint,
                    ),
                  SizedBox(height: 20),

                  // OTP Input Field (only visible when OTP is sent)
                  if (context.watch<AuthBloc>().state is OtpSent)
                    CustomTextField(
                      controller: otpController,
                      labelText: "Enter OTP",
                      keyboardType: TextInputType.number,
                      hintText: AppConstants.otpHint,
                    ),
                  SizedBox(height: 20),

                  // Button or Loading State
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (state is OtpSent) {
                            if (otpController.text.isEmpty ||
                                otpController.text.length != 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppConstants.invalidOtpError),
                                ),
                              );
                              return;
                            }
                            Helper.showLoaderDialog(context);
                            context.read<AuthBloc>().add(
                                  VerifyOtpEvent(
                                    phoneController.text,
                                    state.sessionId,
                                    otpController.text,
                                  ),
                                );
                          } else {
                            if (phoneController.text.isEmpty ||
                                phoneController.text.length != 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppConstants.invalidPhoneError),
                                ),
                              );
                              return;
                            }
                            Helper.showLoaderDialog(context);
                            context.read<AuthBloc>().add(
                                  SendOtpEvent(phoneController.text),
                                );
                          }
                        },
                        child: Text(
                          state is OtpSent
                              ? AppConstants.verifyOtpButton
                              : AppConstants.sendOtpButton,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  // Footer Text
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppConstants.termsAndConditions,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
