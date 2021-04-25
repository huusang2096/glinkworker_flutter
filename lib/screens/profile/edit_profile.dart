import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/components/custom_default_button.dart';
import 'package:flutter_map_booking/components/validations.dart';
import 'package:flutter_map_booking/screens/profile/cubit/profile_cubit.dart';
import 'package:flutter_map_booking/screens/services/widgets/app_bar_widget.dart';
import 'package:flutter_map_booking/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

class EditProfile extends CubitWidget<ProfileCubit, ProfileState> {
  final _formKey = GlobalKey<FormState>();
  Validations _validations = Validations();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN');

  static provider() {
    return BlocProvider<ProfileCubit>(
      create: (_) => ProfileCubit(),
      child: EditProfile(),
    );
  }

  _initUI(BuildContext context) {
    bloc.getProfile();
  }

  void _handleUpdate(BuildContext context, ProfileState state) {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      bloc.submitUpdate(
        phoneNumber: _phoneNumber,
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _initUI(context);
  }

  @override
  void listener(BuildContext context, ProfileState state) {
    super.listener(context, state);
    if (state is GetProfileSuccessState) {
      _firstNameController =
          TextEditingController(text: state.profileResponse?.firstName ?? '');
      _lastNameController =
          TextEditingController(text: state.profileResponse?.lastName ?? '');
      _emailController =
          TextEditingController(text: state.profileResponse?.email ?? '');
      _mobileController =
          TextEditingController(text: state.profileResponse?.mobile ?? '');
      _phoneNumber = PhoneNumber(
          phoneNumber: state.profileResponse?.mobile,
          isoCode: 'VN',
          dialCode: '+84');
    }

    // Do not to return immediately
    // if (state is UpdateProfileSuccessState) {
    //   navigator.popAndPushNamed(AppRoute.tabScreen,
    //       arguments: {'profileResponse': state.profileResponse});
    // }
  }

  @override
  Widget builder(BuildContext context, ProfileState state) {
    return AppProgressHUB(
      inAsyncCall: state.inAsyncCall,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          _buildHeaderEditProfile(context, state),
                          SizedBox(
                            height: 32,
                          ),
                          // first name
                          _buildBodyEditProfile(context, state),
                        ],
                      ),
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

  @override
  dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    return super.dispose();
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      child: AppbarWidget(
        text: ("edit_profile").tr,
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  Widget _buildHeaderEditProfile(BuildContext context, ProfileState state) {
    return Center(
      child: Stack(
        children: [
          _avatarWidget(state),
          Positioned(
            right: 0.0,
            bottom: 0.0,
            child: GestureDetector(
              onTap: bloc.onSelectImageFromDevice,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.6,
                  ),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  Icons.edit,
                  size: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyEditProfile(BuildContext context, ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: Text("first_name".tr)),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: _firstNameController,
          validator: _validations.validateName,
          onSaved: (String value) {
            _firstNameController.text = value;
            bloc.updateFirstName(value);
          },
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(child: Text("last_name".tr)),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: _lastNameController,
          validator: _validations.validateName,
          onSaved: (String value) {
            _lastNameController.text = value;
            bloc.updateLastName(value);
          },
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(child: Text("phone".tr)),
        IgnorePointer(
          ignoring: true,
          child: InternationalPhoneNumberInput(
            searchBoxDecoration: InputDecoration(
              hintText: '',
            ),
            errorMessage: 'invalid_phone_number'.tr,
            selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
            onInputChanged: (value) {
              _phoneNumber = value;
              state.profileRequest.countryCode = _phoneNumber.dialCode;
              state.profileRequest.mobile = _phoneNumber.phoneNumber;
            },
            countrySelectorScrollControlled: true,
            textFieldController: _mobileController,
            onInputValidated: (isValidate) {},
            initialValue: _phoneNumber,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            inputDecoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintText: 'phone'.tr,
            ),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(child: Text("email_address".tr)),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          validator: _validations.validateEmail,
          onSaved: (String value) {
            _emailController.text = value;
            bloc.updateEmail(value);
          },
          enabled: false,
        ),
        SizedBox(
          height: 40.0,
        ),
        CustomDefaultButton(
          text: "update".tr,
          press: () {
            _handleUpdate(context, state);
          },
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget _avatarWidget(ProfileState state) {
    final _localImage = state.profileRequest.picture;
    final _avatarUrl = state.profileResponse?.picture ?? '';
    Widget _avatarContent = Image.asset(
      Images.defaultAvatar,
      height: 72.0,
      width: 72.0,
      fit: BoxFit.cover,
    );

    if (_localImage != null) {
      _avatarContent = Image.file(
        _localImage,
        height: 72.0,
        width: 72.0,
        fit: BoxFit.cover,
      );
    } else if (_avatarUrl.isNotEmpty) {
      _avatarContent = CachedNetworkImage(
        imageUrl: BASE_URL_STORAGE + _avatarUrl,
        width: 72.0,
        height: 72.0,
        fit: BoxFit.cover,
      );
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(80.0), child: _avatarContent);
  }
}
