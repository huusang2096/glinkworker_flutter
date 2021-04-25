// To parse this JSON data, do
//
//     final ProfileResponse = ProfileResponseFromJson(jsonString);

import 'dart:convert';

class ProfileResponse {
    ProfileResponse({
        this.id,
        this.firstName,
        this.lastName,
        this.paymentMode,
        this.userType,
        this.email,
        this.gender,
        this.countryCode,
        this.mobile,
        this.picture,
        this.deviceToken,
        this.deviceId,
        this.deviceType,
        this.loginBy,
        this.socialUniqueId,
        this.latitude,
        this.longitude,
        this.stripeCustId,
        this.walletBalance,
        this.rating,
        this.otp,
        this.language,
        this.qrcodeUrl,
        this.referralUniqueId,
        this.referalCount,
        this.trialEndsAt,
        this.updatedAt,
        this.currency,
        this.sos,
        this.appContact,
        this.measurement,
        this.cash,
        this.debitMachine,
        this.voucher,
        this.card,
        this.payumoney,
        this.paypal,
        this.paypalAdaptive,
        this.braintree,
        this.paytm,
        this.stripeSecretKey,
        this.stripePublishableKey,
        this.stripeCurrency,
        this.payumoneyEnvironment,
        this.payumoneyKey,
        this.payumoneySalt,
        this.payumoneyAuth,
        this.paypalEnvironment,
        this.paypalCurrency,
        this.paypalClientId,
        this.paypalClientSecret,
        this.braintreeEnvironment,
        this.braintreeMerchantId,
        this.braintreePublicKey,
        this.braintreePrivateKey,
        this.referralCount,
        this.referralAmount,
        this.referralText,
        this.referralTotalCount,
        this.referralTotalAmount,
        this.referralTotalText,
        this.rideOtp,
        this.rideToll,
    });

    int id;
    String firstName;
    String lastName;
    String paymentMode;
    String userType;
    String email;
    String gender;
    String countryCode;
    String mobile;
    String picture;
    dynamic deviceToken;
    dynamic deviceId;
    String deviceType;
    String loginBy;
    dynamic socialUniqueId;
    double latitude;
    double longitude;
    dynamic stripeCustId;
    int walletBalance;
    String rating;
    int otp;
    dynamic language;
    String qrcodeUrl;
    dynamic referralUniqueId;
    int referalCount;
    dynamic trialEndsAt;
    DateTime updatedAt;
    String currency;
    String sos;
    String appContact;
    String measurement;
    int cash;
    int debitMachine;
    int voucher;
    int card;
    int payumoney;
    int paypal;
    int paypalAdaptive;
    int braintree;
    int paytm;
    String stripeSecretKey;
    String stripePublishableKey;
    String stripeCurrency;
    String payumoneyEnvironment;
    String payumoneyKey;
    String payumoneySalt;
    String payumoneyAuth;
    String paypalEnvironment;
    String paypalCurrency;
    String paypalClientId;
    String paypalClientSecret;
    String braintreeEnvironment;
    String braintreeMerchantId;
    String braintreePublicKey;
    String braintreePrivateKey;
    String referralCount;
    String referralAmount;
    String referralText;
    String referralTotalCount;
    int referralTotalAmount;
    String referralTotalText;
    int rideOtp;
    int rideToll;

