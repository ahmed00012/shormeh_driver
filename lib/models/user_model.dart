import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  UserModel({
     this.success,
     this.accessToken,
     this.tokenType,
     this.firstName,
     this.lastName,
     this.status,
    this.email,
     this.phone,
     this.nationalId,
     this.licenceId,
     this.vechType,
     this.nationality,
     this.employment,
    this.vendor_en,
     this.vendor,
  });
 String ?success;
 String ?accessToken;
 String ?tokenType;
 String ?firstName;
 String ?lastName;
 String ?status;
 String? email;
 String? phone;
 String ?nationalId;
 String ?licenceId;
 String ?vechType;
 String ?nationality;
 String ?employment;
 String ?vendor_en;
 String ? vendor_ar;
 Vendor? vendor;

  UserModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    accessToken = json['access_token'];
    if (json['access_token'] != null) saveToken(json['access_token']);
    tokenType = json['token_type'];
    firstName = json['first_name'];
    if (json['first_name'] != null) saveFirstName(json['first_name']);
    lastName = json['last_name'];
    if (json['last_name'] != null) saveLastName(json['last_name']);
    status = json['status'];
    if (json['status'] != null) saveStatus(json['status']);
    email = json['email']??"";
    phone = json['phone'];
    nationalId = json['national_id'];
    licenceId = json['licence_id'];
    vechType = json['vech_type'];
    nationality = json['nationality'];
    employment = json['employment'];
    vendor_en = json['vendor_en'];
    if (json['vendor_en'] != null) saveVendorNameEn(json['vendor_en']);
    vendor_ar = json['vendor_ar'];
    if (json['vendor_ar'] != null) saveVendorNameAr(json['vendor_ar']);
    vendor = Vendor.fromJson(json['vendor']);
  }
  Future<void> saveStatus(String status) async {
    this.status = status;
    print("$status");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('status', status);
  }
  Future<void> saveFirstName(String fName) async {
    this.firstName = fName;
    print("$fName");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fName', fName);
  }
  Future<void> saveLastName(String lName) async {
    this.lastName = lName;
    print("$lName");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lName', lName);
  }
  Future<void> saveVendorNameEn(String name) async {
    this.vendor_en = name;
    print("$name");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('vendor_name_en', name);
  }
  Future<void> saveVendorNameAr(String name) async {
    this.vendor_ar = name;
    print("$name");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('vendor_name_ar', name);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['access_token'] = accessToken;
    _data['token_type'] = tokenType;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['status'] = status;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['national_id'] = nationalId;
    _data['licence_id'] = licenceId;
    _data['vech_type'] = vechType;
    _data['nationality'] = nationality;
    _data['employment'] = employment;
    _data['vendor_en'] = vendor_en;
    _data['vendor_ar'] = vendor_ar;
    _data['vendor'] = vendor?.toJson();
    return _data;
  }

  Future<void> resetUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("access_token");
    await prefs.clear();
  }

  Future<void> saveToken(String token) async {
    this.accessToken = token;
    print("$token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', 'Bearer $token');
  }

  Future<String?> get getToken async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('get token');
    print(prefs.getString('access_token'));
    return prefs.getString('access_token');
  }

  Future<bool> get isLoggedIn async {
    // if token found , user loggedIn,
    return await getToken != null;
  }

  get isLogging async {
    // if token found , user loggedIn,
    return await getToken != null;
  }
}

class Vendor {
  Vendor({
     this.id,
     this.phone,
     this.email,
     this.deliveryFee,
     this.isActive,
     this.cityId,
     this.regionId,
    this.image,
     this.vendorRate,
     this.tasteRate,
     this.priceRate,
    this.deviceId,
    this.emailVerifiedAt,
    this.createdAt,
     this.updatedAt,
     this.chatUid,
     this.lat,
     this.long,
     this.userType,
     this.uid,
     this.name,
    this.description,
     this.city,
     this.region,
     this.times,
     this.ordermethod,
     this.vendordeliverycharges,
     this.translations,
  });
   int ?id;
  String? phone;
   String? email;
   int ?deliveryFee;
   int? isActive;
   int ?cityId;
   int ?regionId;
   String? image;
   String ?vendorRate;
   String ?tasteRate;
   String? priceRate;
  String? deviceId;
   String? emailVerifiedAt;
   String ?createdAt;
   String? updatedAt;
   String ?chatUid;
   String ?lat;
   String ?long;
   String ?userType;
   String ?uid;
   String ?name;
  String? description;
   City ?city;
   Region ?region;
   List<Times>? times;
   List<Ordermethod>? ordermethod;
   List<Vendordeliverycharges>? vendordeliverycharges;
   List<Translations> ?translations;

