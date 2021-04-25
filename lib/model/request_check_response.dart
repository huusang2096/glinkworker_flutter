// To parse this JSON data, do
//
//     final requestCheckResponse = requestCheckResponseFromJson(jsonString);

import 'dart:convert';

class RequestCheckResponse {
  RequestCheckResponse({
    this.data,
    this.sos,
    this.cash,
    this.debitMachine,
    this.voucher,
    this.card,
    this.currency,
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
  });

  List<Datum> data;
  String sos;
  int cash;
  int debitMachine;
  int voucher;
  int card;
  String currency;
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

  factory RequestCheckResponse.fromRawJson(String str) =>
      RequestCheckResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestCheckResponse.fromJson(Map<String, dynamic> json) =>
      RequestCheckResponse(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        sos: json["sos"] == null ? null : json["sos"],
        cash: json["cash"] == null ? null : json["cash"],
        debitMachine:
            json["debit_machine"] == null ? null : json["debit_machine"],
        voucher: json["voucher"] == null ? null : json["voucher"],
        card: json["card"] == null ? null : json["card"],
        currency: json["currency"] == null ? null : json["currency"],
        payumoney: json["payumoney"] == null ? null : json["payumoney"],
        paypal: json["paypal"] == null ? null : json["paypal"],
        paypalAdaptive:
            json["paypal_adaptive"] == null ? null : json["paypal_adaptive"],
        braintree: json["braintree"] == null ? null : json["braintree"],
        paytm: json["paytm"] == null ? null : json["paytm"],
        stripeSecretKey: json["stripe_secret_key"] == null
            ? null
            : json["stripe_secret_key"],
        stripePublishableKey: json["stripe_publishable_key"] == null
            ? null
            : json["stripe_publishable_key"],
        stripeCurrency:
            json["stripe_currency"] == null ? null : json["stripe_currency"],
        payumoneyEnvironment: json["payumoney_environment"] == null
            ? null
            : json["payumoney_environment"],
        payumoneyKey:
            json["payumoney_key"] == null ? null : json["payumoney_key"],
        payumoneySalt:
            json["payumoney_salt"] == null ? null : json["payumoney_salt"],
        payumoneyAuth:
            json["payumoney_auth"] == null ? null : json["payumoney_auth"],
        paypalEnvironment: json["paypal_environment"] == null
            ? null
            : json["paypal_environment"],
        paypalCurrency:
            json["paypal_currency"] == null ? null : json["paypal_currency"],
        paypalClientId:
            json["paypal_client_id"] == null ? null : json["paypal_client_id"],
        paypalClientSecret: json["paypal_client_secret"] == null
            ? null
            : json["paypal_client_secret"],
        braintreeEnvironment: json["braintree_environment"] == null
            ? null
            : json["braintree_environment"],
        braintreeMerchantId: json["braintree_merchant_id"] == null
            ? null
            : json["braintree_merchant_id"],
        braintreePublicKey: json["braintree_public_key"] == null
            ? null
            : json["braintree_public_key"],
        braintreePrivateKey: json["braintree_private_key"] == null
            ? null
            : json["braintree_private_key"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "sos": sos == null ? null : sos,
        "cash": cash == null ? null : cash,
        "debit_machine": debitMachine == null ? null : debitMachine,
        "voucher": voucher == null ? null : voucher,
        "card": card == null ? null : card,
        "currency": currency == null ? null : currency,
        "payumoney": payumoney == null ? null : payumoney,
        "paypal": paypal == null ? null : paypal,
        "paypal_adaptive": paypalAdaptive == null ? null : paypalAdaptive,
        "braintree": braintree == null ? null : braintree,
        "paytm": paytm == null ? null : paytm,
        "stripe_secret_key": stripeSecretKey == null ? null : stripeSecretKey,
        "stripe_publishable_key":
            stripePublishableKey == null ? null : stripePublishableKey,
        "stripe_currency": stripeCurrency == null ? null : stripeCurrency,
        "payumoney_environment":
            payumoneyEnvironment == null ? null : payumoneyEnvironment,
        "payumoney_key": payumoneyKey == null ? null : payumoneyKey,
        "payumoney_salt": payumoneySalt == null ? null : payumoneySalt,
        "payumoney_auth": payumoneyAuth == null ? null : payumoneyAuth,
        "paypal_environment":
            paypalEnvironment == null ? null : paypalEnvironment,
        "paypal_currency": paypalCurrency == null ? null : paypalCurrency,
        "paypal_client_id": paypalClientId == null ? null : paypalClientId,
        "paypal_client_secret":
            paypalClientSecret == null ? null : paypalClientSecret,
        "braintree_environment":
            braintreeEnvironment == null ? null : braintreeEnvironment,
        "braintree_merchant_id":
            braintreeMerchantId == null ? null : braintreeMerchantId,
        "braintree_public_key":
            braintreePublicKey == null ? null : braintreePublicKey,
        "braintree_private_key":
            braintreePrivateKey == null ? null : braintreePrivateKey,
      };
}

class Datum {
  Datum({
    this.id,
    this.bookingId,
    this.userId,
    this.braintreeNonce,
    this.providerId,
    this.currentProviderId,
    this.serviceTypeId,
    this.beforeImage,
    this.beforeComment,
    this.afterImage,
    this.afterComment,
    this.promocodeId,
    this.status,
    this.cancelledBy,
    this.cancelReason,
    this.paymentMode,
    this.paid,
    this.isTrack,
    this.distance,
    this.travelTime,
    this.unit,
    this.otp,
    this.sAddress,
    this.sLatitude,
    this.sLongitude,
    this.dAddress,
    this.dLatitude,
    this.dLongitude,
    this.trackDistance,
    this.trackLatitude,
    this.trackLongitude,
    this.destinationLog,
    this.isDropLocation,
    this.isInstantRide,
    this.isDispute,
    this.assignedAt,
    this.scheduleAt,
    this.startedAt,
    this.finishedAt,
    this.isScheduled,
    this.userRated,
    this.providerRated,
    this.useWallet,
    this.surge,
    this.routeKey,
    this.nonce,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.provider,
    this.serviceType,
    this.providerService,
    this.rating,
    this.payment,
    this.rideOtp,
    this.rideToll,
    this.reasons,
  });