    factory ProfileResponse.fromRawJson(String str) => ProfileResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        userType: json["user_type"] == null ? null : json["user_type"],
        email: json["email"] == null ? null : json["email"],
        gender: json["gender"] == null ? null : json["gender"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        picture: json["picture"] == null ? null : json["picture"],
        deviceToken: json["device_token"],
        deviceId: json["device_id"],
        deviceType: json["device_type"] == null ? null : json["device_type"],
        loginBy: json["login_by"] == null ? null : json["login_by"],
        socialUniqueId: json["social_unique_id"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        stripeCustId: json["stripe_cust_id"],
        walletBalance: json["wallet_balance"] == null ? null : json["wallet_balance"],
        rating: json["rating"] == null ? null : json["rating"],
        otp: json["otp"] == null ? null : json["otp"],
        language: json["language"],
        qrcodeUrl: json["qrcode_url"] == null ? null : json["qrcode_url"],
        referralUniqueId: json["referral_unique_id"],
        referalCount: json["referal_count"] == null ? null : json["referal_count"],
        trialEndsAt: json["trial_ends_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        currency: json["currency"] == null ? null : json["currency"],
        sos: json["sos"] == null ? null : json["sos"],
        appContact: json["app_contact"] == null ? null : json["app_contact"],
        measurement: json["measurement"] == null ? null : json["measurement"],
        cash: json["cash"] == null ? null : json["cash"],
        debitMachine: json["debit_machine"] == null ? null : json["debit_machine"],
        voucher: json["voucher"] == null ? null : json["voucher"],
        card: json["card"] == null ? null : json["card"],
        payumoney: json["payumoney"] == null ? null : json["payumoney"],
        paypal: json["paypal"] == null ? null : json["paypal"],
        paypalAdaptive: json["paypal_adaptive"] == null ? null : json["paypal_adaptive"],
        braintree: json["braintree"] == null ? null : json["braintree"],
        paytm: json["paytm"] == null ? null : json["paytm"],
        stripeSecretKey: json["stripe_secret_key"] == null ? null : json["stripe_secret_key"],
        stripePublishableKey: json["stripe_publishable_key"] == null ? null : json["stripe_publishable_key"],
        stripeCurrency: json["stripe_currency"] == null ? null : json["stripe_currency"],
        payumoneyEnvironment: json["payumoney_environment"] == null ? null : json["payumoney_environment"],
        payumoneyKey: json["payumoney_key"] == null ? null : json["payumoney_key"],
        payumoneySalt: json["payumoney_salt"] == null ? null : json["payumoney_salt"],
        payumoneyAuth: json["payumoney_auth"] == null ? null : json["payumoney_auth"],
        paypalEnvironment: json["paypal_environment"] == null ? null : json["paypal_environment"],
        paypalCurrency: json["paypal_currency"] == null ? null : json["paypal_currency"],
        paypalClientId: json["paypal_client_id"] == null ? null : json["paypal_client_id"],
        paypalClientSecret: json["paypal_client_secret"] == null ? null : json["paypal_client_secret"],
        braintreeEnvironment: json["braintree_environment"] == null ? null : json["braintree_environment"],
        braintreeMerchantId: json["braintree_merchant_id"] == null ? null : json["braintree_merchant_id"],
        braintreePublicKey: json["braintree_public_key"] == null ? null : json["braintree_public_key"],
        braintreePrivateKey: json["braintree_private_key"] == null ? null : json["braintree_private_key"],
        referralCount: json["referral_count"] == null ? null : json["referral_count"],
        referralAmount: json["referral_amount"] == null ? null : json["referral_amount"],
        referralText: json["referral_text"] == null ? null : json["referral_text"],
        referralTotalCount: json["referral_total_count"] == null ? null : json["referral_total_count"],
        referralTotalAmount: json["referral_total_amount"] == null ? null : json["referral_total_amount"],
        referralTotalText: json["referral_total_text"] == null ? null : json["referral_total_text"],
        rideOtp: json["ride_otp"] == null ? null : json["ride_otp"],
        rideToll: json["ride_toll"] == null ? null : json["ride_toll"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "payment_mode": paymentMode == null ? null : paymentMode,
        "user_type": userType == null ? null : userType,
        "email": email == null ? null : email,
        "gender": gender == null ? null : gender,
        "country_code": countryCode == null ? null : countryCode,
        "mobile": mobile == null ? null : mobile,
        "picture": picture == null ? null : picture,
        "device_token": deviceToken,
        "device_id": deviceId,
        "device_type": deviceType == null ? null : deviceType,
        "login_by": loginBy == null ? null : loginBy,
        "social_unique_id": socialUniqueId,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "stripe_cust_id": stripeCustId,
        "wallet_balance": walletBalance == null ? null : walletBalance,
        "rating": rating == null ? null : rating,
        "otp": otp == null ? null : otp,
        "language": language,
        "qrcode_url": qrcodeUrl == null ? null : qrcodeUrl,
        "referral_unique_id": referralUniqueId,
        "referal_count": referalCount == null ? null : referalCount,
        "trial_ends_at": trialEndsAt,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "currency": currency == null ? null : currency,
        "sos": sos == null ? null : sos,
        "app_contact": appContact == null ? null : appContact,
        "measurement": measurement == null ? null : measurement,
        "cash": cash == null ? null : cash,
        "debit_machine": debitMachine == null ? null : debitMachine,
        "voucher": voucher == null ? null : voucher,
        "card": card == null ? null : card,
        "payumoney": payumoney == null ? null : payumoney,
        "paypal": paypal == null ? null : paypal,
        "paypal_adaptive": paypalAdaptive == null ? null : paypalAdaptive,
        "braintree": braintree == null ? null : braintree,
        "paytm": paytm == null ? null : paytm,
        "stripe_secret_key": stripeSecretKey == null ? null : stripeSecretKey,
        "stripe_publishable_key": stripePublishableKey == null ? null : stripePublishableKey,
        "stripe_currency": stripeCurrency == null ? null : stripeCurrency,
        "payumoney_environment": payumoneyEnvironment == null ? null : payumoneyEnvironment,
        "payumoney_key": payumoneyKey == null ? null : payumoneyKey,
        "payumoney_salt": payumoneySalt == null ? null : payumoneySalt,
        "payumoney_auth": payumoneyAuth == null ? null : payumoneyAuth,
        "paypal_environment": paypalEnvironment == null ? null : paypalEnvironment,
        "paypal_currency": paypalCurrency == null ? null : paypalCurrency,
        "paypal_client_id": paypalClientId == null ? null : paypalClientId,
        "paypal_client_secret": paypalClientSecret == null ? null : paypalClientSecret,
        "braintree_environment": braintreeEnvironment == null ? null : braintreeEnvironment,
        "braintree_merchant_id": braintreeMerchantId == null ? null : braintreeMerchantId,
        "braintree_public_key": braintreePublicKey == null ? null : braintreePublicKey,
        "braintree_private_key": braintreePrivateKey == null ? null : braintreePrivateKey,
        "referral_count": referralCount == null ? null : referralCount,
        "referral_amount": referralAmount == null ? null : referralAmount,
        "referral_text": referralText == null ? null : referralText,
        "referral_total_count": referralTotalCount == null ? null : referralTotalCount,
        "referral_total_amount": referralTotalAmount == null ? null : referralTotalAmount,
        "referral_total_text": referralTotalText == null ? null : referralTotalText,
        "ride_otp": rideOtp == null ? null : rideOtp,
        "ride_toll": rideToll == null ? null : rideToll,
    };
}
