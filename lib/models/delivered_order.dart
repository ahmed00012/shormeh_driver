class DeliveredOrder {
  DeliveredOrder({
     this.success,
     this.message,
     this.orders,
  });
   int? success;
   String ?message;
   Orders ?orders;

  DeliveredOrder.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    orders = Orders.fromJson(json['orders']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['orders'] = orders!.toJson();
    return _data;
  }
}

class Orders {
  Orders({
    required this.id,
    required this.uuId,
    required this.userId,
    required this.cartId,
    required this.statusId,
    required this.createdAt,
    required this.updatedAt,
    required this.driverId,
    this.expectedTime,
    required this.mailSent,
    required this.canDelete,
    required this.cart,
    required this.status,
    required this.user,
    required this.driver,
  });
  late final int id;
  late final String uuId;
  late final int userId;
  late final int cartId;
  late final int statusId;
  late final String createdAt;
  late final String updatedAt;
  late final String driverId;
  late final Null expectedTime;
  late final int mailSent;
  late final bool canDelete;
  late final Cart cart;
  late final Status status;
  late final User user;
  late final Driver driver;

  Orders.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uuId = json['uuId'];
    userId = json['user_id'];
    cartId = json['cart_id'];
    statusId = json['status_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    driverId = json['driver_id'];
    expectedTime = json['expected_time'];
    mailSent = json['mail_sent'];
    canDelete = json['can_delete'];
    cart = Cart.fromJson(json['cart']);
    status = Status.fromJson(json['status']);
    user = User.fromJson(json['user']);
    driver = Driver.fromJson(json['driver']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuId'] = uuId;
    _data['user_id'] = userId;
    _data['cart_id'] = cartId;
    _data['status_id'] = statusId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['driver_id'] = driverId;
    _data['expected_time'] = expectedTime;
    _data['mail_sent'] = mailSent;
    _data['can_delete'] = canDelete;
    _data['cart'] = cart.toJson();
    _data['status'] = status.toJson();
    _data['user'] = user.toJson();
    _data['driver'] = driver.toJson();
    return _data;
  }
}

class Cart {
  Cart({
    required this.id,
    required this.token,
    required this.userId,
    required this.vendorId,
    required this.statusId,
    required this.subTotal,
    this.discount,
    required this.tax,
    required this.total,
    required this.quantity,
    this.couponId,
    this.addressId,
    required this.paymentType,
    this.deliveryDate,
    this.timeId,
    required this.points,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.discountType,
    required this.orderMethod,
    this.carId,
    required this.branchId,
    required this.deliveryFee,
    required this.pointsToCash,
    required this.items,
    this.coupon,
    required this.status,
    this.time,
    required this.vendor,
    this.address,
    required this.ordermethod,
    this.car,
    required this.branch,
    required this.paymentmethod,
  });
  late final int id;
  late final String token;
  late final int userId;
  late final int vendorId;
  late final int statusId;
  late final int subTotal;
  late final Null discount;
  late final int tax;
  late final int total;
  late final int quantity;
  late final Null couponId;
  late final Null addressId;
  late final String paymentType;
  late final Null deliveryDate;
  late final Null timeId;
  late final int points;
  late final Null comment;
  late final String createdAt;
  late final String updatedAt;
  late final String discountType;
  late final String orderMethod;
  late final Null carId;
  late final String branchId;
  late final String deliveryFee;
  late final int pointsToCash;
  late final List<Items> items;
  late final Null coupon;
  late final Status status;
  late final Null time;
  late final Vendor vendor;
  late final Null address;
  late final Ordermethod ordermethod;
  late final Null car;
  late final Branch branch;
  late final Paymentmethod paymentmethod;