  int id;
  String bookingId;
  int userId;
  dynamic braintreeNonce;
  int providerId;
  int currentProviderId;
  int serviceTypeId;
  dynamic beforeImage;
  dynamic beforeComment;
  dynamic afterImage;
  dynamic afterComment;
  int promocodeId;
  String status;
  String cancelledBy;
  dynamic cancelReason;
  String paymentMode;
  int paid;
  String isTrack;
  double distance;
  String travelTime;
  String unit;
  String otp;
  String sAddress;
  double sLatitude;
  double sLongitude;
  String dAddress;
  double dLatitude;
  double dLongitude;
  int trackDistance;
  int trackLatitude;
  int trackLongitude;
  String destinationLog;
  int isDropLocation;
  int isInstantRide;
  int isDispute;
  DateTime assignedAt;
  dynamic scheduleAt;
  DateTime startedAt;
  DateTime finishedAt;
  String isScheduled;
  int userRated;
  int providerRated;
  int useWallet;
  int surge;
  String routeKey;
  dynamic nonce;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  Provider provider;
  ServiceType serviceType;
  ProviderService providerService;
  Rating rating;
  Payment payment;
  int rideOtp;
  int rideToll;
  List<Reason> reasons;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        bookingId: json["booking_id"] == null ? null : json["booking_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        braintreeNonce: json["braintree_nonce"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        currentProviderId: json["current_provider_id"] == null
            ? null
            : json["current_provider_id"],
        serviceTypeId:
            json["service_type_id"] == null ? null : json["service_type_id"],
        beforeImage: json["before_image"],
        beforeComment: json["before_comment"],
        afterImage: json["after_image"],
        afterComment: json["after_comment"],
        promocodeId: json["promocode_id"] == null ? null : json["promocode_id"],
        status: json["status"] == null ? null : json["status"],
        cancelledBy: json["cancelled_by"] == null ? null : json["cancelled_by"],
        cancelReason: json["cancel_reason"],
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        paid: json["paid"] == null ? null : json["paid"],
        isTrack: json["is_track"] == null ? null : json["is_track"],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        travelTime: json["travel_time"] == null ? null : json["travel_time"],
        unit: json["unit"] == null ? null : json["unit"],
        otp: json["otp"] == null ? null : json["otp"],
        sAddress: json["s_address"] == null ? null : json["s_address"],
        sLatitude:
            json["s_latitude"] == null ? null : json["s_latitude"].toDouble(),
        sLongitude:
            json["s_longitude"] == null ? null : json["s_longitude"].toDouble(),
        dAddress: json["d_address"] == null ? null : json["d_address"],
        dLatitude:
            json["d_latitude"] == null ? null : json["d_latitude"].toDouble(),
        dLongitude:
            json["d_longitude"] == null ? null : json["d_longitude"].toDouble(),
        trackDistance:
            json["track_distance"] == null ? null : json["track_distance"],
        trackLatitude:
            json["track_latitude"] == null ? null : json["track_latitude"],
        trackLongitude:
            json["track_longitude"] == null ? null : json["track_longitude"],
        destinationLog:
            json["destination_log"] == null ? null : json["destination_log"],
        isDropLocation:
            json["is_drop_location"] == null ? null : json["is_drop_location"],
        isInstantRide:
            json["is_instant_ride"] == null ? null : json["is_instant_ride"],
        isDispute: json["is_dispute"] == null ? null : json["is_dispute"],
        assignedAt: json["assigned_at"] == null
            ? null
            : DateTime.parse(json["assigned_at"]),
        scheduleAt: json["schedule_at"],
        startedAt: json["started_at"] == null
            ? null
            : DateTime.parse(json["started_at"]),
        finishedAt: json["finished_at"] == null
            ? null
            : DateTime.parse(json["finished_at"]),
        isScheduled: json["is_scheduled"] == null ? null : json["is_scheduled"],
        userRated: json["user_rated"] == null ? null : json["user_rated"],
        providerRated:
            json["provider_rated"] == null ? null : json["provider_rated"],
        useWallet: json["use_wallet"] == null ? null : json["use_wallet"],
        surge: json["surge"] == null ? null : json["surge"],
        routeKey: json["route_key"] == null ? null : json["route_key"],
        nonce: json["nonce"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        provider: json["provider"] == null
            ? null
            : Provider.fromJson(json["provider"]),
        serviceType: json["service_type"] == null
            ? null
            : ServiceType.fromJson(json["service_type"]),
        providerService: json["provider_service"] == null
            ? null
            : ProviderService.fromJson(json["provider_service"]),
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        rideOtp: json["ride_otp"] == null ? null : json["ride_otp"],
        rideToll: json["ride_toll"] == null ? null : json["ride_toll"],
        reasons: json["reasons"] == null
            ? null
            : List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "booking_id": bookingId == null ? null : bookingId,
        "user_id": userId == null ? null : userId,
        "braintree_nonce": braintreeNonce,
        "provider_id": providerId == null ? null : providerId,
        "current_provider_id":
            currentProviderId == null ? null : currentProviderId,
        "service_type_id": serviceTypeId == null ? null : serviceTypeId,
        "before_image": beforeImage,
        "before_comment": beforeComment,
        "after_image": afterImage,
        "after_comment": afterComment,
        "promocode_id": promocodeId == null ? null : promocodeId,
        "status": status == null ? null : status,
        "cancelled_by": cancelledBy == null ? null : cancelledBy,
        "cancel_reason": cancelReason,
        "payment_mode": paymentMode == null ? null : paymentMode,
        "paid": paid == null ? null : paid,
        "is_track": isTrack == null ? null : isTrack,
        "distance": distance == null ? null : distance,
        "travel_time": travelTime == null ? null : travelTime,
        "unit": unit == null ? null : unit,
        "otp": otp == null ? null : otp,
        "s_address": sAddress == null ? null : sAddress,
        "s_latitude": sLatitude == null ? null : sLatitude,
        "s_longitude": sLongitude == null ? null : sLongitude,
        "d_address": dAddress == null ? null : dAddress,
        "d_latitude": dLatitude == null ? null : dLatitude,
        "d_longitude": dLongitude == null ? null : dLongitude,
        "track_distance": trackDistance == null ? null : trackDistance,
        "track_latitude": trackLatitude == null ? null : trackLatitude,
        "track_longitude": trackLongitude == null ? null : trackLongitude,
        "destination_log": destinationLog == null ? null : destinationLog,
        "is_drop_location": isDropLocation == null ? null : isDropLocation,
        "is_instant_ride": isInstantRide == null ? null : isInstantRide,
        "is_dispute": isDispute == null ? null : isDispute,
        "assigned_at": assignedAt == null ? null : assignedAt.toIso8601String(),
        "schedule_at": scheduleAt,
        "started_at": startedAt == null ? null : startedAt.toIso8601String(),
        "finished_at": finishedAt == null ? null : finishedAt.toIso8601String(),
        "is_scheduled": isScheduled == null ? null : isScheduled,
        "user_rated": userRated == null ? null : userRated,
        "provider_rated": providerRated == null ? null : providerRated,
        "use_wallet": useWallet == null ? null : useWallet,
        "surge": surge == null ? null : surge,
        "route_key": routeKey == null ? null : routeKey,
        "nonce": nonce,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "user": user == null ? null : user.toJson(),
        "provider": provider == null ? null : provider.toJson(),
        "service_type": serviceType == null ? null : serviceType.toJson(),
        "provider_service":
            providerService == null ? null : providerService.toJson(),
        "rating": rating == null ? null : rating.toJson(),
        "payment": payment == null ? null : payment.toJson(),
        "ride_otp": rideOtp == null ? null : rideOtp,
        "ride_toll": rideToll == null ? null : rideToll,
        "reasons": reasons == null
            ? null
            : List<dynamic>.from(reasons.map((x) => x.toJson())),
      };
}

class Payment {
  Payment({
    this.id,
    this.requestId,
    this.userId,
    this.providerId,
    this.agentId,
    this.promocodeId,
    this.paymentId,
    this.paymentMode,
    this.fixed,
    this.distance,
    this.timePrice,
    this.minute,
    this.hour,
    this.commision,
    this.commisionPer,
    this.agent,
    this.agentPer,
    this.discount,
    this.discountPer,
    this.tax,
    this.taxPer,
    this.wallet,
    this.isPartial,
    this.cash,
    this.card,
    this.online,
    this.surge,
    this.tollCharge,
    this.roundOf,
    this.peakAmount,
    this.peakCommAmount,
    this.totalWaitingTime,
    this.waitingAmount,
    this.waitingCommAmount,
    this.tips,
    this.total,
    this.payable,
    this.providerCommission,
    this.providerPay,
  });