  Vendor.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    phone = json['phone'];
    email = json['email'];
    deliveryFee = json['delivery_fee'];
    isActive = json['is_active'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    image = json['image']??"";
    vendorRate = json['vendor_rate'];
    tasteRate = json['taste_rate'];
    priceRate = json['price_rate'];
    deviceId = json['device_id'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    chatUid = json['chat_uid'];
    lat = json['lat'];
    long = json['long'];
    userType = json['user_type'];
    uid = json['uid'];
    name = json['name']??"";
    description = json['description']??"";
    city = City.fromJson(json['city']);
    region = Region.fromJson(json['region']);
    times = List.from(json['times']).map((e)=>Times.fromJson(e)).toList();
    ordermethod = List.from(json['ordermethod']).map((e)=>Ordermethod.fromJson(e)).toList();
    vendordeliverycharges = List.from(json['vendordeliverycharges']).map((e)=>Vendordeliverycharges.fromJson(e)).toList();
    translations = List.from(json['translations']).map((e)=>Translations.fromJson(e)).toList();
  }


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['delivery_fee'] = deliveryFee;
    _data['is_active'] = isActive;
    _data['city_id'] = cityId;
    _data['region_id'] = regionId;
    _data['image'] = image;
    _data['vendor_rate'] = vendorRate;
    _data['taste_rate'] = tasteRate;
    _data['price_rate'] = priceRate;
    _data['device_id'] = deviceId;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['chat_uid'] = chatUid;
    _data['lat'] = lat;
    _data['long'] = long;
    _data['user_type'] = userType;
    _data['uid'] = uid;
    _data['name'] = name;
    _data['description'] = description;
    _data['city'] = city!.toJson();
    _data['region'] = region!.toJson();
    _data['times'] = times!.map((e)=>e.toJson()).toList();
    _data['ordermethod'] = ordermethod!.map((e)=>e.toJson()).toList();
    _data['vendordeliverycharges'] = vendordeliverycharges!.map((e)=>e.toJson()).toList();
    _data['translations'] = translations!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class City {
  City({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.translations,
  });
  late final int id;
  late final String createdAt;
  late final String updatedAt;
  late final String name;
  late final List<Translations> translations;

  City.fromJson(Map<String, dynamic> json){
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    translations = List.from(json['translations']).map((e)=>Translations.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['name'] = name;
    _data['translations'] = translations.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Translations {
  Translations({
    required this.locale,
    required this.name,
  });
  late final String locale;
  late final String name;

  Translations.fromJson(Map<String, dynamic> json){
    locale = json['locale'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['locale'] = locale;
    _data['name'] = name;
    return _data;
  }
}

class Region {
  Region({
    required this.id,
    required this.cityId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.translations,
  });
  late final int id;
  late final int cityId;
  late final String createdAt;
  late final String updatedAt;
  late final String name;
  late final List<Translations> translations;

  Region.fromJson(Map<String, dynamic> json){
    id = json['id'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    translations = List.from(json['translations']).map((e)=>Translations.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['city_id'] = cityId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['name'] = name;
    _data['translations'] = translations.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Times {
  Times({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.duration,
  });
  late final int id;
  late final String startTime;
  late final String endTime;
  late final String createdAt;
  late final String updatedAt;
  late final String duration;

  Times.fromJson(Map<String, dynamic> json){
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['duration'] = duration;
    return _data;
  }
}

class Ordermethod {
  Ordermethod({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.pivot,
  });
  late final int id;
  late final String titleEn;
  late final String titleAr;
  late final String createdAt;
  late final String updatedAt;
  late final String image;
  late final Pivot pivot;

  Ordermethod.fromJson(Map<String, dynamic> json){
    id = json['id'];
    titleEn = json['title_en'];
    titleAr = json['title_ar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    pivot = Pivot.fromJson(json['pivot']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title_en'] = titleEn;
    _data['title_ar'] = titleAr;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['image'] = image;
    _data['pivot'] = pivot.toJson();
    return _data;
  }
}

class Pivot {
  Pivot({
    required this.vendorId,
    required this.methodId,
  });
  late final String vendorId;
  late final String methodId;

  Pivot.fromJson(Map<String, dynamic> json){
    vendorId = json['vendor_id'];
    methodId = json['method_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['vendor_id'] = vendorId;
    _data['method_id'] = methodId;
    return _data;
  }
}

class Vendordeliverycharges {
  Vendordeliverycharges({
    required this.id,
    required this.vendorId,
    required this.area,
    required this.deliveryCharge,
    required this.createdAt,
    required this.updatedAt,
    this.areaFrom,
  });
  late final int id;
  late final int vendorId;
  late final String area;
  late final String deliveryCharge;
  late final String createdAt;
  late final String updatedAt;
  String? areaFrom;

  Vendordeliverycharges.fromJson(Map<String, dynamic> json){
    id = json['id'];
    vendorId = json['vendor_id'];
    area = json['area'];
    deliveryCharge = json['delivery_charge'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    areaFrom = json['area_from'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['vendor_id'] = vendorId;
    _data['area'] = area;
    _data['delivery_charge'] = deliveryCharge;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['area_from'] = areaFrom;
    return _data;
  }
}