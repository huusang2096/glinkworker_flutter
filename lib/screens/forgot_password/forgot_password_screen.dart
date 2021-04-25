import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/components/custom_default_button.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:simplest/simplest.dart';

class ForgotPasswordScreen
    extends CubitWidget<ForgotPasswordCubit, ForgotPasswordState> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN', dialCode: "+84");

  static provider() {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: ForgotPasswordScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget builder(BuildContext context, ForgotPasswordState state) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Theme(
                  data: Theme.of(context).copyWith(primaryColor: Colors.grey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderReset(),
                      _buildFormReset(context),
                      SizedBox(
                        height: 20,
                      ),
                      state.isLoading
                          ? Center(
                              child: SpinKitCircle(
                                color: primaryColor,
                              ),
                            )
                          : CustomDefaultButton(
                              text: "reset_password".tr,
                              press: () {
                                return bloc.submitReset(
                                  phoneNumber: _phoneNumber,
                                  password: _passwordController.text,
                                  confirmPassword:
                                      _confirmPasswordController.text,
                                );
                              },
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "already_have_an_account".tr,
                              style: body2,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppRoute.loginScreen, (route) => false);
                              },
                              child: Text(
                                "login_here".tr,
                                style: textStyleActive,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void listener(BuildContext context, ForgotPasswordState state) {
    super.listener(context, state);

    if (state is ForgotPasswordSuccessState) {
      navigator.pushNamedAndRemoveUntil(AppRoute.loginScreen, (route) => false);
    }
  }

  @override
  dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    return super.dispose();
  }

  Widget _buildFormReset(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            child: InternationalPhoneNumberInput(
              errorMessage: 'invalid_phone_number'.tr,
              selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
              onInputChanged: (value) {
                _phoneNumber = value;
              },
              onInputValidated: (isValidate) {},
              initialValue: _phoneNumber,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              searchBoxDecoration: InputDecoration(
                hintText: '',
              ),
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: 'phone'.tr,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: bloc.state.isPasswordObsecure,
          controller: _confirmPasswordController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: 'enter_new_pass'.tr,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: bloc.touchShowPassword,
              child: Icon(bloc.state.isPasswordObsecure
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              gapPadding: 10.0,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: bloc.state.isConfirmObsecure,
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "confirm_new_pass".tr,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: bloc.touchShowPasswordAgain,
              child: Icon(bloc.state.isConfirmObsecure
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              gapPadding: 10.0,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderReset() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Images.logo.loadImage(height: 72),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
          ),
        ),
        Text(
          "reset_password".tr,
          style: heading1,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
          ),
        ),
        Text(
          "slogan".tr,
          maxLines: 2,
          style: textGrey,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
          ),
        ),
      ],
    );
  }
}
