import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukmasak/auth/welcome.dart';
import 'package:yukmasak/colors.dart';
import 'package:http/http.dart' as http;
import '../auth/login.dart';
import 'Home.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String? nama;
  String? username;
  String? id;

  //reset
  void resetData() async {
    final pref = await SharedPreferences.getInstance();

    pref.setString('nama', '');
    pref.setString('username', '');
    pref.setBool('login', false);
    pref.setStringList('title_favorite', []);
    pref.setStringList('key_favorite', []);
    pref.setStringList('tumb_favorite', []);

    Number = 0;

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Welcome();
    }));
  }

  // get
  Future<void> getData() async {
    final pref = await SharedPreferences.getInstance();

    nama = pref.getString('nama');
    username = pref.getString('username');
    id = pref.getString('id');
  }

  // button saran
  void KirimData() async {
    var respon = await http
        .post(Uri.parse("https://nusantara.thecapz.com/api/saran"), body: {
      "id": id.toString(),
      "saran": saran.text,
    });

    Map<String, dynamic> data =
        json.decode(respon.body) as Map<String, dynamic>;

    if (data['action'] == 'berhasil') {
      saran.clear();
      return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Success'),
            content: Text("Saran Behasil Di Kirim Ke Developer"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
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
  }

  TextEditingController saran = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimary,
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text("Perhatian!"),
                            content: Text("Apakah Kamu Yakin Ingin Logout?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Batal",
                                  style: TextStyle(color: kPrimary),
                                ),
                              ),
                              TextButton(
                                onPressed: resetData,
                                child: Text(
                                  "Logout",
                                  style: TextStyle(color: kPrimary),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    Number = 0;
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeApp();
                    }));
                  });
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Center(child: Text("My Profile")),
              elevation: 0,
            ),
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: kDark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/profil.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: 15,
                          left: 15,
                          top: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              username.toString().toUpperCase(),
                              style: TextStyle(
                                fontSize: 30,
                                color: kPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              nama.toString().toUpperCase(),
                              style: TextStyle(
                                fontSize: 15,
                                color: fSecondary,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kDark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: kPrimary,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: kPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Belum Memasukan Email",
                              style: TextStyle(
                                fontSize: 15,
                                color: fSecondary,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: kPrimary,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Phone",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: kPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Belum Memasukan Nomor Hp",
                              style: TextStyle(
                                fontSize: 15,
                                color: fSecondary,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kDark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kirim Saran Untuk Developer",
                        style: TextStyle(
                          fontSize: 20,
                          color: fSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: saran,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Ketik Disini",
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: KirimData,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: kPrimary,
                        child: Text(
                          "Kirim Saran",
                          style: TextStyle(
                            color: fPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                //   child: SizedBox(
                //     height: 50,
                //     width: MediaQuery.of(context).size.width,
                //     child: RaisedButton(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       color: kPrimary,
                //       child: Text(
                //         "Logout",
                //         style: TextStyle(
                //           color: fPrimary,
                //         ),
                //       ),
                //       onPressed: resetData,
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        });
  }
}
