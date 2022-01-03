//
// // To parse this JSON data, do
// //
// //     final newOrdersModel = newOrdersModelFromJson(jsonString);
//
// import 'dart:convert';
//
// NewOrdersModel newOrdersModelFromJson(String str) => NewOrdersModel.fromJson(json.decode(str));
//
// String newOrdersModelToJson(NewOrdersModel data) => json.encode(data.toJson());
//
// class NewOrdersModel {
//   NewOrdersModel({
//     this.success,
//     this.message,
//     this.orders,
//   });
//
//   int ?success;
//   String? message;
//   List<NewOrder> ?orders;
//
//   factory NewOrdersModel.fromJson(Map<String, dynamic> json) => NewOrdersModel(
//     success: json["success"],
//     message: json["message"],
//     orders:  json["orders"]  == null ? null : List<NewOrder>.from(json["orders"].map((x) => NewOrder.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
//   };
// }
//
// class NewOrder {
//   NewOrder({
//     this.id,
//     this.uuId,
//     this.userId,
//     this.cartId,
//     this.statusId,
//     this.mailSent,
//     this.canDelete,
//     this.cart,
//     this.user,
//   });
//
//   int? id;
//   String ?uuId;
//   int ?userId;
//   int ?cartId;
//   int ?statusId;
//   int ?mailSent;
//   bool ?canDelete;
//   Cart ?cart;
//   User ?user;
//
//
//   factory NewOrder.fromJson(Map<String, dynamic> json) => NewOrder(
//     id: json["id"],
//     uuId: json["uuId"],
//     userId: json["user_id"],
//     cartId: json["cart_id"],
//     statusId: json["status_id"],
//     mailSent: json["mail_sent"],
//     canDelete: json["can_delete"],
//     cart: Cart.fromJson(json["cart"]),
//     user: User.fromJson(json["user"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "uuId": uuId,
//     "user_id": userId,
//     "cart_id": cartId,
//     "status_id": statusId,
//     "mail_sent": mailSent,
//     "can_delete": canDelete,
//     "cart": cart!.toJson(),
//     "user": user!.toJson(),
//   };
// }
// class User {
//   User({
//     this.id,
//     this.name,
//     this.phone,
//   });
//
//   int ?id;
//   String ?name;
//   String ?phone;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     name: json["name"],
//     phone: json["phone"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "phone": phone,
//   };
// }
//
//
// class Cart {
//   Cart({
//     this.id,
//     this.token,
//     this.addressId,
//     this.paymentType,
//     this.points,
//     this.comment,
//     this.vendor,
//     this.address,
//   });
//
//   int ?id;
//   String? token;
//   int ?addressId;
//   String? paymentType;
//   int ?points;
//   dynamic comment;
//   Vendor ?vendor;
//   Address ?address;
//
//   factory Cart.fromJson(Map<String, dynamic> json) => Cart(
//     id: json["id"]??0,
//     token: json["token"]??"",
//     addressId: json["address_id"]??0,
//     paymentType: json["payment_type"]??"",
//     points: json["points"]??0,
//     comment: json["comment"]??"",
//     vendor: Vendor.fromJson(json["vendor"]),
//     address: json["address"]  == null ? null :Address.fromJson(json["address"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "token": token,
//     "address_id": addressId,
//     "payment_type": paymentType,
//     "points": points,
//     "comment": comment,
//     "vendor": vendor!.toJson(),
//     "address": address!.toJson(),
//   };
// }
//
// class Address {
//   Address({
//     this.id,
//     this.userId,
//     this.cityId,
//     this.regionId,
//     this.address,
//     this.buildingNo,
//     this.floorNo,
//     this.flatNo,
//     this.street,
//     this.lat,
//     this.lng,
//     this.createdAt,
//     this.updatedAt,
//     this.block,
//     this.district,
//     this.company,
//     this.extra,
//     this.linkToGoogleMap,
//     this.city,
//     this.region,
//   });
//
//   int ?id;
//   int ?userId;
//   int ?cityId;
//   int ?regionId;
//   String? address;
//   dynamic buildingNo;
//   dynamic floorNo;
//   dynamic flatNo;
//   dynamic street;
//   String ?lat;
//   String ?lng;
//   String ?createdAt;
//   String ?updatedAt;
//   dynamic block;
//   String ?district;
//   dynamic company;
//   dynamic extra;
//   String ?linkToGoogleMap;
//   dynamic city;
//   dynamic region;
//
//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//     id: json["id"]??0,
//     userId: json["user_id"]??0,
//     cityId: json["city_id"]??0,
//     regionId: json["region_id"]??0,
//     address: json["address"]??"",
//     buildingNo: json["building_no"]??"",
//     floorNo: json["floor_no"]??'',
//     flatNo: json["flat_no"]??"",
//     street: json["street"]??"",
//     lat: json["lat"]??"",
//     lng: json["lng"]??"",
//     createdAt: json["created_at"]??"",
//     updatedAt: json["updated_at"]??"",
//     block: json["block"]??"",
//     district: json["district"]??"",
//     company: json["company"]??"",
//     extra: json["extra"]??"",
//     linkToGoogleMap: json["link_to_google_map"]??"",
//     city: json["city"],
//     region: json["region"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "city_id": cityId,
//     "region_id": regionId,
//     "address": address,
//     "building_no": buildingNo,
//     "floor_no": floorNo,
//     "flat_no": flatNo,
//     "street": street,
//     "lat": lat,
//     "lng": lng,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "block": block,
//     "district": district,
//     "company": company,
//     "extra": extra,
//     "link_to_google_map": linkToGoogleMap,
//     "city": city,
//     "region": region,
//   };
// }
//
// class Vendor {
//   Vendor({
//     this.image,
//     this.updatedAt,
//     this.chatUid,
//     this.lat,
//     this.long,
//     this.userType,
//     this.uid,
//     this.name,
//     this.description,
//   });
//
//   dynamic image;
//   String? updatedAt;
//   String ?chatUid;
//   String ?lat;
//   String ?long;
//   String ?userType;
//   String ?uid;
//   String ?name;
//   String ?description;
//
//   factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
//     image: json["image"]??"",
//     updatedAt: json["updated_at"],
//     chatUid: json["chat_uid"],
//     lat: json["lat"],
//     long: json["long"],
//     userType: json["user_type"],
//     uid: json["uid"],
//     name: json["name"],
//     description: json["description"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "image": image,
//     "updated_at": updatedAt,
//     "chat_uid": chatUid,
//     "lat": lat,
//     "long": long,
//     "user_type": userType,
//     "uid": uid,
//     "name": name,
//     "description": description,
//   };
// }


