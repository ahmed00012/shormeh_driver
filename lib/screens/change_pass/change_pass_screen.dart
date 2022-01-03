
import 'package:dilivery_app/provider/auth_provider.dart';
import 'package:dilivery_app/screens/help/constants.dart';
import 'package:dilivery_app/screens/help/default_button.dart';
import 'package:dilivery_app/screens/help/form_error.dart';
import 'package:dilivery_app/screens/help/help.dart';
import 'package:dilivery_app/screens/help/loading_screen.dart';
import 'package:dilivery_app/screens/home/home_screen.dart';
import 'package:dilivery_app/screens/login/login_screen.dart';
import 'package:dilivery_app/servise/api_exceptions.dart';
import 'package:dilivery_app/servise/vars.dart';
import 'package:dilivery_app/translations/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  String? newPassword;
  String? oldPassword;
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _passwordVisible = false;
  bool _passwordVisibleNew = false;



  final List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }
  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }



  Future<void> _submit() async {
    _formKey.currentState?.validate();
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        LoadingScreen.show(context);
        await Provider.of<AuthProvider>(context, listen: false).changePass( oldPassword!, newPassword!);
        helpToast("Successfully",Colors.green);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        // helpNavigateTo(context, HomeScreen());
      }
    } on ApiException catch (_) {
      Navigator.of(context).pop();
      ServerConstants.showDialog1(context, _.toString());
    } on DioError catch (e) {
      //<<<<< IN THIS LINE
      if (e.response!.statusCode == 400) {

      } else {

      }
    } catch (e) {
      Navigator.of(context).pop();
      ServerConstants.showDialog1(context, e.toString());
    } finally {
      if (mounted) setState(() {});
    }
  }


  @override
  void initState() {
    _passwordVisible = false;
    _passwordVisibleNew= false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(LocaleKeys.change_pass_translate.tr(), style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/guy.gif'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  child: TextFormField(
                    onSaved: (newValue) => oldPassword = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        removeError(error: kPassNullError);
                      } else if (value.length >= 8) {
                        removeError(error: kShortPassError);
                      }
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        addError(error: kPassNullError);
                        return "";
                      } else if (value.length < 8) {
                        addError(error: kShortPassError);
                        return "";
                      }
                      return null;
                    },
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color:   Color(0xffF6F6F6),
                                width: 3.0)),
                        hintText: (LocaleKeys.old_pass_hint.tr()),
                        hintStyle: TextStyle(
                            color: Color(0xffD7D7D7),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(
                          Icons.lock,
                          //   color: kColorGray,
                          size: 18,
                        )),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  child: TextFormField(
                    onSaved: (newValue) => newPassword = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        removeError(error: kPassNullError);
                      } else if (value.length >= 8) {
                        removeError(error: kShortPassError);
                      }
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        addError(error: kPassNullError);
                        return "";
                      } else if (value.length < 8) {
                        addError(error: kShortPassError);
                        return "";
                      }
                      return null;
                    },
                    obscureText: !_passwordVisibleNew,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisibleNew = !_passwordVisibleNew;
                            });
                          },
                          child: Icon(
                            _passwordVisibleNew
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color:   Color(0xffF6F6F6),
                                width: 3.0)),
                        hintText: (LocaleKeys.new_pass_hint.tr()),
                        hintStyle: TextStyle(
                            color: Color(0xffD7D7D7),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(
                          Icons.lock,
                          //   color: kColorGray,
                          size: 18,
                        )),
                  ),
                ),
                FormError(errors: errors),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                  child: DefaultButton(
                    text:LocaleKeys.send_translate.tr(),
                    press: () {
                      _submit();
                      // helpNavigateTo(context, HomeScreen());
                    },
                    color: kColorPrimary, height: 54, fontSize: 20, radius:18, fontColor:  Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
