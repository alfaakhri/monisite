import 'package:flutter/material.dart';
import 'package:flutter_monisite/core/components/Constants.dart';
import 'package:flutter_monisite/core/provider/AuthProvider.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  static const String id = "account_screen";

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
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
                'Said Al Fakhri',
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
                'alfakhri1998@gmail.com',
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
                '081220559855',
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
                'Bandung',
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
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.EditAccount) {
      print('Edit Akun');
    } else {
      setState(() {
        Provider.of<AuthProvider>(context, listen: false).doLogout(context);
      });
    }
  }
}
