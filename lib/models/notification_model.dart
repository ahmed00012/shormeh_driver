class NotificationModel {
  NotificationModel({

     this.success,
     this.message,
     this.notifications,
  });
   int? success;
   String? message;
   Notifications? notifications;

  NotificationModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    notifications = json['notifications'] == null ? null : Notifications.fromJson(json['notifications']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['notifications'] = notifications!.toJson();
    return _data;
  }
}

class Notifications {
  Notifications({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
     this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });
  late final int currentPage;
  late final List<Data> data;
  late final String firstPageUrl;
  late final int from;
  late final int lastPage;
  late final String lastPageUrl;
    String ?nextPageUrl;
  late final String path;
  late final int perPage;
    String? prevPageUrl;
  late final int to;
  late final int total;

  Notifications.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from']??"";
    lastPage = json['last_page']??"";
    lastPageUrl = json['last_page_url']??"";
    nextPageUrl = json['next_page_url']??"";
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url']??"";
    to = json['to']??"";
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['first_page_url'] = firstPageUrl;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    _data['last_page_url'] = lastPageUrl;
    _data['next_page_url'] = nextPageUrl;
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['prev_page_url'] = prevPageUrl;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    this.notificationType,
    required this.notificationId,
    required this.title,
    required this.description,
    required this.section,
    this.readAt,
    required this.reciverType,
    required this.reciverId,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    this.orderId,
    this.user,
  });
  late final int id;
  late final Null notificationType;
  int? notificationId;
  late final String title;
  late final String description;
  late final String section;
  late final Null readAt;
  late final String reciverType;
  late final int reciverId;
  String? image;
  late final String createdAt;
  late final String updatedAt;
  late final Null orderId;
  late final Null user;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    notificationType = json['notification_type'];
    notificationId = json['notification_id']??0;
    title = json['title'];
    description = json['description'];
    section = json['section'];
    readAt = json['read_at'];
    reciverType = json['reciver_type'];
    reciverId = json['reciver_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderId = json['order_id'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['notification_type'] = notificationType;
    _data['notification_id'] = notificationId;
    _data['title'] = title;
    _data['description'] = description;
    _data['section'] = section;
    _data['read_at'] = readAt;
    _data['reciver_type'] = reciverType;
    _data['reciver_id'] = reciverId;
    _data['image'] = image;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['order_id'] = orderId;
    _data['user'] = user;
    return _data;
  }
}