import 'package:dilivery_app/screens/help/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';


class LoadingWidget extends StatelessWidget {
  final Indicator indicator;
  final Color color;

  const LoadingWidget({
    this.indicator = Indicator.ballClipRotateMultiple,
    this.color = kColorPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        child: Image.asset(''),
      ),
    );
  }
}

class LoadingScreen {
  LoadingScreen._();

  static show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