// To parse this JSON data, do
//
//     final newOrdersModel = newOrdersModelFromJson(jsonString);

import 'dart:convert';

NewOrdersModel newOrdersModelFromJson(String str) => NewOrdersModel.fromJson(json.decode(str));

String newOrdersModelToJson(NewOrdersModel data) => json.encode(data.toJson());

class NewOrdersModel {
  NewOrdersModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int ?currentPage;
  List<NewOrder>? data;
  String ?firstPageUrl;
  int ?from;
  int ?lastPage;
  String ?lastPageUrl;
  dynamic nextPageUrl;
  String ?path;
  int ?perPage;
  dynamic prevPageUrl;
  int ?to;
  int ?total;

  factory NewOrdersModel.fromJson(Map<String, dynamic> json) => NewOrdersModel(
    currentPage: json["current_page"],
    data: json["data"]  == null ? null : List<NewOrder>.from(json["data"].map((x) => NewOrder.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class NewOrder {
  NewOrder({
    this.id,
    this.uuId,
    this.userId,
    this.cartId,
    this.statusId,
    this.mailSent,
    this.canDelete,
    this.cart,
    this.user,
  });

  int ?id;
  String ?uuId;
  int ?userId;
  int ?cartId;
  int ?statusId;
  int ?mailSent;
  bool? canDelete;
  Cart ?cart;
  User ?user;

  factory NewOrder.fromJson(Map<String, dynamic> json) => NewOrder(
    id: json["id"],
    uuId: json["uuId"],
    userId: json["user_id"],
    cartId: json["cart_id"],
    statusId: json["status_id"],
    mailSent: json["mail_sent"],
    canDelete: json["can_delete"],
    cart: Cart.fromJson(json["cart"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuId": uuId,
    "user_id": userId,
    "cart_id": cartId,
    "status_id": statusId,
    "mail_sent": mailSent,
    "can_delete": canDelete,
    "cart": cart!.toJson(),
    "user": user!.toJson(),
  };
}

class Cart {
  Cart({
    this.id,
    this.token,
    this.addressId,
    this.paymentType,
    this.points,
    this.comment,
    this.vendor,
    this.address,
  });

  int? id;
  String ?token;
  int ?addressId;
  String? paymentType;
  int ?points;
  dynamic comment;
  Vendor? vendor;
  Address? address;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"]??0,
    token: json["token"]??"",
    addressId: json["address_id"]??0,
    paymentType: json["payment_type"]??"",
    points: json["points"]??0,
    comment: json["comment"],
    vendor: Vendor.fromJson(json["vendor"]),
    address: json["address"]  == null ? null : Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "address_id": addressId,
    "payment_type": paymentType,
    "points": points,
    "comment": comment,
    "vendor": vendor!.toJson(),
    "address": address!.toJson(),
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

  int? id;
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
    id: json["id"]??0,
    userId: json["user_id"]??0,
    cityId: json["city_id"]??0,
    regionId: json["region_id"]??0,
    address: json["address"]??"",
    buildingNo: json["building_no"],
    floorNo: json["floor_no"],
    flatNo: json["flat_no"],
    street: json["street"],
    lat: json["lat"]??"",
    lng: json["lng"]??"",
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    block: json["block"],
    district: json["district"]??"",
    company: json["company"],
    extra: json["extra"],
    linkToGoogleMap: json["link_to_google_map"]??"",
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

class Vendor {
  Vendor({
    this.image,
    this.updatedAt,
    this.chatUid,
    this.lat,
    this.long,
    this.userType,
    this.uid,
    this.name,
    this.description,
  });

  String? image;
  String? updatedAt;
  String? chatUid;
  String ?lat;
  String ?long;
  String? userType;
  String? uid;
  String? name;
  String ?description;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    image: json["image"] == null ? null : json["image"],
    updatedAt: json["updated_at"]??"",
    chatUid: json["chat_uid"]??"",
    lat: json["lat"]??"",
    long: json["long"]??"",
    userType: json["user_type"]??"",
    uid: json["uid"]??"",
    name: json["name"]??"",
    description: json["description"]??"",
  );

  Map<String, dynamic> toJson() => {
    "image": image == null ? null : image,
    "updated_at": updatedAt,
    "chat_uid": chatUid,
    "lat": lat,
    "long": long,
    "user_type": userType,
    "uid": uid,
    "name": name,
    "description": description,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.phone,
  });

  int ?id;
  String? name;
  String ?phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"]??0,
    name: json["name"]??"",
    phone: json["phone"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
  };
}
