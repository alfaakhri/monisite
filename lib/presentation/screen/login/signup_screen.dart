import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/widgets/clip_painter.dart';
import 'package:flutter_monisite/presentation/widgets/loading_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../nav_bottom_main.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController phone = TextEditingController();

  AuthBloc authBloc;
  final formKey = new GlobalKey<FormState>();

  String txtEmail = "";
  String txtPassword = "";
  String txtConfirmPassword = "";
  String txtPhone = "";

  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _checkPassword = true;

  _validator(String value, String textWarning) {
    if (value.isEmpty) {
      return 'Harap mengisi $textWarning';
    }
    return null;
  }

  var node;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    node = FocusScope.of(context);

    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      cubit: authBloc,
      listener: (context, state) {
        if (state is PostSignupLoading) {
          LoadingWidget.showLoadingDialog(context, _keyLoader);
        } else if (state is PostSignupSuccess) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Fluttertoast.showToast(msg: "Registration Success!");
          Get.offAll(NavBottomMain());
        } else if (state is PostSignupFailed) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Fluttertoast.showToast(msg: state.message);
        }
      },
      child: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: Container(
                    child: Transform.rotate(
                  angle: -pi / 3.5,
                  child: ClipPath(
                    clipper: ClipPainter(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.blue.shade800,
                            Colors.blue.shade300
                          ])),
                    ),
                  ),
                ))),
            Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .25),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Buat Akun',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      UIHelper.verticalSpaceMedium,
                      _buildTextField(
                          "Nama", Icons.person, nama, TextInputType.text),
                      UIHelper.verticalSpaceMedium,
                      _buildEmailTextField(),
                      UIHelper.verticalSpaceMedium,
                      _buildTextField(
                          "Telepon", Icons.call, phone, TextInputType.phone),
                      UIHelper.verticalSpaceMedium,
                      _buildPasswordTextField(),
                      UIHelper.verticalSpaceMedium,
                      _buildConfirmPasswordTextField(),
                      UIHelper.verticalSpaceMedium,
                      showPrimaryButton(),
                      UIHelper.verticalSpaceMedium,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    ));
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.arrow_back_ios,
                size: 30.0,
                color: ColorHelpers.colorSubTittleGrey,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icons,
      TextEditingController controller, TextInputType textInputType) {
    return Opacity(
      opacity: 0.80,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => node.nextFocus(),
            validator: (value) => _validator(value, label),
            decoration: _decorationFormRegister(icons, label)),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Opacity(
      opacity: 0.80,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
              controller: email,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Harap mengisi email';
                } else {
                  if (value.contains("@")) {
                    return null;
                  } else {
                    return "Format email salah";
                  }
                }
              },
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) {
                setState(() {
                  txtEmail = val;
                });
              },
              decoration: _decorationFormRegister(Icons.mail, 'Email'))),
    );
  }

  Widget _buildPasswordTextField() {
    return Opacity(
      opacity: 0.80,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          obscureText: _obscureText,
          controller: password,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => node.nextFocus(),
          validator: (value) {
            if (value.isEmpty) {
              return 'Harap mengisi kata sandi';
            } else {
              if (value.length >= 6) {
                return null;
              } else {
                return 'Kata sandi minimal 6 karakter';
              }
            }
          },
          onChanged: (val) {
            setState(() {
              txtPassword = val;
            });
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: ColorHelpers.colorBlue),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: ColorHelpers.colorBlue,
                  size: 24),
            ),
            filled: true,
            fillColor: ColorHelpers.colorWhite,
            labelText: "Kata Sandi",
            isDense: true,
            labelStyle: TextStyle(color: ColorHelpers.colorBlue),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorHelpers.colorBlue)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorHelpers.colorWhite)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorHelpers.colorBorder)),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return Opacity(
      opacity: 0.80,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          obscureText: _obscureText1,
          controller: confirmPassword,
          validator: (value) {
            if (value.isEmpty) {
              return 'Harap mengisi konfirmasi kata sandi';
            } else {
              if (txtPassword == txtConfirmPassword) {
                return null;
              } else {
                return 'Kata sandi tidak cocok';
              }
            }
          },
          onChanged: (val) {
            txtConfirmPassword = val;
            setState(() {
              if (txtPassword == txtConfirmPassword) {
                _checkPassword = true;
              } else {
                _checkPassword = false;
              }
            });
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: ColorHelpers.colorBlue),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText1 = !_obscureText1;
                });
              },
              child: Icon(
                  _obscureText1 ? Icons.visibility : Icons.visibility_off,
                  color: ColorHelpers.colorBlue,
                  size: 24),
            ),
            filled: true,
            fillColor: ColorHelpers.colorWhite,
            labelText: "Ulangi Kata Sandi",
            isDense: true,
            labelStyle: TextStyle(color: ColorHelpers.colorBlue),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorHelpers.colorBlue)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorHelpers.colorWhite)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorHelpers.colorBorder)),
          ),
        ),
      ),
    );
  }

  Widget showPrimaryButton() {
    return InkWell(
      onTap: () {
        if (formKey.currentState.validate()) {
          showDialog(
              context: context,
              builder: (context) {
                return showAlertDialog();
              });
        }
      },
      child: Container(
          height: 50,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                ColorHelpers.colorBlue.withOpacity(0.4),
                ColorHelpers.colorBlue.withOpacity(0.6),
                ColorHelpers.colorBlue.withOpacity(0.8),
                ColorHelpers.colorBlue
              ]),
              color: ColorHelpers.colorBlue,
              //border: Border.all(color: ColorHelpers.colorBlue),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: ColorHelpers.colorBlue.withOpacity(0.3),
                  blurRadius: 7,
                  offset: Offset(0, 3),
                  spreadRadius: 3,
                )
              ]),
          child: Text(
            "REGISTER",
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorHelpers.colorWhite),
          )),
    );
  }

  InputDecoration _decorationFormRegister(IconData icon, String label) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: ColorHelpers.colorBlue),
      filled: true,
      fillColor: ColorHelpers.colorWhite,
      labelText: label,
      isDense: true,
      labelStyle: TextStyle(color: ColorHelpers.colorBlue),
      // border: InputBorder.none
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorHelpers.colorBlue)),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorHelpers.colorWhite)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorHelpers.colorBorder)),
    );
  }

  Widget showAlertDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        child: Column(
          children: <Widget>[
            UIHelper.verticalSpaceMedium,
            Text(
              'Registrasi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            UIHelper.verticalSpaceMedium,
            Text(
              'Apakah kamu yakin data yang telah diinputkan sudah benar ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorHelpers.colorGreyTextLight, fontSize: 14),
            ),
            UIHelper.verticalSpaceMedium,
            UIHelper.verticalSpaceMedium,
            GestureDetector(
              onTap: () {
                Navigator.pop(context);

                authBloc.add(PostSignup(nama.text, email.text, phone.text,
                    password.text, confirmPassword.text));
              },
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        ColorHelpers.colorBlue.withOpacity(0.4),
                        ColorHelpers.colorBlue.withOpacity(0.6),
                        ColorHelpers.colorBlue.withOpacity(0.8),
                        ColorHelpers.colorBlue
                      ]),
                      color: ColorHelpers.colorWhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: ColorHelpers.colorBlue.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                          spreadRadius: 2,
                        )
                      ]),
                  child: Text(
                    "YA",
                    style: TextStyle(
                        color: ColorHelpers.colorWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            UIHelper.verticalSpaceMedium,
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorHelpers.colorGreyField,
                    border: Border.all(color: ColorHelpers.colorGreyField),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "TIDAK",
                    style: TextStyle(
                        color: ColorHelpers.colorGreyTextField,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
