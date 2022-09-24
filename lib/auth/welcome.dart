import 'package:flutter/material.dart';
import 'package:yukmasak/colors.dart';

import 'login.dart';
import 'register.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width - 50,
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/icon/humans.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                "Selamat Datang Di YukMasak",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: fPrimary,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 45),
            //   child: Flexible(
            //     flex: 1,
            //     child: Text(
            //       "Saya sangat senang melihat Anda dapat terus masuk untuk melihat resep masakan disini",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w500,
            //         fontSize: 15,
            //         color: fPrimary,
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: fPrimary,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: kPrimary,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: fPrimary,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: kPrimary,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Register();
                    }));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
