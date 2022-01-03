// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  SliderModel({
    this.id,
    this.logo,
    this.name,
    this.about,
    this.termsConditions,
    this.createdAt,
    this.updatedAt,
    this.citiesSlider,
    this.homeSlider,
  });

  int ?id;
  String? logo;
  String ?name;
  String ?about;
  String ?termsConditions;
  String ?createdAt;
  String ?updatedAt;
  List<CitiesSlider> ?citiesSlider;
  List<dynamic> ?homeSlider;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["id"],
    logo: json["logo"],
    name: json["name"],
    about: json["about"],
    termsConditions: json["terms_conditions"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    citiesSlider: List<CitiesSlider>.from(json["cities_slider"].map((x) => CitiesSlider.fromJson(x))),
    homeSlider: List<dynamic>.from(json["home_slider"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo": logo,
    "name": name,
    "about": about,
    "terms_conditions": termsConditions,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "cities_slider": List<dynamic>.from(citiesSlider!.map((x) => x.toJson())),
    "home_slider": List<dynamic>.from(homeSlider!.map((x) => x)),
  };
}

class CitiesSlider {
  CitiesSlider({
    this.id,
    this.imageableId,
    this.imageableType,
    this.imgUrl,
    this.thumbUrl,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  int ?id;
  int ?imageableId;
  String? imageableType;
  String ?imgUrl;
  dynamic thumbUrl;
  String ?slug;
  String ?createdAt;
  String ?updatedAt;

  factory CitiesSlider.fromJson(Map<String, dynamic> json) => CitiesSlider(
    id: json["id"],
    imageableId: json["imageable_id"],
    imageableType: json["imageable_type"],
    imgUrl: json["img_url"],
    thumbUrl: json["thumb_url"],
    slug: json["slug"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageable_id": imageableId,
    "imageable_type": imageableType,
    "img_url": imgUrl,
    "thumb_url": thumbUrl,
    "slug": slug,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