  Cart.fromJson(Map<String, dynamic> json){
    id = json['id'];
    token = json['token'];
    userId = json['user_id'];
    vendorId = json['vendor_id'];
    statusId = json['status_id'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    tax = json['tax'];
    total = json['total'];
    quantity = json['quantity'];
    couponId = json['coupon_id'];
    addressId = json['address_id'];
    paymentType = json['payment_type'];
    deliveryDate = json['delivery_date'];
    timeId = json['time_id'];
    points = json['points'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discountType = json['discount_type'];
    orderMethod = json['order_method'];
    carId = json['car_id'];
    branchId = json['branch_id'];
    deliveryFee = json['delivery_fee'];
    pointsToCash = json['points_to_cash'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
    coupon = json['coupon'];
    status = Status.fromJson(json['status']);
    time = json['time'];
    vendor = Vendor.fromJson(json['vendor']);
    address = json['address'];
    ordermethod = Ordermethod.fromJson(json['ordermethod']);
    car = json['car'];
    branch = Branch.fromJson(json['branch']);
    paymentmethod = Paymentmethod.fromJson(json['paymentmethod']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['token'] = token;
    _data['user_id'] = userId;
    _data['vendor_id'] = vendorId;
    _data['status_id'] = statusId;
    _data['sub_total'] = subTotal;
    _data['discount'] = discount;
    _data['tax'] = tax;
    _data['total'] = total;
    _data['quantity'] = quantity;
    _data['coupon_id'] = couponId;
    _data['address_id'] = addressId;
    _data['payment_type'] = paymentType;
    _data['delivery_date'] = deliveryDate;
    _data['time_id'] = timeId;
    _data['points'] = points;
    _data['comment'] = comment;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['discount_type'] = discountType;
    _data['order_method'] = orderMethod;
    _data['car_id'] = carId;
    _data['branch_id'] = branchId;
    _data['delivery_fee'] = deliveryFee;
    _data['points_to_cash'] = pointsToCash;
    _data['items'] = items.map((e)=>e.toJson()).toList();
    _data['coupon'] = coupon;
    _data['status'] = status.toJson();
    _data['time'] = time;
    _data['vendor'] = vendor.toJson();
    _data['address'] = address;
    _data['ordermethod'] = ordermethod.toJson();
    _data['car'] = car;
    _data['branch'] = branch.toJson();
    _data['paymentmethod'] = paymentmethod.toJson();
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.hasGiftCard,
    required this.hasPersonalName,
    required this.subTotal,
    required this.total,
    required this.count,
    this.weightId,
    required this.createdAt,
    required this.updatedAt,
    this.note,
    required this.price,
    required this.productName,
    required this.productImage,
    this.weight,
    required this.cartitemaddon,
    required this.cartitemoption,
  });
  late final int id;
  late final int cartId;
  late final int productId;
  late final int hasGiftCard;
  late final int hasPersonalName;
  late final int subTotal;
  late final int total;
  late final int count;
  late final Null weightId;
  late final String createdAt;
  late final String updatedAt;
  late final Null note;
  late final String price;
  late final String productName;
  late final String productImage;
  late final Null weight;
  late final List<dynamic> cartitemaddon;
  late final List<dynamic> cartitemoption;

  Items.fromJson(Map<String, dynamic> json){
    id = json['id'];
    cartId = json['cart_id'];
    productId = json['product_id'];
    hasGiftCard = json['has_gift_card'];
    hasPersonalName = json['has_personal_name'];
    subTotal = json['sub_total'];
    total = json['total'];
    count = json['count'];
    weightId = json['weight_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    note = json['note'];
    price = json['price'];
    productName = json['product_name'];
    productImage = json['product_image'];
    weight = json['weight'];
    cartitemaddon = List.castFrom<dynamic, dynamic>(json['cartitemaddon']);
    cartitemoption = List.castFrom<dynamic, dynamic>(json['cartitemoption']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['cart_id'] = cartId;
    _data['product_id'] = productId;
    _data['has_gift_card'] = hasGiftCard;
    _data['has_personal_name'] = hasPersonalName;
    _data['sub_total'] = subTotal;
    _data['total'] = total;
    _data['count'] = count;
    _data['weight_id'] = weightId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['note'] = note;
    _data['price'] = price;
    _data['product_name'] = productName;
    _data['product_image'] = productImage;
    _data['weight'] = weight;
    _data['cartitemaddon'] = cartitemaddon;
    _data['cartitemoption'] = cartitemoption;
    return _data;
  }
}

class Status {
  Status({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Status.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class Vendor {
  Vendor({
    required this.id,
    required this.phone,
    required this.email,
    required this.deliveryFee,
    required this.isActive,
    required this.cityId,
    required this.regionId,
    this.image,
    required this.vendorRate,
    required this.tasteRate,
    required this.priceRate,
    this.deviceId,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.chatUid,
    required this.lat,
    required this.long,
    required this.userType,
    required this.uid,
    required this.name,
    this.description,
    required this.city,
    required this.region,
    required this.times,
    required this.ordermethod,
    required this.vendordeliverycharges,
    required this.translations,
  });
  late final int id;
  late final String phone;
  late final String email;
  late final int deliveryFee;
  late final int isActive;
  late final int cityId;
  late final int regionId;
  late final Null image;
  late final String vendorRate;
  late final String tasteRate;
  late final String priceRate;
  late final Null deviceId;
  late final Null emailVerifiedAt;
  late final String createdAt;
  late final String updatedAt;
  late final String chatUid;
  late final String lat;
  late final String long;
  late final String userType;
  late final String uid;
  late final String name;
  late final Null description;
  late final City city;
  late final Region region;
  late final List<Times> times;
  late final List<Ordermethod> ordermethod;
  late final List<Vendordeliverycharges> vendordeliverycharges;
  late final List<Translations> translations;

  Vendor.fromJson(Map<String, dynamic> json){
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    deliveryFee = json['delivery_fee'];
    isActive = json['is_active'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    image = json['image'];
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
    name = json['name'];
    description = json['description'];
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
    _data['city'] = city.toJson();
    _data['region'] = region.toJson();
    _data['times'] = times.map((e)=>e.toJson()).toList();
    _data['ordermethod'] = ordermethod.map((e)=>e.toJson()).toList();
    _data['vendordeliverycharges'] = vendordeliverycharges.map((e)=>e.toJson()).toList();
    _data['translations'] = translations.map((e)=>e.toJson()).toList();
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
  late final Null areaFrom;

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

class Branch {
  Branch({
    required this.id,
    required this.phone,
    required this.email,
    required this.deliveryFee,
    required this.isActive,
    required this.cityId,
    required this.regionId,
    this.image,
    required this.vendorRate,
    required this.tasteRate,
    required this.priceRate,
    this.deviceId,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.chatUid,
    required this.lat,
    required this.long,
    required this.userType,
    required this.uid,
    required this.name,
    this.description,
    required this.city,
    required this.region,
    required this.times,
    required this.ordermethod,
    required this.vendordeliverycharges,
    required this.translations,
  });
  late final int id;
  late final String phone;
  late final String email;
  late final int deliveryFee;
  late final int isActive;
  late final int cityId;
  late final int regionId;
  late final Null image;
  late final String vendorRate;
  late final String tasteRate;
  late final String priceRate;
  late final Null deviceId;
  late final Null emailVerifiedAt;
  late final String createdAt;
  late final String updatedAt;
  late final String chatUid;
  late final String lat;
  late final String long;
  late final String userType;
  late final String uid;
  late final String name;
  late final Null description;
  late final City city;
  late final Region region;
  late final List<Times> times;
  late final List<Ordermethod> ordermethod;
  late final List<Vendordeliverycharges> vendordeliverycharges;
  late final List<Translations> translations;

  Branch.fromJson(Map<String, dynamic> json){
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    deliveryFee = json['delivery_fee'];
    isActive = json['is_active'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    image = json['image'];
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
    name = json['name'];
    description = json['description'];
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
    _data['city'] = city.toJson();
    _data['region'] = region.toJson();
    _data['times'] = times.map((e)=>e.toJson()).toList();
    _data['ordermethod'] = ordermethod.map((e)=>e.toJson()).toList();
    _data['vendordeliverycharges'] = vendordeliverycharges.map((e)=>e.toJson()).toList();
    _data['translations'] = translations.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Paymentmethod {
  Paymentmethod({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
  });
  late final int id;
  late final String titleEn;
  late final String titleAr;
  late final String image;
  late final String createdAt;
  late final String updatedAt;
  late final String code;

  Paymentmethod.fromJson(Map<String, dynamic> json){
    id = json['id'];
    titleEn = json['title_en'];
    titleAr = json['title_ar'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title_en'] = titleEn;
    _data['title_ar'] = titleAr;
    _data['image'] = image;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['code'] = code;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.isActive,
    required this.userGroupId,
    required this.deviceId,
    this.chatUid,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.balance,
    required this.totalPoints,
    required this.pointsToCash,
    required this.userType,
    this.uid,
    required this.addresses,
    required this.points,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final int isActive;
  late final int userGroupId;
  late final String deviceId;
  late final Null chatUid;
  late final Null emailVerifiedAt;
  late final String createdAt;
  late final String updatedAt;
  late final String balance;
  late final int totalPoints;
  late final int pointsToCash;
  late final String userType;
  late final Null uid;
  late final List<Addresses> addresses;
  late final List<Points> points;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isActive = json['is_active'];
    userGroupId = json['user_group_id'];
    deviceId = json['device_id'];
    chatUid = json['chat_uid'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    balance = json['balance'];
    totalPoints = json['total_points'];
    pointsToCash = json['points_to_cash'];
    userType = json['user_type'];
    uid = json['uid'];
    addresses = List.from(json['addresses']).map((e)=>Addresses.fromJson(e)).toList();
    points = List.from(json['points']).map((e)=>Points.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['is_active'] = isActive;
    _data['user_group_id'] = userGroupId;
    _data['device_id'] = deviceId;
    _data['chat_uid'] = chatUid;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['balance'] = balance;
    _data['total_points'] = totalPoints;
    _data['points_to_cash'] = pointsToCash;
    _data['user_type'] = userType;
    _data['uid'] = uid;
    _data['addresses'] = addresses.map((e)=>e.toJson()).toList();
    _data['points'] = points.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Addresses {
  Addresses({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.regionId,
    required this.address,
    this.buildingNo,
    this.floorNo,
    this.flatNo,
    this.street,
    required this.lat,
    required this.lng,
    required this.createdAt,
    required this.updatedAt,
    this.block,
    required this.district,
    this.company,
    this.extra,
    required this.linkToGoogleMap,
    this.city,
    this.region,
  });
  late final int id;
  late final int userId;
  late final int cityId;
  late final int regionId;
  late final String address;
  late final Null buildingNo;
  late final Null floorNo;
  late final Null flatNo;
  late final Null street;
  late final String lat;
  late final String lng;
  late final String createdAt;
  late final String updatedAt;
  late final Null block;
  late final String district;
  late final Null company;
  late final Null extra;
  late final String linkToGoogleMap;
  late final Null city;
  late final Null region;

  Addresses.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    address = json['address'];
    buildingNo = json['building_no'];
    floorNo = json['floor_no'];
    flatNo = json['flat_no'];
    street = json['street'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    block = json['block'];
    district = json['district'];
    company = json['company'];
    extra = json['extra'];
    linkToGoogleMap = json['link_to_google_map'];
    city = json['city'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['city_id'] = cityId;
    _data['region_id'] = regionId;
    _data['address'] = address;
    _data['building_no'] = buildingNo;
    _data['floor_no'] = floorNo;
    _data['flat_no'] = flatNo;
    _data['street'] = street;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['block'] = block;
    _data['district'] = district;
    _data['company'] = company;
    _data['extra'] = extra;
    _data['link_to_google_map'] = linkToGoogleMap;
    _data['city'] = city;
    _data['region'] = region;
    return _data;
  }
}

class Points {
  Points({
    required this.id,
    required this.userId,
    required this.daysToExpired,
    required this.orderId,
    required this.expireAt,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
    required this.converted,
  });
  late final int id;
  late final int userId;
  late final int daysToExpired;
  late final int orderId;
  late final String expireAt;
  late final int points;
  late final String createdAt;
  late final String updatedAt;
  late final int converted;

  Points.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    daysToExpired = json['days_to_expired'];
    orderId = json['order_id'];
    expireAt = json['expire_at'];
    points = json['points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    converted = json['converted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['days_to_expired'] = daysToExpired;
    _data['order_id'] = orderId;
    _data['expire_at'] = expireAt;
    _data['points'] = points;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['converted'] = converted;
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
    required this.status,
    required this.vendorId,
    required this.createdAt,
    required this.updatedAt,
    this.deviceId,
    this.lastLat,
    this.lastLong,
    required this.licence,
    required this.estamara,
    required this.userType,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final String nationalId;
  late final String licenceId;
  late final String vechType;
  late final String nationality;
  late final String employment;
  late final String isFree;
  late final String status;
  late final String vendorId;
  late final String createdAt;
  late final String updatedAt;
  late final Null deviceId;
  late final Null lastLat;
  late final Null lastLong;
  late final String licence;
  late final String estamara;
  late final String userType;

  Driver.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    nationalId = json['national_id'];
    licenceId = json['licence_id'];
    vechType = json['vech_type'];
    nationality = json['nationality'];
    employment = json['employment'];
    isFree = json['is_free'];
    status = json['status'];
    vendorId = json['vendor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceId = json['device_id'];
    lastLat = json['last_lat'];
    lastLong = json['last_long'];
    licence = json['licence'];
    estamara = json['estamara'];
    userType = json['user_type'];
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