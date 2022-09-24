import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukmasak/auth/welcome.dart';
import 'package:yukmasak/pages/Home.dart';
import 'package:yukmasak/pages/dashboard.dart';

class Launcer extends StatefulWidget {
  const Launcer({Key? key}) : super(key: key);

  @override
  _LauncerState createState() => _LauncerState();
}

class _LauncerState extends State<Launcer> {
  @override
  void cekPilihan() async {
    final cek = await SharedPreferences.getInstance();

    if (cek.getBool('login') == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeApp();
      }));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Welcome();
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    cekPilihan();
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}
