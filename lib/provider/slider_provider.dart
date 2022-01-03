
import 'package:dilivery_app/models/slider_model.dart';
import 'package:dilivery_app/servise/api_slidert.dart';
import 'package:flutter/material.dart';

class SliderProvider extends ChangeNotifier{
  SliderProvider(){
    getSlider();
  }
  SliderModel slider = new SliderModel();




  void getSlider(){
    ApiSlider.instance.getSlider().then((slide){
      slider = slide!;
      notifyListeners();
    }
    );
  }

}