  int id;
  int requestId;
  int userId;
  int providerId;
  dynamic agentId;
  dynamic promocodeId;
  dynamic paymentId;
  String paymentMode;
  double fixed;
  double distance;
  double timePrice;
  double minute;
  double hour;
  double commision;
  double commisionPer;
  int agent;
  int agentPer;
  double discount;
  double discountPer;
  double tax;
  double taxPer;
  double wallet;
  double isPartial;
  double cash;
  int card;
  double online;
  int surge;
  int tollCharge;
  int roundOf;
  int peakAmount;
  int peakCommAmount;
  int totalWaitingTime;
  int waitingAmount;
  int waitingCommAmount;
  double tips;
  double total;
  double payable;
  int providerCommission;
  double providerPay;

  factory Payment.fromRawJson(String str) => Payment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"] == null ? null : json["id"],
        requestId: json["request_id"] == null ? null : json["request_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        agentId: json["agent_id"],
        promocodeId: json["promocode_id"],
        paymentId: json["payment_id"],
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        fixed: json["fixed"] == null ? null : json["fixed"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        timePrice:
            json["time_price"] == null ? null : json["time_price"].toDouble(),
        minute: json["minute"] == null ? null : json["minute"].toDouble(),
        hour: json["hour"] == null ? null : json["hour"].toDouble(),
        commision:
            json["commision"] == null ? null : json["commision"].toDouble(),
        commisionPer: json["commision_per"] == null
            ? null
            : json["commision_per"].toDouble(),
        agent: json["agent"] == null ? null : json["agent"],
        agentPer: json["agent_per"] == null ? null : json["agent_per"],
        discount: json["discount"] == null ? null : json["discount"].toDouble(),
        discountPer: json["discount_per"] == null
            ? null
            : json["discount_per"].toDouble(),
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        taxPer: json["tax_per"] == null ? null : json["tax_per"].toDouble(),
        wallet: json["wallet"] == null ? null : json["wallet"].toDouble(),
        isPartial:
            json["is_partial"] == null ? null : json["is_partial"].toDouble(),
        cash: json["cash"] == null ? null : json["cash"].toDouble(),
        card: json["card"] == null ? null : json["card"],
        online: json["online"] == null ? null : json["online"].toDouble(),
        surge: json["surge"] == null ? null : json["surge"],
        tollCharge: json["toll_charge"] == null ? null : json["toll_charge"],
        roundOf: json["round_of"] == null ? null : json["round_of"],
        peakAmount: json["peak_amount"] == null ? null : json["peak_amount"],
        peakCommAmount:
            json["peak_comm_amount"] == null ? null : json["peak_comm_amount"],
        totalWaitingTime: json["total_waiting_time"] == null
            ? null
            : json["total_waiting_time"],
        waitingAmount:
            json["waiting_amount"] == null ? null : json["waiting_amount"],
        waitingCommAmount: json["waiting_comm_amount"] == null
            ? null
            : json["waiting_comm_amount"],
        tips: json["tips"] == null ? null : json["tips"].toDouble(),
        total: json["total"] == null ? null : json["total"].toDouble(),
        payable: json["payable"] == null ? null : json["payable"].toDouble(),
        providerCommission: json["provider_commission"] == null
            ? null
            : json["provider_commission"],
        providerPay: json["provider_pay"] == null
            ? null
            : json["provider_pay"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "request_id": requestId == null ? null : requestId,
        "user_id": userId == null ? null : userId,
        "provider_id": providerId == null ? null : providerId,
        "agent_id": agentId,
        "promocode_id": promocodeId,
        "payment_id": paymentId,
        "payment_mode": paymentMode == null ? null : paymentMode,
        "fixed": fixed == null ? null : fixed,
        "distance": distance == null ? null : distance,
        "time_price": timePrice == null ? null : timePrice,
        "minute": minute == null ? null : minute,
        "hour": hour == null ? null : hour,
        "commision": commision == null ? null : commision,
        "commision_per": commisionPer == null ? null : commisionPer,
        "agent": agent == null ? null : agent,
        "agent_per": agentPer == null ? null : agentPer,
        "discount": discount == null ? null : discount,
        "discount_per": discountPer == null ? null : discountPer,
        "tax": tax == null ? null : tax,
        "tax_per": taxPer == null ? null : taxPer,
        "wallet": wallet == null ? null : wallet,
        "is_partial": isPartial == null ? null : isPartial,
        "cash": cash == null ? null : cash,
        "card": card == null ? null : card,
        "online": online == null ? null : online,
        "surge": surge == null ? null : surge,
        "toll_charge": tollCharge == null ? null : tollCharge,
        "round_of": roundOf == null ? null : roundOf,
        "peak_amount": peakAmount == null ? null : peakAmount,
        "peak_comm_amount": peakCommAmount == null ? null : peakCommAmount,
        "total_waiting_time":
            totalWaitingTime == null ? null : totalWaitingTime,
        "waiting_amount": waitingAmount == null ? null : waitingAmount,
        "waiting_comm_amount":
            waitingCommAmount == null ? null : waitingCommAmount,
        "tips": tips == null ? null : tips,
        "total": total == null ? null : total,
        "payable": payable == null ? null : payable,
        "provider_commission":
            providerCommission == null ? null : providerCommission,
        "provider_pay": providerPay == null ? null : providerPay,
      };
}

class Provider {
  Provider({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.countryCode,
    this.mobile,
    this.avatar,
    this.rating,
    this.status,
    this.agent,
    this.latitude,
    this.longitude,
    this.stripeAccId,
    this.stripeCustId,
    this.paypalEmail,
    this.loginBy,
    this.socialUniqueId,
    this.otp,
    this.walletBalance,
    this.referralUniqueId,
    this.qrcodeUrl,
    this.trialProEndsAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String gender;
  String countryCode;
  String mobile;
  String avatar;
  String rating;
  String status;
  int agent;
  double latitude;
  double longitude;
  dynamic stripeAccId;
  String stripeCustId;
  dynamic paypalEmail;
  String loginBy;
  dynamic socialUniqueId;
  int otp;
  double walletBalance;
  dynamic referralUniqueId;
  dynamic qrcodeUrl;
  dynamic trialProEndsAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Provider.fromRawJson(String str) =>
      Provider.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        gender: json["gender"] == null ? null : json["gender"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        rating: json["rating"] == null ? null : json["rating"],
        status: json["status"] == null ? null : json["status"],
        agent: json["agent"] == null ? null : json["agent"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        stripeAccId: json["stripe_acc_id"],
        stripeCustId:
            json["stripe_cust_id"] == null ? null : json["stripe_cust_id"],
        paypalEmail: json["paypal_email"],
        loginBy: json["login_by"] == null ? null : json["login_by"],
        socialUniqueId: json["social_unique_id"],
        otp: json["otp"] == null ? null : json["otp"],
        walletBalance: json["wallet_balance"] == null
            ? null
            : json["wallet_balance"].toDouble(),
        referralUniqueId: json["referral_unique_id"],
        qrcodeUrl: json["qrcode_url"],
        trialProEndsAt: json["trial_pro_ends_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "gender": gender == null ? null : gender,
        "country_code": countryCode == null ? null : countryCode,
        "mobile": mobile == null ? null : mobile,
        "avatar": avatar == null ? null : avatar,
        "rating": rating == null ? null : rating,
        "status": status == null ? null : status,
        "agent": agent == null ? null : agent,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "stripe_acc_id": stripeAccId,
        "stripe_cust_id": stripeCustId == null ? null : stripeCustId,
        "paypal_email": paypalEmail,
        "login_by": loginBy == null ? null : loginBy,
        "social_unique_id": socialUniqueId,
        "otp": otp == null ? null : otp,
        "wallet_balance": walletBalance == null ? null : walletBalance,
        "referral_unique_id": referralUniqueId,
        "qrcode_url": qrcodeUrl,
        "trial_pro_ends_at": trialProEndsAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class ProviderService {
  ProviderService({
    this.id,
    this.providerId,
    this.serviceTypeId,
    this.status,
    this.serviceNumber,
    this.serviceModel,
  });

  int id;
  int providerId;
  int serviceTypeId;
  String status;
  String serviceNumber;
  String serviceModel;

  factory ProviderService.fromRawJson(String str) =>
      ProviderService.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProviderService.fromJson(Map<String, dynamic> json) =>
      ProviderService(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        serviceTypeId:
            json["service_type_id"] == null ? null : json["service_type_id"],
        status: json["status"] == null ? null : json["status"],
        serviceNumber:
            json["service_number"] == null ? null : json["service_number"],
        serviceModel:
            json["service_model"] == null ? null : json["service_model"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "service_type_id": serviceTypeId == null ? null : serviceTypeId,
        "status": status == null ? null : status,
        "service_number": serviceNumber == null ? null : serviceNumber,
        "service_model": serviceModel == null ? null : serviceModel,
      };
}

class Rating {
  Rating({
    this.id,
    this.requestId,
    this.userId,
    this.providerId,
    this.userRating,
    this.providerRating,
    this.userComment,
    this.providerComment,
  });

  int id;
  int requestId;
  int userId;
  int providerId;
  double userRating;
  double providerRating;
  dynamic userComment;
  String providerComment;

  factory Rating.fromRawJson(String str) => Rating.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"] == null ? null : json["id"],
        requestId: json["request_id"] == null ? null : json["request_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        userRating:
            json["user_rating"] == null ? null : json["user_rating"].toDouble(),
        providerRating: json["provider_rating"] == null
            ? null
            : json["provider_rating"].toDouble(),
        userComment: json["user_comment"],
        providerComment:
            json["provider_comment"] == null ? null : json["provider_comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "request_id": requestId == null ? null : requestId,
        "user_id": userId == null ? null : userId,
        "provider_id": providerId == null ? null : providerId,
        "user_rating": userRating == null ? null : userRating,
        "provider_rating": providerRating == null ? null : providerRating,
        "user_comment": userComment,
        "provider_comment": providerComment == null ? null : providerComment,
      };
}

class Reason {
  Reason({
    this.id,
    this.type,
    this.reason,
    this.status,
  });

  int id;
  String type;
  String reason;
  int status;

  factory Reason.fromRawJson(String str) => Reason.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        reason: json["reason"] == null ? null : json["reason"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "reason": reason == null ? null : reason,
        "status": status == null ? null : status,
      };
}

class ServiceType {
  ServiceType({
    this.id,
    this.parentId,
    this.agentId,
    this.name,
    this.providerName,
    this.image,
    this.marker,
    this.fixed,
    this.price,
    this.typePrice,
    this.calculator,
    this.description,
    this.status,
  });

  int id;
  int parentId;
  int agentId;
  String name;
  String providerName;
  String image;
  String marker;
  double fixed;
  double price;
  double typePrice;
  String calculator;
  dynamic description;
  int status;

  factory ServiceType.fromRawJson(String str) =>
      ServiceType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        id: json["id"] == null ? null : json["id"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        agentId: json["agent_id"] == null ? null : json["agent_id"],
        name: json["name"] == null ? null : json["name"],
        providerName:
            json["provider_name"] == null ? null : json["provider_name"],
        image: json["image"] == null ? null : json["image"],
        marker: json["marker"] == null ? null : json["marker"],
        fixed: json["fixed"] == null ? null : json["fixed"].toDouble(),
        price: json["price"] == null ? null : json["price"].toDouble(),
        typePrice:
            json["type_price"] == null ? null : json["type_price"].toDouble(),
        calculator: json["calculator"] == null ? null : json["calculator"],
        description: json["description"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "parent_id": parentId == null ? null : parentId,
        "agent_id": agentId == null ? null : agentId,
        "name": name == null ? null : name,
        "provider_name": providerName == null ? null : providerName,
        "image": image == null ? null : image,
        "marker": marker == null ? null : marker,
        "fixed": fixed == null ? null : fixed,
        "price": price == null ? null : price,
        "type_price": typePrice == null ? null : typePrice,
        "calculator": calculator == null ? null : calculator,
        "description": description,
        "status": status == null ? null : status,
      };
}

class User {
  User({
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
  String deviceToken;
  String deviceId;
  String deviceType;
  String loginBy;
  dynamic socialUniqueId;
  double latitude;
  double longitude;
  String stripeCustId;
  int walletBalance;
  String rating;
  int otp;
  String language;
  String qrcodeUrl;
  String referralUniqueId;
  int referalCount;
  dynamic trialEndsAt;
  DateTime updatedAt;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        deviceId: json["device_id"] == null ? null : json["device_id"],
        deviceType: json["device_type"] == null ? null : json["device_type"],
        loginBy: json["login_by"] == null ? null : json["login_by"],
        socialUniqueId: json["social_unique_id"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        stripeCustId:
            json["stripe_cust_id"] == null ? null : json["stripe_cust_id"],
        walletBalance:
            json["wallet_balance"] == null ? null : json["wallet_balance"],
        rating: json["rating"] == null ? null : json["rating"],
        otp: json["otp"] == null ? null : json["otp"],
        language: json["language"] == null ? null : json["language"],
        qrcodeUrl: json["qrcode_url"] == null ? null : json["qrcode_url"],
        referralUniqueId: json["referral_unique_id"] == null
            ? null
            : json["referral_unique_id"],
        referalCount:
            json["referal_count"] == null ? null : json["referal_count"],
        trialEndsAt: json["trial_ends_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "device_token": deviceToken == null ? null : deviceToken,
        "device_id": deviceId == null ? null : deviceId,
        "device_type": deviceType == null ? null : deviceType,
        "login_by": loginBy == null ? null : loginBy,
        "social_unique_id": socialUniqueId,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "stripe_cust_id": stripeCustId == null ? null : stripeCustId,
        "wallet_balance": walletBalance == null ? null : walletBalance,
        "rating": rating == null ? null : rating,
        "otp": otp == null ? null : otp,
        "language": language == null ? null : language,
        "qrcode_url": qrcodeUrl == null ? null : qrcodeUrl,
        "referral_unique_id":
            referralUniqueId == null ? null : referralUniqueId,
        "referal_count": referalCount == null ? null : referalCount,
        "trial_ends_at": trialEndsAt,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
