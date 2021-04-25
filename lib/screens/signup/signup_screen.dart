import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/Components/validations.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/components/custom_default_button.dart';
import 'package:flutter_map_booking/model/register_request.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/services/widgets/app_bar_widget.dart';
import 'package:flutter_map_booking/screens/signup/cubit/sign_up_cubit.dart';
import 'package:flutter_map_booking/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

class SignupScreen extends CubitWidget<SignUpCubit, SignUpState> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  // String phone;

  bool autoValidate = false;
  Validations validations = new Validations();
  RegisterRequest _registerRequest;
  // String _region;
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN');

  static provider() {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: SignupScreen(),
    );
  }

  _initUI(BuildContext context) {
    _registerRequest = RegisterRequest();
  }

  void submit(BuildContext context, SignUpState state) async {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true;
    } else {
      form.save();
      bloc.loginOrRegister(_phoneNumber, _registerRequest);
    }
  }

  Widget _buildOptionLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  bloc.touchShowCheckboxSaveAccount();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: bloc.state.isCheckSaveAccount
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
                width: 4.0,
              ),
              Text(
                "remember_me".tr,
                style: body2,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () => Navigator.of(context)
                    .pushNamed(AppRoute.forgotPasswordScreen),
                child: Text(
                  "forgot_password".tr,
                  style: textStyleActive,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      child: AppbarWidget(
        text: "sign_up".tr,
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  Widget _buildFormSignUp(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: validations.validateEmail,
            onSaved: (value) {
              _registerRequest.email = value;
            },
            decoration: InputDecoration(
              hintText: "email_address".tr,
              prefixIcon: Icon(Icons.email),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: validations.validateName,
                  onSaved: (value) {
                    _registerRequest.firstName = value;
                  },
                  decoration: InputDecoration(
                    hintText: "first_name".tr,
                    prefixIcon: Icon(Icons.perm_identity),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      gapPadding: 10.0,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 6.0,
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: validations.validateName,
                  onSaved: (value) {
                    _registerRequest.lastName = value;
                  },
                  decoration: InputDecoration(
                    hintText: "last_name".tr,
                    prefixIcon: Icon(Icons.perm_identity),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      gapPadding: 10.0,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: InternationalPhoneNumberInput(
              errorMessage: 'invalid_phone_number'.tr,
              searchBoxDecoration: InputDecoration(
                hintText: '',
              ),
              selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
              onInputChanged: (value) {
                _phoneNumber = value;
              },
              onInputValidated: (isValidate) {},
              initialValue: _phoneNumber,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: 'phone'.tr,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            key: _passwordFieldKey,
            validator: validations.validatePassword,
            keyboardType: TextInputType.text,
            onSaved: (value) {
              _registerRequest.password = value;
            },
            obscureText: context.bloc<SignUpCubit>().state.isPasswordObsecure,
            decoration: InputDecoration(
              hintText: 'enter_your_pass'.tr,
              prefixIcon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () {
                  context.bloc<SignUpCubit>().touchShowPassword();
                },
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
            onSaved: (value) {
              _registerRequest.passwordConfirmation = value;
            },
            obscureText: context.bloc<SignUpCubit>().state.isConfirmObsecure,
            validator: (value) {
              if (value != _passwordFieldKey.currentState.value) {
                return "pass_do_not_match".tr;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "confirm_pass".tr,
              prefixIcon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () {
                  context.bloc<SignUpCubit>().touchShowPasswordAgain();
                },
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
      ),
    );
  }

  Widget _buildHeaderSignUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Images.logo.loadImage(height: 72),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
          ),
        ),
        Text(
          "create_account".tr,
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

  @override
  void afterFirstLayout(BuildContext context) {
    _initUI(context);
  }

  @override
  Widget builder(BuildContext context, SignUpState state) {
    return Scaffold(
      body: AppProgressHUB(
        inAsyncCall: state.isLoading,
        child: SafeArea(
          child: _buildBody(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SignUpState state) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: StatefulBuilder(builder: (_, setter) {
        return SizedBox(
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
                      _buildHeaderSignUp(),
                      _buildFormSignUp(context),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                      ),
                      _buildOptionLogin(context),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                      ),
                      state.isLoading
                          ? Center(
                              child: SpinKitCircle(
                                color: primaryColor,
                              ),
                            )
                          : CustomDefaultButton(
                              text: "sign_up".tr,
                              press: () {
                                submit(context, state);
                              },
                            ),
                      SizedBox(
                        height: 25,
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
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void listener(BuildContext context, SignUpState state) {
    super.listener(context, state);
    if (state is SignUpSuccessState) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoute.loginScreen, (route) => false);
    }
  }
}
