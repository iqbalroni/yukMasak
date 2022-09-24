import 'dart:convert';

import 'package:yukmasak/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yukmasak/pages/Home.dart';
import 'package:yukmasak/pages/dashboard.dart';
import 'package:yukmasak/auth/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void LoginButton() async {
    try {
      var respon = await http.post(
        Uri.parse("https://nusantara.thecapz.com/api/login"),
        body: {
          "username": username.text,
          "password": password.text,
        },
      );
      Map<String, dynamic> data =
          json.decode(respon.body) as Map<String, dynamic>;

      if (data['action'] == 'berhasil') {
        final pref = await SharedPreferences.getInstance();

        pref.setString('nama', data['Data']['nama'].toString());
        pref.setString('id', data['Data']['id_pengguna'].toString());
        pref.setString('username', data['Data']['username'].toString());
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

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
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
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "Selamat Datang Kembali",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: fPrimary,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 15),
            //   child: Flexible(
            //     flex: 1,
            //     child: Text(
            //       "Saya sangat senang melihat Anda dapat terus masuk untuk melihat resep masakan disini",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w400,
            //         fontSize: 15,
            //         color: fPrimary,
            //       ),
            //     ),
            //   ),
            // ),
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
                controller: username,
                decoration: InputDecoration(
                  hintText: "Username",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: kSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 25),
              child: TextField(
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: fSecondary),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: password,
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
                    "Login",
                    style: TextStyle(
                      color: fPrimary,
                    ),
                  ),
                  onPressed: LoginButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
