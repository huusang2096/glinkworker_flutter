import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/profile_response.dart';
import 'package:flutter_map_booking/model/update_profile_request.dart';
import 'package:flutter_map_booking/services/trip_service.dart';
import 'package:simplest/simplest.dart';
import 'package:flutter_map_booking/common/config.dart';

part 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  onSelectHelp() async {
    String tel = 'tel:$kSupportNumber';
    if (await canLaunch(tel)) {
      await launch(tel);
    } else {
      throw 'Could not launch $tel';
    }
  }

  getProfile() async {
    try {
      if (appPref.userProfile != null) {
        emit(GetProfileSuccessState(appPref.userProfile, state));
      }
      emit(state.copyWith(inAsyncCall: true));
      ProfileResponse profileResponse = await dataRepository.getProfile();
      appPref.userName = profileResponse?.lastName ?? null;
      appPref.userProfile = profileResponse;
      emit(GetProfileSuccessState(profileResponse, state));
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(inAsyncCall: false));
  }

  submitUpdate({PhoneNumber phoneNumber, firstName, lastName, email}) async {
    try {
      emit(state.copyWith(inAsyncCall: true));
      // Do not allow to update phone or email
      final profileResponse = await dataRepository.updateProfile(
        // countryCode: '+${phoneNumber.callingCode}',
        // mobile: phoneNumber.parsedNumber,
        // email: state.profileRequest.email,
        firstName: state.profileRequest.firstName,
        lastName: state.profileRequest.lastName,
        picture: state.profileRequest.picture,
      );
      appPref.userProfile = profileResponse;
      emit(state.copyWith(inAsyncCall: false));
      snackbarService.showSnackbar(message: 'update_profile_success'.tr);
      emit(UpdateProfileSuccessState(profileResponse, state));
    } catch (e) {
      handleAppError(e);
    }
  }

  logout() async {
    try {
      final dialogResponse = await dialogService.showConfirmationDialog(
          title: kAppName,
          description: 'are_you_sure_to_logout'.tr,
          cancelTitle: 'cancel'.tr,
          confirmationTitle: 'ok'.tr);
      if (!dialogResponse.confirmed) {
        return;
      }
      emit(state.copyWith(inAsyncCall: true));
      await locator<TripService>().stopService();
      await dataRepository.logout(userId: appPref.userId);
      await appPref.logout();
      dataRepository.loadAuthHeader();
      emit(state.copyWith(inAsyncCall: false));
      emit(LogoutSuccessState(state));
    } catch (e) {
      handleAppError(e);
    }
  }

  updateFirstName(String firstName) {
    UpdateProfileRequest request = state.profileRequest;
    request.firstName = firstName;
    emit(ProfileUpdateState(request, state));
  }

  updateLastName(String lastName) {
    UpdateProfileRequest request = state.profileRequest;
    request.lastName = lastName;
    emit(ProfileUpdateState(request, state));
  }

  updatePhone(String phone) {
    UpdateProfileRequest request = state.profileRequest;
    request.mobile = phone;
    emit(ProfileUpdateState(request, state));
  }

  updateCountryCode(String countryCode) {
    UpdateProfileRequest request = state.profileRequest;
    request.countryCode = countryCode;
    emit(ProfileUpdateState(request, state));
  }

  updateEmail(String email) {
    UpdateProfileRequest request = state.profileRequest;
    request.email = email;
    emit(ProfileUpdateState(request, state));
  }

  onSelectImageFromDevice() async {
    try {
      final file = await locator<MediaService>().pickImage();
      if (file == null) {
        return;
      }
      final _currentRequest = state.profileRequest;
      _currentRequest.picture = file;
      emit(state.copyWith(profileRequest: _currentRequest));
    } catch (error) {
      logger.e(error);
      showErrorMessage('unable_to_select_image'.tr);
    }
  }
}
