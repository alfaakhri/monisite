import 'package:flutter/material.dart';
import 'package:flutter_monisite/ui/shared/style.dart';

class ForgotPassScreen extends StatefulWidget {
  static const String id = "forgot_pass_screen";

  @override
  _ForgotPassScreen createState() => _ForgotPassScreen();
}

class _ForgotPassScreen extends State<ForgotPassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset('images/logo.png'),
                      height: 40.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Etalase',
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.teal,
                          fontFamily: 'SourceSansPro',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35.0,
                ),
                Card(
                  elevation: 4.0,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Forget Password',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.left,
                          decoration: inputDecorationPlusIconStyle("Email", Icon(Icons.mail)),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          // onChanged: (value) {
                          //   // email = value;
                          // },
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Material(
                            elevation: 5.0,
                            child: RaisedButton(
                              color: Colors.blueAccent,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onPressed: () {},
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
