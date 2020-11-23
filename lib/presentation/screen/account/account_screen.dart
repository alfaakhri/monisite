import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/profile_model.dart';
import 'package:flutter_monisite/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_monisite/domain/provider/auth_provider.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/constants.dart';
import 'package:flutter_monisite/presentation/screen/login/login_screen.dart';
import 'package:flutter_monisite/presentation/widgets/error_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';

class AccountScreen extends StatefulWidget {
  static const String id = "account_screen";

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(GetAuthentication());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelpers.colorWhite,
      appBar: AppBar(
        title: Text("Account"),
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
          }
        },
        builder: (context, state) {
          if (state is GetAuthLoading) {
            return skeletonLoading();
          } else if (state is GetAuthSuccess) {
            return _contentAccount(state.profileModel);
          } else if (state is GetAuthFailed) {
            return ErrorHandlingWidget(
              icon: 'images/laptop.png',
              title: "Ada sesuatu yang error",
              subTitle: "Silahkan kembali beberapa saat lagi.",
            );
          }
          return Container();
        },
      ),
    );
  }

  Container _contentAccount(ProfileModel profile) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: ExactAssetImage('images/Said.jpg'),
              backgroundColor: Colors.amber,
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
          ListTile(
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
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              'Telephone',
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
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Address',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            subtitle: Text(
              profile.user.address ?? '-',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Divider(
            indent: 70,
            color: Colors.grey,
            height: 1,
          ),
        ],
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
      print('Edit Akun');
    } else {
      setState(() {
        authBloc.add(DoLogout());
      });
    }
  }
}
