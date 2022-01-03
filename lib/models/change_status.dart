

class StatusModel {
  StatusModel({
     this.success,
     this.message,
     this.driver,
  });
  int? success;
   String? message;
   Driver? driver;

  StatusModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    driver = Driver.fromJson(json['driver']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['driver'] = driver!.toJson();
    return _data;
  }
}

class Driver {
  Driver({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.nationalId,
    required this.licenceId,
    required this.vechType,
    required this.nationality,
    required this.employment,
    required this.isFree,
     this.status,
    required this.vendorId,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    this.lastLat,
    this.lastLong,
    required this.licence,
    required this.estamara,
    required this.userType,
  });
  late final int ?id;
  late final String? firstName;
  late final String ?lastName;
  late final String ?phone;
  late final String nationalId;
  late final String licenceId;
  late final String vechType;
  late final String nationality;
  late final String employment;
  late final String isFree;
   int? status;
  late final String ?vendorId;
  late final String ?createdAt;
  late final String ?updatedAt;
  late final String? deviceId;
  late final String ?lastLat;
  late final String? lastLong;
  late final String? licence;
  late final String? estamara;
  late final String ?userType;

  Driver.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    firstName = json['first_name']??"";
    lastName = json['last_name']??"";
    phone = json['phone']??"";
    nationalId = json['national_id']??"";
    licenceId = json['licence_id']??"";
    vechType = json['vech_type']??"";
    nationality = json['nationality']??"";
    employment = json['employment']??"";
    isFree = json['is_free']??"";
    status = json['status']??"";
    vendorId = json['vendor_id']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    deviceId = json['device_id']??"";
    lastLat = json['last_lat']??"";
    lastLong = json['last_long']??"";
    licence = json['licence']??"";
    estamara = json['estamara']??"";
    userType = json['user_type']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['phone'] = phone;
    _data['national_id'] = nationalId;
    _data['licence_id'] = licenceId;
    _data['vech_type'] = vechType;
    _data['nationality'] = nationality;
    _data['employment'] = employment;
    _data['is_free'] = isFree;
    _data['status'] = status;
    _data['vendor_id'] = vendorId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['device_id'] = deviceId;
    _data['last_lat'] = lastLat;
    _data['last_long'] = lastLong;
    _data['licence'] = licence;
    _data['estamara'] = estamara;
    _data['user_type'] = userType;
    return _data;
  }
}