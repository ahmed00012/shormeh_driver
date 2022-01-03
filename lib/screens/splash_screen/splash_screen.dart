import 'dart:async';
import 'package:dilivery_app/provider/slider_provider.dart';
import 'package:dilivery_app/screens/help/constants.dart';
import 'package:dilivery_app/screens/help/help.dart';
import 'package:dilivery_app/screens/login/login_screen.dart';
import 'package:dilivery_app/translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  bool eActive = true;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<SliderProvider>(
            create: (context) => SliderProvider(),
            child: Consumer<SliderProvider>(
              builder: (buildContext, slideProvider, _) => Container(
                padding: EdgeInsets.all(0),
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            currentPage = value;
                          });
                        },
                        itemCount:
                            slideProvider.slider.citiesSlider?.length ?? 0,
                        itemBuilder: (context, index) => Image.network(
                          slideProvider.slider.citiesSlider![index].imgUrl
                              .toString(),
                          fit: BoxFit.cover,
                          //height: 80,
                          // width: MediaQuery.of(context).size.width,
                          //width: 200,
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(
                    //     slideProvider.slider.citiesSlider?.length??0,
                    //         (index) => buildDot(index: index),
                    //   ),
                    // ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      // right: MediaQuery.of(context).size.width/2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: kColorPrimary,
                                      onSurface: Colors.grey,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    child: Text(
                                      LocaleKeys.login_translate.tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 55,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            16,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: eActive
                                              ? Colors.amberAccent
                                              : kColorPrimary,
                                          onSurface: Colors.grey,
                                        ),
                                        onPressed: () async {
                                          await context.setLocale(
                                            Locale("en"),
                                          );
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setString("lang", "en");
                                          setState(() {
                                            eActive = true;
                                          });
                                        },
                                        child: Text(
                                          "English",
                                          style: TextStyle(fontSize: 18),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 55,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            8,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: eActive
                                              ? kColorPrimary
                                              : Colors.amberAccent,
                                          onSurface: Colors.grey,
                                        ),
                                        onPressed: () async {
                                          await context.setLocale(
                                            Locale("ar"),
                                          );
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setString("lang", "ar");
                                          setState(() {
                                            eActive = false;
                                          });
                                        },
                                        child: Text(
                                          "العربية",
                                          style: TextStyle(fontSize: 18),
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 30),
      margin: EdgeInsets.only(right: 5),
      height: 8,
      width: currentPage == index ? 8 : 8,
      decoration: BoxDecoration(
        color: currentPage == index ? kColorPrimary : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
