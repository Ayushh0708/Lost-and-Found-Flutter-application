import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:laf_1/components/custom_surfix_icon.dart';
import 'package:laf_1/components/default_button.dart';
import 'package:laf_1/components/form_error.dart';
import 'package:laf_1/components/no_account_text.dart';
import 'package:laf_1/screens/sign_in/sign_in_screen.dart';
import 'package:laf_1/size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const ForgotPassForm(),
              const NoAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? otp;
  String? password;
  String? email;

  bool haveOTP = false;
  bool disableButton = false;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  sendOTP(String _email) async {
    try {
      final res = await http.post(
        Uri.parse("$API_URL/user/forgot_genOTP"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _email,
        }),
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  changePassword(String _email, String _otp, String _password) async {
    try {
      final res = await http.post(
        Uri.parse("$API_URL/user/forgot"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _email,
          'otp': _otp,
          'password': _password,
        }),
      );
      var body = jsonDecode(res.body);
      return body;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (haveOTP == false)
            Column(
              children: [
                const Text(
                  "Please enter your email and we will send \nyou a link to return to your account",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => email = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                      setState(() {
                        errors.remove(kEmailNullError);
                      });
                    } else if (emailValidatorRegExp.hasMatch(value) &&
                        errors.contains(kInvalidEmailError)) {
                      setState(() {
                        errors.remove(kInvalidEmailError);
                      });
                    }
                    email = value;
                    return null;
                  },
                  validator: (value) {
                    if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                      setState(() {
                        errors.add(kEmailNullError);
                      });
                    } else if (!emailValidatorRegExp.hasMatch(value) &&
                        !errors.contains(kInvalidEmailError)) {
                      setState(() {
                        errors.add(kInvalidEmailError);
                      });
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon:
                        CustomSurffixIcon(svgIcon: "./assets/icons/mail.svg"),
                  ),
                ),
                SizedBox(height: 10),
                FormError(errors: errors),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text("Continue")),
                    onPressed: disableButton
                        ? null
                        : () async {
                            setState(() {
                              errors.remove("Error in sending opt");
                              disableButton = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              var res = await sendOTP(email!);
                              if (res == true) {
                                _formKey.currentState!.reset();
                                setState(() {
                                  haveOTP = true;
                              disableButton = true;
                                  disableButton = false;
                                });
                              } else {
                                setState(() {
                                  errors.add("Error in sending opt");
                                  disableButton = false;
                                });
                              }
                            }
                          },
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1)
              ],
            )
          else
            Column(
              children: [
                const Text(
                  "Please enter your new password and opt that you received in your gmail",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                buildOptFormField(),
                SizedBox(height: 15),
                buildPasswordFormField(),
                SizedBox(height: 10),
                FormError(errors: errors),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: 
                  ElevatedButton(
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text("Continue")),
                    onPressed: disableButton
                        ? null
                        : () async {
                            setState(() {
                              errors.clear();
                              disableButton = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              var res = await changePassword(email!, otp!, password!);
                              print(res);
                              if (res['status'] == true) {
                                // shift
                                Navigator.pushNamed(
                                    context, SignInScreen.routeName);
                              } else {
                                setState(() {
                                  disableButton = false;
                                  errors.add(res['msg']);
                                });
                              }
                            }
                          },
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1)
              ],
            )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
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
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your new password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/lock.svg"),
      ),
    );
  }

  TextFormField buildOptFormField() {
    return TextFormField(
      onSaved: (newValue) => otp = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kOTPNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortOTPError);
        }
        otp = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kOTPNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortOTPError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "OTP",
        hintText: "Enter your OTP",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/lock.svg"),
      ),
    );
  }
}
