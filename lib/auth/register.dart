import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukmasak/pages/Home.dart';

import '../../colors.dart';
import '../pages/dashboard.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nama = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  // button register
  void register() async {
    try {
      var respon = await http
          .post(Uri.parse("https://nusantara.thecapz.com/api/register"), body: {
        "nama": nama.text,
        "username": username.text,
        "password": password.text,
      });

      Map<String, dynamic> data =
          json.decode(respon.body) as Map<String, dynamic>;

      if (data['action'] == 'berhasil') {
        final pref = await SharedPreferences.getInstance();

        pref.setString('nama', nama.text);
        pref.setString('id', data['id'].toString());
        pref.setString('username', username.text);
        pref.setBool('login', true);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeApp();
        }));
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Gagal!!'),
              content: Text(data['action'].toString()),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (i) {
      return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Gagal'),
            content: Text("Terjadi Kesalahan Pada Internet"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text(
                  'OK',
                  style: TextStyle(color: kPrimary),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                "Buat Akun Baru",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: fPrimary,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: kSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: fSecondary),
                autofocus: true,
                controller: nama,
                decoration: InputDecoration(
                  hintText: "Nama",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: kSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: username,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: fSecondary),
                decoration: InputDecoration(
                  hintText: "Username",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                color: kSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: password,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: fSecondary),
                decoration: InputDecoration(
                  hintText: "Password",
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 50,
                width: 150,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: btnPrimary,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: fPrimary,
                    ),
                  ),
                  onPressed: register,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
