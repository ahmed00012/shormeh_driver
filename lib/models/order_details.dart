// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    this.success,
    this.message,
    this.orders,
  });

  int? success;
  String? message;
  Orders? orders;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    success: json["success"]??-1,
    message: json["message"]??"",
    orders: Orders.fromJson(json["orders"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "orders": orders!.toJson(),
  };
}

class Orders {
  Orders({
    this.id,
    this.uuId,
    this.userId,
    this.cartId,
    this.statusId,
    this.createdAt,
    this.updatedAt,
    this.driverId,
    this.expectedTime,
    this.mailSent,
    this.canDelete,
    this.cart,
  });

  int? id;
  String ?uuId;
  int ?userId;
  int? cartId;
  int ?statusId;
  String? createdAt;
  String ?updatedAt;
  String ?driverId;
  dynamic expectedTime;
  int ?mailSent;
  bool ?canDelete;
  Cart ?cart;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    id: json["id"],
    uuId: json["uuId"],
    userId: json["user_id"],
    cartId: json["cart_id"],
    statusId: json["status_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    driverId: json["driver_id"],
    expectedTime: json["expected_time"],
    mailSent: json["mail_sent"],
    canDelete: json["can_delete"],
    cart: Cart.fromJson(json["cart"]),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuId": uuId,
    "user_id": userId,
    "cart_id": cartId,
    "status_id": statusId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "driver_id": driverId,
    "expected_time": expectedTime,
    "mail_sent": mailSent,
    "can_delete": canDelete,
    "cart": cart!.toJson(),
  };
}

class Cart {
  Cart({
    this.id,
    this.token,
    this.userId,
    this.vendorId,
    this.statusId,
    this.subTotal,
    this.discount,
    this.tax,
    this.total,
    this.quantity,
    this.couponId,
    this.addressId,
    this.paymentType,
    this.deliveryDate,
    this.timeId,
    this.points,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.discountType,
    this.orderMethod,
    this.carId,
    this.branchId,
    this.deliveryFee,
    this.pointsToCash,
    this.items,
    this.coupon,
   // this.status,
    this.time,
    this.vendor,
    this.address,
    this.car,
  });

  int ?id;
  String? token;
  int ?userId;
  int ?vendorId;
  int ?statusId;
  int ?subTotal;
  dynamic discount;
  dynamic ?tax;
  dynamic ?total;
  int ?quantity;
  dynamic couponId;
  dynamic addressId;
  String? paymentType;
  dynamic deliveryDate;
  dynamic timeId;
  int ?points;
  dynamic comment;
  String ?createdAt;
  String ?updatedAt;
  String? discountType;
  String ?orderMethod;
  dynamic carId;
  String? branchId;
  String? deliveryFee;
  int ?pointsToCash;
  List<Item>? items;
  dynamic coupon;
//  CartStatus? status;
  dynamic time;
  Branch ?vendor;
  dynamic address;
  dynamic car;


  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    token: json["token"],
    userId: json["user_id"],
    vendorId: json["vendor_id"],
    statusId: json["status_id"],
    subTotal: json["sub_total"],
    discount: json["discount"],
    tax: json["tax"],
    total: json["total"],
    quantity: json["quantity"],
    couponId: json["coupon_id"],
    addressId: json["address_id"],
    paymentType: json["payment_type"],
    deliveryDate: json["delivery_date"],
    timeId: json["time_id"],
    points: json["points"],
    comment: json["comment"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    discountType: json["discount_type"],
    orderMethod: json["order_method"],
    carId: json["car_id"],
    branchId: json["branch_id"],
    deliveryFee: json["delivery_fee"],
    pointsToCash: json["points_to_cash"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    coupon: json["coupon"],
   // status: CartStatus.fromJson(json["status"]),
    time: json["time"],
    vendor: Branch.fromJson(json["vendor"]),
    address: json["address"],
    car: json["car"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "user_id": userId,
    "vendor_id": vendorId,
    "status_id": statusId,
    "sub_total": subTotal,
    "discount": discount,
    "tax": tax,
    "total": total,
    "quantity": quantity,
    "coupon_id": couponId,
    "address_id": addressId,
    "payment_type": paymentType,
    "delivery_date": deliveryDate,
    "time_id": timeId,
    "points": points,
    "comment": comment,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "discount_type": discountType,
    "order_method": orderMethod,
    "car_id": carId,
    "branch_id": branchId,
    "delivery_fee": deliveryFee,
    "points_to_cash": pointsToCash,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "coupon": coupon,
    "time": time,
    "vendor": vendor!.toJson(),
    "address": address,
    "car": car,
   // "branch": branch!.toJson(),
  };
}

class Branch {
  Branch({
    this.name,
  });

  String ?name;


  factory Branch.fromJson(Map<String, dynamic> json) => Branch(

    name: json["name"],
  );

  Map<String, dynamic> toJson() => {

    "name": name,
  };
}

class City {
  City({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.translations,
    this.cityId,
  });

  int? id;
  String? createdAt;
  String? updatedAt;
  String ?name;
  List<CityTranslation>? translations;
  int ?cityId;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    name: json["name"],
    translations: List<CityTranslation>.from(json["translations"].map((x) => CityTranslation.fromJson(x))),
    cityId: json["city_id"] == null ? null : json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "name": name,
    "translations": List<dynamic>.from(translations!.map((x) => x.toJson())),
    "city_id": cityId == null ? null : cityId,
  };
}

class CityTranslation {
  CityTranslation({
    this.locale,
    this.name,
  });

