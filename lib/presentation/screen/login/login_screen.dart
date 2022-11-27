import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_monisite/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/screen/login/signup_screen.dart';
import 'package:flutter_monisite/presentation/screen/nav_bottom_main.dart';
import 'package:flutter_monisite/presentation/widgets/clip_painter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  _validator(String value, String textWarning) {
    if (value.isEmpty) {
      return 'Harap mengisi $textWarning';
    }
    return null;
  }

  late AuthBloc authBloc;
  var node;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    node = FocusScope.of(context);

    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is DoLoginSuccess) {
            EasyLoading.showSuccess("Success");
            Get.offAll(NavBottomMain(
              indexPage: 0,
            ));
          } else if (state is DoLoginLoading) {
            EasyLoading.show(status: "Loading...");
          } else if (state is DoLoginFailed) {
            EasyLoading.dismiss();
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: ColorHelpers.colorGreyTextDark,
                textColor: Colors.white,
                fontSize: 14.0);
          }
        },
        child: Scaffold(
          backgroundColor: ColorHelpers.colorWhite,
          body: Container(
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
                            )),
                      ),
                    )),
                _showForm(context),
              ],
            ),
          ),
        ));
  }

  Widget _showForm(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 12,
              horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                showLogo(),
                UIHelper.verticalSpaceMedium,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Masuk',
                    style: TextStyle(
                        color: ColorHelpers.colorDefault,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      showEmailInput(),
                      UIHelper.verticalSpaceMedium,
                      showPasswordInput(),
                      UIHelper.verticalSpaceMedium,
                      showPrimaryButton(),
                      UIHelper.verticalSpaceMedium,
                      Container(
                        child: Text(
                          'Tidak mempunyai akun?',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: ColorHelpers.colorDefault,
                          ),
                        ),
                      ),
                      UIHelper.verticalSpaceSmall,
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            Get.to(SignUpPage());
                          },
                          child: new Text('Klik Disini',
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: ColorHelpers.colorDefault,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 75, horizontal: 10),
      child: Row(
        children: <Widget>[
          Image.asset(
            'images/tower.png',
            scale: 15,
          ),
          UIHelper.horizontalSpaceVerySmall,
          Text('Monisite',
              style: TextStyle(fontSize: 26, color: Colors.blueAccent)),
        ],
      ),
    );
  }

  Widget showPasswordInput() {
    return Opacity(
      opacity: 0.80,
      child: Container(
        child: TextFormField(
          obscureText: _obscureText,
          controller: _password,
          validator: (value) => _validator(value!, 'password'),
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
            labelText: "Password",
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

  Widget showEmailInput() {
    return Opacity(
      opacity: 0.80,
      child: Container(
        child: TextFormField(
          controller: _email,
          validator: (value) => _validator(value!, 'email'),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => node.nextFocus(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.mail,
              color: ColorHelpers.colorBlue,
            ),
            filled: true,
            fillColor: ColorHelpers.colorWhite,
            labelText: "Email",
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
        if (formKey.currentState!.validate()) {
          authBloc.add(DoLogin(_email.text, _password.text));
        }
      },
      child: Container(
          height: 50,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                ColorHelpers.colorBlue.withOpacity(0.4),
                ColorHelpers.colorBlue.withOpacity(0.6),
                ColorHelpers.colorBlue.withOpacity(0.8),
                ColorHelpers.colorBlue
              ]),
              color: ColorHelpers.colorBlue,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: ColorHelpers.colorBlue.withOpacity(0.3),
                  blurRadius: 7,
                  offset: Offset(0, 3),
                  spreadRadius: 3,
                )
              ]),
          child: Text(
            "LOGIN",
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorHelpers.colorWhite),
          )),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
