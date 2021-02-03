import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/profile_model.dart';
import 'package:flutter_monisite/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_monisite/domain/provider/auth_provider.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/constants.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/screen/login/login_screen.dart';
import 'package:flutter_monisite/presentation/widgets/error_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'change_pass_screen.dart';

class AccountScreen extends StatefulWidget {
  static const String id = "account_screen";

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AuthBloc authBloc;
  TextEditingController _nama = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _telepon = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  bool _isEdit = false;
  FocusNode nameFocusNode;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(GetAuthentication());
    nameFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _nama.dispose();
    _email.dispose();
    _telepon.dispose();
    _alamat.dispose();
    nameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelpers.colorWhite,
      appBar: AppBar(
        title: Text("Informasi Pribadi"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                    value: choice, child: Text(choice));
              }).toList();
            },
          )
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        cubit: authBloc,
        listener: (context, state) {
          if (state is GetAuthFailed) {
            Fluttertoast.showToast(msg: state.message);
          } else if (state is GetAuthMustLogin) {
            Fluttertoast.showToast(msg: "Perlu login terlebih dahulu");
            Get.offAll(LoginScreen());
          } else if (state is DoLogoutFailed) {
            Fluttertoast.showToast(
                msg: "Silahkan coba kembali beberapa saat lagi");
          } else if (state is DoLogoutSuccess) {
            Get.offAll(LoginScreen());
          } else if (state is EditProfileFailed) {
            authBloc.add(GetAuthentication());

            Fluttertoast.showToast(msg: state.message);
          } else if (state is EditProfileSuccess) {
            _isEdit = false;

            Fluttertoast.showToast(msg: "Berhasil memperbarui data profil");
          } else if (state is EditPhotoProfileSuccess) {
            Fluttertoast.showToast(msg: "Berhasil memperbarui foto profil");
          } else if (state is EditPhotoProfileCancel) {
            Fluttertoast.showToast(msg: "Batal");
          } else if (state is EditPhotoProfileFailed) {
            Fluttertoast.showToast(msg: state.message);
          } else if (state is EditPhotoProfileMaxSize) {
            Fluttertoast.showToast(msg: "Ukuran file foto melebihi 2 MB");
          }
        },
        builder: (context, state) {
          if (state is GetAuthLoading) {
            return skeletonLoading();
          } else if (state is GetAuthSuccess) {
            _nama.text = state.profileModel.user.name;
            _telepon.text = state.profileModel.user.phoneNumber;
            _email.text = state.profileModel.user.email;
            _alamat.text = state.profileModel.user.address;

            return _contentAccount(state.profileModel);
          } else if (state is GetAuthFailed) {
            return ErrorHandlingWidget(
              icon: 'images/laptop.png',
              title: "Gagal mengambil data",
              subTitle: "Silahkan kembali beberapa saat lagi.",
            );
          } else if (state is EditProfileLoading) {
            return skeletonLoading();
          } else if (state is EditProfileSuccess) {
            _nama.text = state.profileModel.user.name;
            _telepon.text = state.profileModel.user.phoneNumber;
            _email.text = state.profileModel.user.email;
            _alamat.text = state.profileModel.user.address;

            return _contentAccount(state.profileModel);
          } else if (state is EditPhotoProfileLoading) {
            return skeletonLoading();
          } else if (state is EditPhotoProfileSuccess) {
            _nama.text = state.profileModel.user.name;
            _telepon.text = state.profileModel.user.phoneNumber;
            _email.text = state.profileModel.user.email;
            _alamat.text = state.profileModel.user.address;
            return _contentAccount(state.profileModel);
          } else if (state is EditPhotoProfileCancel) {
            _nama.text = authBloc.profileModel.user.name;
            _telepon.text = authBloc.profileModel.user.phoneNumber;
            _email.text = authBloc.profileModel.user.email;
            _alamat.text = authBloc.profileModel.user.address;
            return _contentAccount(authBloc.profileModel);
          } else if (state is EditPhotoProfileFailed) {
            return ErrorHandlingWidget(
              icon: 'images/laptop.png',
              title: "Gagal mengambil data",
              subTitle: "Silahkan kembali beberapa saat lagi.",
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _contentAccount(ProfileModel profile) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      profile.user.photoUrl,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    )),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: InkWell(
                    onTap: () async {
                      authBloc.add(EditPhotoProfile(context));
                    },
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.blue,
                      child: Center(
                          child: Image.asset(
                        "images/icon_edit.png",
                        scale: 2.5,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            (_isEdit)
                ? ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text(
                      'Nama',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    subtitle: TextFormField(
                      controller: _nama,
                      autofocus: true,
                      focusNode: nameFocusNode,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                : ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text(
                      'Nama',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    subtitle: Text(
                      profile.user.name,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
            Divider(
              indent: 70,
              color: Colors.grey,
              height: 1,
            ),
            SizedBox(
              height: 10,
            ),
            (_isEdit)
                ? ListTile(
                    leading: Icon(Icons.mail),
                    title: Text(
                      'Email',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    subtitle: TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                : ListTile(
                    leading: Icon(Icons.mail),
                    title: Text(
                      'Email',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    subtitle: Text(
                      profile.user.email,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
            Divider(
              indent: 70,
              color: Colors.grey,
              height: 1,
            ),
            SizedBox(
              height: 10,
            ),
            (_isEdit)
                ? ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      'Telepon',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    subtitle: TextFormField(
                      controller: _telepon,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                : ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      'Telepon',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    subtitle: Text(
                      profile.user.phoneNumber,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
            Divider(
              indent: 70,
              color: Colors.grey,
              height: 1,
            ),
            SizedBox(
              height: 10,
            ),
            (_isEdit)
                ? ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      'Alamat',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    subtitle: TextFormField(
                      controller: _alamat,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                : ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      'Alamat',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    subtitle: Text(
                      profile.user.address ?? "-",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
            Divider(
              indent: 70,
              color: Colors.grey,
              height: 1,
            ),
            UIHelper.verticalSpaceMedium,
            (_isEdit)
                ? Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 5,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  _isEdit = false;
                                });
                              },
                              color: Colors.red,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        UIHelper.horizontalSpaceSmall,
                        Expanded(
                          flex: 5,
                          child: RaisedButton(
                            onPressed: () {
                              authBloc.add(EditProfile(
                                  authBloc.profileModel.user.id,
                                  _nama.text,
                                  _email.text,
                                  _telepon.text,
                                  _alamat.text));
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.lightGreen,
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget skeletonLoading() {
    return SkeletonAnimation(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: ColorHelpers.colorGrey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                'Name',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              subtitle: Container(
                color: ColorHelpers.colorGrey,
                width: double.infinity,
                height: 50,
              ),
            ),
            Divider(
              indent: 70,
              color: Colors.grey,
              height: 1,
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text(
                'Email',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              subtitle: Container(
                color: ColorHelpers.colorGrey,
                width: double.infinity,
                height: 50,
              ),
            ),
            Divider(
              indent: 70,
              color: Colors.grey,
              height: 1,
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(
                'Telephone',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              subtitle: Container(
                color: ColorHelpers.colorGrey,
                width: double.infinity,
                height: 50,
              ),
            ),
            Divider(
              indent: 70,
              color: Colors.grey,
              height: 1,
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Address',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              subtitle: Container(
                color: ColorHelpers.colorGrey,
                width: double.infinity,
                height: 50,
              ),
            ),
            Divider(
              indent: 70,
              color: Colors.grey,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.EditAccount) {
      setState(() {
        if (_isEdit) {
          _isEdit = false;
        } else {
          _isEdit = true;
        }
      });
    } else if (choice == Constants.ChangePassword) {
      Get.to(ChangePassScreen());
    } else {
      setState(() {
        authBloc.add(DoLogout());
      });
    }
  }
}
