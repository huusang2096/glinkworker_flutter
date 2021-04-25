import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/model/profile_response.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/profile/cubit/profile_cubit.dart';
import 'package:flutter_map_booking/widgets/app_progress_hub.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simplest/simplest.dart';

class ProfileScreen extends CubitWidget<ProfileCubit, ProfileState> {
  ProfileResponse profileResponse;

  ProfileScreen({this.profileResponse});

  static provider(ProfileResponse profileResponse) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: ProfileScreen(
        profileResponse: profileResponse,
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
    bloc.getProfile();
  }

  void _handleLogout(BuildContext context) {
    bloc.logout();
  }

  @override
  void listener(BuildContext context, ProfileState state) {
    super.listener(context, state);

    if (state is GetProfileSuccessState) {
      profileResponse = state.profileResponse;
    }
    if (state is LogoutSuccessState) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoute.loginScreen, (route) => false);
    }
  }

  @override
  Widget builder(BuildContext context, ProfileState state) {
    if (profileResponse == null) {
      profileResponse = state.profileResponse;
    }
    final _avatar = BASE_URL_STORAGE + (profileResponse?.picture ?? '');
    return profileResponse == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: AppProgressHUB(
              inAsyncCall: state.inAsyncCall,
              child: ListView(
                children: [
                  //Avatar
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(72.0),
                          child: InkWell(
                            onTap: () => _navigateToEditProfile(),
                            child: CachedNetworkImage(
                              imageUrl: _avatar,
                              width: 72.0,
                              height: 72.0,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  Images.defaultAvatar.loadImage(size: 72),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.all(18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        "${profileResponse?.firstName ?? ''} ${profileResponse?.lastName ?? ''}",
                                        style: title,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "${profileResponse?.countryCode ?? ''} ${profileResponse?.mobile ?? ""}",
                                    style: body1.apply(color: Colors.grey),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: lineGrey,
                    thickness: 4,
                  ),
                  //Account
                  Container(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "account".tr,
                            style: caption.apply(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () => _navigateToEditProfile(),
                            child: Row(
                              children: [
                                SvgPicture.asset(Images.editProfileIcon),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    "profile".tr,
                                    style: body1.apply(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     //TODO: Set address
                          //   },
                          //   child: Row(
                          //     children: [
                          //       SvgPicture.asset(Images.addressIcon),
                          //       SizedBox(
                          //         width: 16,
                          //       ),
                          //       Expanded(
                          //         child: Text(
                          //           "set_address".tr,
                          //           style: body1.apply(color: Colors.grey),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                          InkWell(
                            onTap: () {
                              navigator.pushNamed(AppRoute.walletScreen);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    "wallet".tr,
                                    style: body1.apply(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          /* InkWell(
                          onTap: () {
                            navigator.pushNamed(AppRoute.paymentScreen,
                                arguments: {'amount': 0, 'requestGoto': false});
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Text(
                                  "card_payment".tr,
                                  style: body1.apply(color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ), */
                        ],
                      )),
                  Divider(
                    height: 0,
                    color: lineGrey,
                    thickness: 4,
                  ),
                  // Promo
                  Container(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Promo".tr,
                            style: caption.apply(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () {
                              navigator.pushNamed(AppRoute.offerScreen,
                                  arguments: {'disable': true});
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(Images.discountsIcon),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    "get_discounts".tr,
                                    style: body1.apply(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                  Divider(
                    height: 0,
                    color: lineGrey,
                    thickness: 4,
                  ),
                  // setting
                  Container(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "setting".tr,
                            style: caption.apply(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoute.languagesScreen);
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(Images.languageIcon),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    "language".tr,
                                    style: body1.apply(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: bloc.onSelectHelp,
                            child: Row(
                              children: [
                                SvgPicture.asset(Images.helpIcon),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    "help".tr,
                                    style: body1.apply(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Divider(
                    height: 0,
                    color: lineGrey,
                    thickness: 4,
                  ),
                  // Logout
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => _handleLogout(context),
                          child: Row(
                            children: [
                              SvgPicture.asset(Images.logoutIcon),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Text(
                                  "logout".tr,
                                  style: body1.apply(color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  _navigateToEditProfile() async {
    await navigator.pushNamed(AppRoute.editProfileScreen);
    bloc.getProfile();
  }
}
