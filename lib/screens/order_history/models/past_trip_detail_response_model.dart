// To parse this JSON data, do
//
//     final pastTripDetail = pastTripDetailFromJson(jsonString);

import 'dart:convert';

class PastTripDetail {
  PastTripDetail({
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
    this.staticMap,
    this.dispute,
    this.lostitem,
    this.contactNumber,
    this.contactEmail,
    this.payment,
    this.serviceType,
    this.user,
    this.provider,
    this.rating,
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
  double trackDistance;
  double trackLatitude;
  double trackLongitude;
  String destinationLog;
  double isDropLocation;
  double isInstantRide;
  double isDispute;
  DateTime assignedAt;
  dynamic scheduleAt;
  DateTime startedAt;
  DateTime finishedAt;
  String isScheduled;
  double userRated;
  double providerRated;
  double useWallet;
  int surge;
  String routeKey;
  dynamic nonce;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String staticMap;
  dynamic dispute;
  dynamic lostitem;
  String contactNumber;
  String contactEmail;
  Payment payment;
  ServiceType serviceType;
  User user;
  Provider provider;
  Rating rating;

  factory PastTripDetail.fromRawJson(String str) =>
      PastTripDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PastTripDetail.fromJson(Map<String, dynamic> json) => PastTripDetail(
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
        trackDistance: json["track_distance"] == null
            ? null
            : json["track_distance"].toDouble(),
        trackLatitude: json["track_latitude"] == null
            ? null
            : json["track_latitude"].toDouble(),
        trackLongitude: json["track_longitude"] == null
            ? null
            : json["track_longitude"].toDouble(),
        destinationLog:
            json["destination_log"] == null ? null : json["destination_log"],
        isDropLocation: json["is_drop_location"] == null
            ? null
            : json["is_drop_location"].toDouble(),
        isInstantRide: json["is_instant_ride"] == null
            ? null
            : json["is_instant_ride"].toDouble(),
        isDispute:
            json["is_dispute"] == null ? null : json["is_dispute"].toDouble(),
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
        userRated:
            json["user_rated"] == null ? null : json["user_rated"].toDouble(),
        providerRated: json["provider_rated"] == null
            ? null
            : json["provider_rated"].toDouble(),
        useWallet:
            json["use_wallet"] == null ? null : json["use_wallet"].toDouble(),
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
        staticMap: json["static_map"] == null ? null : json["static_map"],
        dispute: json["dispute"],
        lostitem: json["lostitem"],
        contactNumber:
            json["contact_number"] == null ? null : json["contact_number"],
        contactEmail:
            json["contact_email"] == null ? null : json["contact_email"],
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        serviceType: json["service_type"] == null
            ? null
            : ServiceType.fromJson(json["service_type"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        provider: json["provider"] == null
            ? null
            : Provider.fromJson(json["provider"]),
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
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
        "static_map": staticMap == null ? null : staticMap,
        "dispute": dispute,
        "lostitem": lostitem,
        "contact_number": contactNumber == null ? null : contactNumber,
        "contact_email": contactEmail == null ? null : contactEmail,
        "payment": payment == null ? null : payment.toJson(),
        "service_type": serviceType == null ? null : serviceType.toJson(),
        "user": user == null ? null : user.toJson(),
        "provider": provider == null ? null : provider.toJson(),
        "rating": rating == null ? null : rating.toJson(),
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
  double agentPer;
  double discount;
  double discountPer;
  double tax;
  double taxPer;
  double wallet;
  double isPartial;
  double cash;
  double card;
  double online;
  int surge;
  double tollCharge;
  double roundOf;
  double peakAmount;
  double peakCommAmount;
  double totalWaitingTime;
  double waitingAmount;
  double waitingCommAmount;
  double tips;
  double total;
  double payable;
  double providerCommission;
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
        agentPer:
            json["agent_per"] == null ? null : json["agent_per"].toDouble(),
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
        card: json["card"] == null ? null : json["card"].toDouble(),
        online: json["online"] == null ? null : json["online"].toDouble(),
        surge: json["surge"] == null ? null : json["surge"],
        tollCharge:
            json["toll_charge"] == null ? null : json["toll_charge"].toDouble(),
        roundOf: json["round_of"] == null ? null : json["round_of"].toDouble(),
        peakAmount:
            json["peak_amount"] == null ? null : json["peak_amount"].toDouble(),
        peakCommAmount: json["peak_comm_amount"] == null
            ? null
            : json["peak_comm_amount"].toDouble(),
        totalWaitingTime: json["total_waiting_time"] == null
            ? null
            : json["total_waiting_time"].toDouble(),
        waitingAmount: json["waiting_amount"] == null
            ? null
            : json["waiting_amount"].toDouble(),
        waitingCommAmount: json["waiting_comm_amount"] == null
            ? null
            : json["waiting_comm_amount"].toDouble(),
        tips: json["tips"] == null ? null : json["tips"].toDouble(),
        total: json["total"] == null ? null : json["total"].toDouble(),
        payable: json["payable"] == null ? null : json["payable"].toDouble(),
        providerCommission: json["provider_commission"] == null
            ? null
            : json["provider_commission"].toDouble(),
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
  String referralUniqueId;
  String qrcodeUrl;
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
        referralUniqueId: json["referral_unique_id"] == null
            ? null
            : json["referral_unique_id"],
        qrcodeUrl: json["qrcode_url"] == null ? null : json["qrcode_url"],
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
        "referral_unique_id":
            referralUniqueId == null ? null : referralUniqueId,
        "qrcode_url": qrcodeUrl == null ? null : qrcodeUrl,
        "trial_pro_ends_at": trialProEndsAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
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
  double providerId;
  double userRating;
  double providerRating;
  String userComment;
  String providerComment;

  factory Rating.fromRawJson(String str) => Rating.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"] == null ? null : json["id"],
        requestId: json["request_id"] == null ? null : json["request_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        providerId:
            json["provider_id"] == null ? null : json["provider_id"].toDouble(),
        userRating:
            json["user_rating"] == null ? null : json["user_rating"].toDouble(),
        providerRating: json["provider_rating"] == null
            ? null
            : json["provider_rating"].toDouble(),
        userComment: json["user_comment"] == null ? null : json["user_comment"],
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
        "user_comment": userComment == null ? null : userComment,
        "provider_comment": providerComment == null ? null : providerComment,
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
  double walletBalance;
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
        walletBalance: json["wallet_balance"] == null
            ? null
            : json["wallet_balance"].toDouble(),
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
