import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';

class Detail extends StatefulWidget {
  final String keyApi;
  final String gambar;
  const Detail({
    required this.keyApi,
    required this.gambar,
    Key? key,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<String> nama_fav = [''];
  List<String> gambar_fav = [''];
  List<String> kunci_fav = [''];

  Icon love = Icon(
    Icons.favorite_border_outlined,
    color: Colors.white,
    size: 30,
  );

  Color warnatombol = kPrimary;

  detailResipe() async {
    Uri url = Uri.parse(
        "https://masak-apa-tomorisakura.vercel.app/api/recipe/" +
            widget.keyApi);
    var respon = await http.get(url);
    var data = json.decode(respon.body)["results"];
    return data;
  }

  resipe() async {
    Uri url = Uri.parse(
        "https://masak-apa-tomorisakura.vercel.app/api/recipe/" +
            widget.keyApi);
    var respon = await http.get(url);
    var data = json.decode(respon.body)["results"]["ingredient"];
    return data;
  }

  step() async {
    Uri url = Uri.parse(
        "https://masak-apa-tomorisakura.vercel.app/api/recipe/" +
            widget.keyApi);
    var respon = await http.get(url);
    var data = json.decode(respon.body)["results"]["step"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: detailResipe(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/404.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                    height: 320,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.gambar),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: 15,
                            left: 15,
                            top: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      String title =
                                          snapshot.data["title"].toString();
                                      String gambar = widget.gambar;
                                      String kunci = widget.keyApi;

                                      final pref =
                                          await SharedPreferences.getInstance();

                                      if (pref.getStringList('key_favorite') ==
                                          null) {
                                        pref.setStringList(
                                            'key_favorite', ['$kunci']);

                                        pref.setStringList(
                                            'title_favorite', ['$title']);

                                        pref.setStringList(
                                            'tumb_favorite', ['$gambar']);
                                      } else {
                                        nama_fav = pref
                                            .getStringList('title_favorite')!;
                                        gambar_fav = pref
                                            .getStringList('tumb_favorite')!;
                                        kunci_fav =
                                            pref.getStringList('key_favorite')!;

                                        pref.setStringList('key_favorite',
                                            ['$kunci'] + kunci_fav);

                                        pref.setStringList('title_favorite',
                                            ['$title'] + nama_fav);

                                        pref.setStringList('tumb_favorite',
                                            ['$gambar'] + gambar_fav);
                                      }

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Berhasil Di Tambah Ke Favorite'),
                                          backgroundColor: kPrimary,
                                          elevation: 10,
                                        ),
                                      );
                                      love = Icon(
                                        Icons.favorite,
                                        color: kPrimary,
                                        size: 30,
                                      );

                                      warnatombol = Colors.grey;

                                      setState(() {});
                                    },
                                    icon: love,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: new ImageFilter.blur(
                                  sigmaX: 10.0, sigmaY: 6.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff181818).withOpacity(0.6),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Resep By ",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data["author"]["user"],
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 20,
                      bottom: 10,
                    ),
                    child: Text(
                      snapshot.data["title"],
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xff303030),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    child: Text(
                      snapshot.data["times"].toString() +
                          " | " +
                          snapshot.data["dificulty"].toString().toUpperCase() +
                          " | " +
                          snapshot.data["servings"].toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff303030),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: kDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bahan-bahan :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          FutureBuilder(
                            future: resipe(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                right: 10,
                                              ),
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: kPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 4,
                                            child: Text(
                                              snapshot.data[index],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff303030),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                              return Center(
                                  child: SpinKitThreeBounce(
                                color: kPrimary,
                                size: 40.0,
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 30,
                      bottom: 20,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: kDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Langkah-langkah :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          FutureBuilder(
                            future: step(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                right: 10,
                                              ),
                                              width: 5,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: kPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 4,
                                            child: Text(
                                              snapshot.data[index],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff303030),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                              return Center(
                                child: SpinKitThreeBounce(
                                  color: kPrimary,
                                  size: 40.0,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: SizedBox(
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: warnatombol,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_border_outlined,
                                color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Tambah Ke Favorite",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          String title = snapshot.data["title"].toString();
                          String gambar = widget.gambar;
                          String kunci = widget.keyApi;

                          final pref = await SharedPreferences.getInstance();

                          if (pref.getStringList('key_favorite') == null) {
                            pref.setStringList('key_favorite', ['$kunci']);

                            pref.setStringList('title_favorite', ['$title']);

                            pref.setStringList('tumb_favorite', ['$gambar']);
                          } else {
                            nama_fav = pref.getStringList('title_favorite')!;
                            gambar_fav = pref.getStringList('tumb_favorite')!;
                            kunci_fav = pref.getStringList('key_favorite')!;

                            pref.setStringList(
                                'key_favorite', ['$kunci'] + kunci_fav);

                            pref.setStringList(
                                'title_favorite', ['$title'] + nama_fav);

                            pref.setStringList(
                                'tumb_favorite', ['$gambar'] + gambar_fav);
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Berhasil Di Tambah Ke Favorite'),
                              backgroundColor: warnatombol,
                              elevation: 10,
                            ),
                          );

                          love = Icon(
                            Icons.favorite,
                            color: kPrimary,
                            size: 30,
                          );

                          warnatombol = Colors.grey;

                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: SpinKitThreeBounce(
                color: kPrimary,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContentBox extends StatelessWidget {
  final Icon logo;
  final String text;
  final Color warna;
  const ContentBox({
    required this.logo,
    required this.text,
    required this.warna,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: warna.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo,
          Text(
            text,
            style: TextStyle(
              color: warna,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