  String? locale;
  String ?name;

  factory CityTranslation.fromJson(Map<String, dynamic> json) => CityTranslation(
    locale: json["locale"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "locale": locale,
    "name": name,
  };
}

class Method {
  Method({
    this.id,
    this.titleEn,
    this.titleAr,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.pivot,
    this.code,
  });

  int? id;
  String ?titleEn;
  String? titleAr;
  DateTime? createdAt;
  DateTime ?updatedAt;
  String? image;
  Pivot ?pivot;
  String? code;

  factory Method.fromJson(Map<String, dynamic> json) => Method(
    id: json["id"],
    titleEn: json["title_en"],
    titleAr: json["title_ar"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    image: json["image"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title_en": titleEn,
    "title_ar": titleAr,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "image": image,
    "pivot": pivot == null ? null : pivot!.toJson(),
    "code": code == null ? null : code,
  };
}

class Pivot {
  Pivot({
    this.vendorId,
    this.methodId,
  });

  String? vendorId;
  String ?methodId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    vendorId: json["vendor_id"],
    methodId: json["method_id"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "method_id": methodId,
  };
}

class Time {
  Time({
    this.id,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    this.duration,
  });

  int? id;
  String ?startTime;
  String ?endTime;
  String ?createdAt;
  String ?updatedAt;
  String ?duration;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    id: json["id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start_time": startTime,
    "end_time": endTime,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "duration": duration,
  };
}

class BranchTranslation {
  BranchTranslation({
    this.id,
    this.vendorId,
    this.locale,
    this.name,
    this.description,
  });

  int? id;
  int ?vendorId;
  String? locale;
  String ?name;
  dynamic description;

  factory BranchTranslation.fromJson(Map<String, dynamic> json) => BranchTranslation(
    id: json["id"],
    vendorId: json["vendor_id"],
    locale: json["locale"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "locale": locale,
    "name": name,
    "description": description,
  };
}

class Vendordeliverycharge {
  Vendordeliverycharge({
    this.id,
    this.vendorId,
    this.area,
    this.deliveryCharge,
    this.createdAt,
    this.updatedAt,
    this.areaFrom,
  });

  int? id;
  int ?vendorId;
  String ?area;
  String ?deliveryCharge;
  DateTime? createdAt;
  DateTime ?updatedAt;
  dynamic areaFrom;

  factory Vendordeliverycharge.fromJson(Map<String, dynamic> json) => Vendordeliverycharge(
    id: json["id"],
    vendorId: json["vendor_id"],
    area: json["area"],
    deliveryCharge: json["delivery_charge"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    areaFrom: json["area_from"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "area": area,
    "delivery_charge": deliveryCharge,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "area_from": areaFrom,
  };
}

class Item {
  Item({
    this.id,
    this.cartId,
    this.productId,
    this.hasGiftCard,
    this.hasPersonalName,
    this.subTotal,
    this.total,
    this.count,
    this.weightId,
    this.createdAt,
    this.updatedAt,
    this.note,
    this.price,
    this.productName,
    this.productImage,
    this.weight,
    this.cartitemaddon,
    this.cartitemoption,
  });

  int? id;
  int ?cartId;
  int ?productId;
  int ?hasGiftCard;
  int ?hasPersonalName;
  int ?subTotal;
  int ?total;
  int ?count;
  dynamic weightId;
  String? createdAt;
  String ?updatedAt;
  dynamic note;
  String ?price;
  String ?productName;
  String ?productImage;
  dynamic weight;
  List<Cartitemaddon>? cartitemaddon;
  List<Cartitemoption> ?cartitemoption;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    cartId: json["cart_id"],
    productId: json["product_id"],
    hasGiftCard: json["has_gift_card"],
    hasPersonalName: json["has_personal_name"],
    subTotal: json["sub_total"],
    total: json["total"],
    count: json["count"],
    weightId: json["weight_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    note: json["note"],
    price: json["price"],
    productName: json["product_name"],
    productImage: json["product_image"],
    weight: json["weight"],
    cartitemaddon:  json["cartitemaddon"]  == null ? null :List<Cartitemaddon>.from(json["cartitemaddon"].map((x) => Cartitemaddon.fromJson(x))),
    cartitemoption:  json["cartitemoption"]  == null ? null : List<Cartitemoption>.from(json["cartitemoption"].map((x) => Cartitemoption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart_id": cartId,
    "product_id": productId,
    "has_gift_card": hasGiftCard,
    "has_personal_name": hasPersonalName,
    "sub_total": subTotal,
    "total": total,
    "count": count,
    "weight_id": weightId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "note": note,
    "price": price,
    "product_name": productName,
    "product_image": productImage,
    "weight": weight,
    "cartitemaddon": List<dynamic>.from(cartitemaddon!.map((x) => x.toJson())),
    "cartitemoption": List<dynamic>.from(cartitemoption!.map((x) => x)),
  };
}

class Cartitemoption {
  Cartitemoption({
    this.id,
    this.productId,
    this.cartItemId,
    this.optionId,
    this.optionValueId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.option,
    this.optionvalue,
  });

  int ?id;
  int ?productId;
  int ?cartItemId;
  int ?optionId;
  int ?optionValueId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Option ?option;
  Optionvalue ?optionvalue;

  factory Cartitemoption.fromJson(Map<String, dynamic> json) => Cartitemoption(
    id: json["id"],
    productId: json["product_id"],
    cartItemId: json["cart_item_id"],
    optionId: json["option_id"],
    optionValueId: json["option_value_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    option: Option.fromJson(json["option"]),
    optionvalue: Optionvalue.fromJson(json["optionvalue"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "cart_item_id": cartItemId,
    "option_id": optionId,
    "option_value_id": optionValueId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "option": option!.toJson(),
    "optionvalue": optionvalue!.toJson(),
  };
}

class Option {
  Option({
    this.id,
    this.nameEn,
    this.nameAr,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int ?id;
  String? nameEn;
  String ?nameAr;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  dynamic deletedAt;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    nameEn: json["name_en"],
    nameAr: json["name_ar"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_en": nameEn,
    "name_ar": nameAr,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Optionvalue {
  Optionvalue({
    this.id,
    this.optionId,
    this.valueEn,
    this.valueAr,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.nameEn,
    this.nameAr,
  });

  int ?id;
  int ?optionId;
  String? valueEn;
  String? valueAr;
  dynamic image;
  DateTime? createdAt;
  DateTime ?updatedAt;
  dynamic deletedAt;
  String ?nameEn;
  String ?nameAr;

  factory Optionvalue.fromJson(Map<String, dynamic> json) => Optionvalue(
    id: json["id"],
    optionId: json["option_id"],
    valueEn: json["value_en"],
    valueAr: json["value_ar"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    nameEn: json["name_en"],
    nameAr: json["name_ar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "option_id": optionId,
    "value_en": valueEn,
    "value_ar": valueAr,
    "image": image,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "name_en": nameEn,
    "name_ar": nameAr,
  };
}
class Cartitemaddon {
  Cartitemaddon({
    this.id,
    this.productId,
    this.cartItemId,
    this.addonId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.addon,
  });

  int? id;
  int? productId;
  int ?cartItemId;
  int ?addonId;
  DateTime? createdAt;
  DateTime ?updatedAt;
  dynamic deletedAt;
  Addon ?addon;

  factory Cartitemaddon.fromJson(Map<String, dynamic> json) => Cartitemaddon(
    id: json["id"],
    productId: json["product_id"],
    cartItemId: json["cart_item_id"],
    addonId: json["addon_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    addon: Addon.fromJson(json["addon"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "cart_item_id": cartItemId,
    "addon_id": addonId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "addon": addon!.toJson(),
  };
}

class Addon {
  Addon({
    this.id,
    this.nameEn,
    this.nameAr,
    this.price,
    this.image,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? nameEn;
  String ?nameAr;
  String ?price;
  dynamic image;
  int ?isActive;
  DateTime? createdAt;
  DateTime ?updatedAt;
  dynamic deletedAt;

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
    id: json["id"],
    nameEn: json["name_en"],
    nameAr: json["name_ar"],
    price: json["price"],
    image: json["image"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_en": nameEn,
    "name_ar": nameAr,
    "price": price,
    "image": image,
    "is_active": isActive,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class CartStatus {
  CartStatus({
    this.id,
    this.name,
  });

  int? id;
  String ?name;

  factory CartStatus.fromJson(Map<String, dynamic> json) => CartStatus(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Driver {
  Driver({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.nationalId,
    this.licenceId,
    this.vechType,
    this.nationality,
    this.employment,
    this.isFree,
    this.status,
    this.vendorId,
    this.createdAt,
    this.updatedAt,
    this.deviceId,
    this.lastLat,
    this.lastLong,
    this.licence,
    this.estamara,
    this.userType,
  });

  int? id;
  String ?firstName;
  String? lastName;
  String? phone;
  String? nationalId;
  String ?licenceId;
  String ?vechType;
  String ?nationality;
  String ?employment;
  String ?isFree;
  String ?status;
  String ?vendorId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String ?deviceId;
  dynamic lastLat;
  dynamic lastLong;
  String ?licence;
  String ?estamara;
  String ?userType;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    nationalId: json["national_id"],
    licenceId: json["licence_id"],
    vechType: json["vech_type"],
    nationality: json["nationality"],
    employment: json["employment"],
    isFree: json["is_free"],
    status: json["status"],
    vendorId: json["vendor_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deviceId: json["device_id"],
    lastLat: json["last_lat"],
    lastLong: json["last_long"],
    licence: json["licence"],
    estamara: json["estamara"],
    userType: json["user_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "national_id": nationalId,
    "licence_id": licenceId,
    "vech_type": vechType,
    "nationality": nationality,
    "employment": employment,
    "is_free": isFree,
    "status": status,
    "vendor_id": vendorId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "device_id": deviceId,
    "last_lat": lastLat,
    "last_long": lastLong,
    "licence": licence,
    "estamara": estamara,
    "user_type": userType,
  };
}

class OrdersStatus {
  OrdersStatus({
    this.id,
    this.name,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.orderMethodId,
  });

  int? id;
  String? name;
  String ?nameEn;
  String ?createdAt;
  DateTime? updatedAt;
  String ?image;
  String ?orderMethodId;

  factory OrdersStatus.fromJson(Map<String, dynamic> json) => OrdersStatus(
    id: json["id"],
    name: json["name"],
    nameEn: json["name_en"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    image: json["image"],
    orderMethodId: json["order_method_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_en": nameEn,
    "created_at": createdAt,
    "updated_at": updatedAt!.toIso8601String(),
    "image": image,
    "order_method_id": orderMethodId,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.isActive,
    this.userGroupId,
    this.deviceId,
    this.chatUid,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.balance,
    this.totalPoints,
    this.pointsToCash,
    this.userType,
    this.uid,
    this.addresses,
    this.points,
  });

  int? id;
  String? name;
  String ?email;
  String ?phone;
  int ?isActive;
  int ?userGroupId;
  String ?deviceId;
  dynamic chatUid;
  dynamic emailVerifiedAt;
  String ?createdAt;
  String ?updatedAt;
  String ?balance;
  int ?totalPoints;
  int ?pointsToCash;
  String ?userType;
  dynamic uid;
  List<Address>? addresses;
  List<Point> ?points;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    isActive: json["is_active"],
    userGroupId: json["user_group_id"],
    deviceId: json["device_id"],
    chatUid: json["chat_uid"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    balance: json["balance"],
    totalPoints: json["total_points"],
    pointsToCash: json["points_to_cash"],
    userType: json["user_type"],
    uid: json["uid"],
    addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    points: List<Point>.from(json["points"].map((x) => Point.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "is_active": isActive,
    "user_group_id": userGroupId,
    "device_id": deviceId,
    "chat_uid": chatUid,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "balance": balance,
    "total_points": totalPoints,
    "points_to_cash": pointsToCash,
    "user_type": userType,
    "uid": uid,
    "addresses": List<dynamic>.from(addresses!.map((x) => x.toJson())),
    "points": List<dynamic>.from(points!.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.id,
    this.userId,
    this.cityId,
    this.regionId,
    this.address,
    this.buildingNo,
    this.floorNo,
    this.flatNo,
    this.street,
    this.lat,
    this.lng,
    this.createdAt,
    this.updatedAt,
    this.block,
    this.district,
    this.company,
    this.extra,
    this.linkToGoogleMap,
    this.city,
    this.region,
  });

  int ?id;
  int ?userId;
  int ?cityId;
  int ?regionId;
  String ?address;
  dynamic buildingNo;
  dynamic floorNo;
  dynamic flatNo;
  dynamic street;
  String ?lat;
  String ?lng;
  String ?createdAt;
  String ?updatedAt;
  dynamic block;
  String ?district;
  dynamic company;
  dynamic extra;
  String ?linkToGoogleMap;
  dynamic city;
  dynamic region;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    userId: json["user_id"],
    cityId: json["city_id"],
    regionId: json["region_id"],
    address: json["address"],
    buildingNo: json["building_no"],
    floorNo: json["floor_no"],
    flatNo: json["flat_no"],
    street: json["street"],
    lat: json["lat"],
    lng: json["lng"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    block: json["block"],
    district: json["district"],
    company: json["company"],
    extra: json["extra"],
    linkToGoogleMap: json["link_to_google_map"],
    city: json["city"],
    region: json["region"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "city_id": cityId,
    "region_id": regionId,
    "address": address,
    "building_no": buildingNo,
    "floor_no": floorNo,
    "flat_no": flatNo,
    "street": street,
    "lat": lat,
    "lng": lng,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "block": block,
    "district": district,
    "company": company,
    "extra": extra,
    "link_to_google_map": linkToGoogleMap,
    "city": city,
    "region": region,
  };
}

class Point {
  Point({
    this.id,
    this.userId,
    this.daysToExpired,
    this.orderId,
    this.expireAt,
    this.points,
    this.createdAt,
    this.updatedAt,
    this.converted,
  });

  int? id;
  int ?userId;
  int ?daysToExpired;
  int ?orderId;
  DateTime? expireAt;
  int ?points;
  String? createdAt;
  String? updatedAt;
  int ?converted;

  factory Point.fromJson(Map<String, dynamic> json) => Point(
    id: json["id"],
    userId: json["user_id"],
    daysToExpired: json["days_to_expired"],
    orderId: json["order_id"],
    expireAt: DateTime.parse(json["expire_at"]),
    points: json["points"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    converted: json["converted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "days_to_expired": daysToExpired,
    "order_id": orderId,
    "expire_at": "${expireAt!.year.toString().padLeft(4, '0')}-${expireAt!.month.toString().padLeft(2, '0')}-${expireAt!.day.toString().padLeft(2, '0')}",
    "points": points,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "converted": converted,
  };
}
