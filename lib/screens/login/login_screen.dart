import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/components/validations.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

import 'cubit/login_cubit.dart';

class LoginScreen extends CubitWidget<LoginCubit, LoginState> {
  final GlobalKey<FormState> _formLoginEmail = GlobalKey<FormState>();
  final GlobalKey<FormState> _formLoginPhone = GlobalKey<FormState>();
  Validations _validations = Validations();

  TextEditingController _userName = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();

  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN');

  static provider(BuildContext context, {Map<String, dynamic> agrs}) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(agrs: agrs),
      child: LoginScreen(),
    );
  }

  _submitEmail(BuildContext context) async {
    final FormState form = _formLoginEmail.currentState;
    if (form.validate()) {
      form.save();
      bloc.submitLogin(
          email: _userName.text,
          password: _password.text,
          phoneNumber: _phoneNumber);
    }
  }

  _submitPhone(BuildContext context) async {
    final FormState form = _formLoginPhone.currentState;
    if (form.validate()) {
      form.save();
      print(_phoneNumber);
      bloc.submitLogin(
        phoneNumber: _phoneNumber,
        password: _password.text,
        email: _userName.text,
      );
    }
  }

  Widget _buildToggleLogin(BuildContext context, LoginState state) {
    return ButtonTheme(
      height: 56.0,
      minWidth: MediaQuery.of(context).size.width,
      child: OutlineButton.icon(
        borderSide: BorderSide(color: primaryColor, width: 2),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.transparent,
        icon: Text(''),
        label: Text(
          state.isCheckLoginByPhone ? "login_by_email".tr : "login_by_phone".tr,
          style: button.apply(color: primaryColor),
        ),
        onPressed: bloc.toggleLoginByPhone,
      ),
    );
  }

  Widget _buildFormLogin(BuildContext context, LoginState state) {
    return StatefulBuilder(builder: (context, stateSetter) {
      return state.isCheckLoginByPhone
          ? Form(
              key: _formLoginPhone,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InternationalPhoneNumberInput(
                          errorMessage: 'invalid_phone_number'.tr,
                          selectorConfig: SelectorConfig(
                              selectorType:
                                  PhoneInputSelectorType.BOTTOM_SHEET),
                          onInputChanged: (value) {
                            _phoneNumber = value;
                          },
                          textFieldController: _phone,
                          initialValue: _phoneNumber,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          ignoreBlank: true,
                          inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            hintText: 'phone'.tr,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _password,
                            validator: _validations.validatePassword,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0)),
                                prefixIcon: Icon(Icons.lock, size: 20.0),
                                contentPadding:
                                    EdgeInsets.only(left: 16.0, top: 16.0),
                                hintText: 'password'.tr,
                                hintStyle: body2)),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    _buildOptionLogin(context, state),
                    SizedBox(
                      height: 12,
                    ),
                    // Login button
                    ButtonTheme(
                      height: 56.0,
                      minWidth: MediaQuery.of(context).size.width,
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 0.0,
                        color: primaryColor,
                        icon: Text(''),
                        label: Text(
                          "login".tr,
                          style: button,
                        ),
                        onPressed: () {
                          _submitPhone(context);
                        },
                      ),
                    ),
                  ],
                ),
              ))
          : Form(
              key: _formLoginEmail,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // user name
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userName,
                            validator: _validations.validateEmail,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                prefixIcon: Icon(Icons.person, size: 20.0),
                                contentPadding:
                                    EdgeInsets.only(left: 16.0, top: 16.0),
                                hintText: 'email'.tr,
                                hintStyle: body2)),
                        // password
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _password,
                            validator: _validations.validatePassword,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                prefixIcon: Icon(Icons.lock, size: 20.0),
                                contentPadding:
                                    EdgeInsets.only(left: 16.0, top: 16.0),
                                hintText: 'password'.tr,
                                hintStyle: body2)),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    _buildOptionLogin(context, state),
                    SizedBox(
                      height: 12,
                    ),
                    // Login button
                    ButtonTheme(
                      height: 56.0,
                      minWidth: MediaQuery.of(context).size.width,
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 0.0,
                        color: primaryColor,
                        icon: Text(''),
                        label: Text(
                          "login".tr,
                          style: button,
                        ),
                        onPressed: () {
                          _submitEmail(context);
                        },
                      ),
                    ),
                  ],
                ),
              ));
    });
  }

  Widget _buildOptionLogin(BuildContext context, LoginState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              InkWell(
                onTap: bloc.toggleRememberMe,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  child: state.isCheckSaveAccount
                      ? Icon(
                          Icons.check_box,
                          size: 24.0,
                          color: primaryColor,
                        )
                      : Icon(
                          Icons.check_box_outline_blank,
                          size: 24.0,
                          color: Colors.grey,
                        ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "remember_me".tr,
                style: body2,
              )
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                padding: EdgeInsets.all(0),
                child: Text(
                  "forgot_password".tr,
                  style: textStyleActive,
                ),
                onPressed: () => Navigator.of(context)
                    .pushNamed(AppRoute.forgotPasswordScreen),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.layoutInitialized();
  }

  @override
  void listener(BuildContext context, LoginState state) {
    super.listener(context, state);
    if (state is LoginSuccessState) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoute.tabScreen, (Route<dynamic> route) => false);
    }

    if (state is ShowSavedCredential) {
      final email = state.loginRequest.username ?? '';
      final password = state.loginRequest.password ?? '';
      _userName.text = email;
      _password.text = password;
      _phone.text = state.loginRequest?.mobile ?? '';
      _phoneNumber = PhoneNumber(isoCode: 'VN', phoneNumber: _phone.text);
    }
  }

  @override
  Widget builder(BuildContext context, LoginState state) {
    return Scaffold(
      body: AppProgressHUB(
        inAsyncCall: state.isLoading,
        child: SingleChildScrollView(
            child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 80.0, 24.0, 40.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Images.logo.loadImage(height: 72),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "welcome_back".tr,
                    style: heading1,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "slogan".tr,
                    style: body1.apply(color: greyColorText),
                  ),
                  SizedBox(
                    height: 72,
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 20.0,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: _buildFormLogin(context, state),
                        ),
                        SizedBox(height: 10),
                        // Login by phone
                        _buildToggleLogin(context, state),
                        SizedBox(height: 24),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "dont_have_account".tr,
                                style: textGrey,
                              ),
                              InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(AppRoute.signUpScreen),
                                child: Text(
                                  "sign_up".tr,
                                  style: textStyleActive,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        )),
      ),
    );
  }
}
