import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_monisite/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChangePassScreen extends StatefulWidget {
  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final formKey = new GlobalKey<FormState>();
  late AuthBloc authBloc;
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();

  String txtNewPass = "";
  late String txtConfirmPass;
  late String txtOldPass;
  bool _obsecureNewPass = false;
  bool _obsecureConfirmPass = false;
  bool _obsecureOldPass = false;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        authBloc.add(GetAuthentication());
        //trigger leaving and use own data
        Get.back();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: ColorHelpers.colorWhite,
        appBar: AppBar(
          title: Text("Ubah Kata Sandi"),
          leading: IconButton(
              onPressed: () {
                authBloc.add(GetAuthentication());
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ChangePasswordLoading) {
              EasyLoading.show();
            } else if (state is ChangePasswordFailed) {
              EasyLoading.dismiss();
              Fluttertoast.showToast(msg: state.message);
            } else if (state is ChangePasswordMatch) {
              EasyLoading.dismiss();
              oldPassword.clear();
              newPassword.clear();
              confirmPassword.clear();
              authBloc.add(GetAuthentication());
              Get.back();
              Fluttertoast.showToast(msg: state.response.message!);
            } else if (state is ChangePasswordNotMatch) {
              EasyLoading.dismiss();
              Fluttertoast.showToast(msg: state.response.message!);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Kata Sandi Lama"),
                  UIHelper.verticalSpaceVerySmall,
                  TextFormField(
                    controller: oldPassword,
                    obscureText: _obsecureOldPass,
                    onChanged: (value) {
                      setState(() {
                        txtOldPass = value;
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Harap mengisi kata sandi lama';
                      } else if (value!.length < 6 && value.length > 0) {
                        return "Kurang dari 6 karakter";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obsecureOldPass = !_obsecureOldPass;
                          });
                        },
                        child: Icon(
                            _obsecureOldPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: ColorHelpers.colorBlue,
                            size: 24),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      hintStyle: TextStyle(color: ColorHelpers.colorGrey2),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                  Text("Kata Sandi Baru"),
                  UIHelper.verticalSpaceVerySmall,
                  TextFormField(
                    controller: newPassword,
                    obscureText: _obsecureNewPass,
                    onChanged: (value) {
                      setState(() {
                        txtNewPass = value;
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Harap mengisi kata sandi baru';
                      } else if (value!.length < 6 && value.length > 0) {
                        return "Kurang dari 6 karakter";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obsecureNewPass = !_obsecureNewPass;
                          });
                        },
                        child: Icon(
                            _obsecureNewPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: ColorHelpers.colorBlue,
                            size: 24),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      hintText: "Minimal 6 karakter",
                      hintStyle: TextStyle(color: ColorHelpers.colorGrey2),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                  Text("Konfirmasi Kata Sandi Baru"),
                  UIHelper.verticalSpaceVerySmall,
                  TextFormField(
                    controller: confirmPassword,
                    obscureText: _obsecureConfirmPass,
                    onChanged: (value) {
                      setState(() {
                        txtConfirmPass = value;
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Harap mengisi konfirmasi kata sandi';
                      } else if (value != newPassword.text) {
                        return 'Kata sandi tidak cocok';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obsecureConfirmPass = !_obsecureConfirmPass;
                          });
                        },
                        child: Icon(
                            _obsecureConfirmPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: ColorHelpers.colorBlue,
                            size: 24),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorHelpers.colorBorder)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  UIHelper.verticalSpaceMedium,
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        if (formKey.currentState!.validate()) {
                          authBloc.add(ChangePassword(newPassword.text,
                              confirmPassword.text, oldPassword.text));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Perbarui Kata Sandi",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
