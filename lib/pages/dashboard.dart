import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukmasak/colors.dart';
import 'package:yukmasak/pages/tes.dart';
import 'dart:convert';

import '../auth/login.dart';
import 'Home.dart';
import 'cari.dart';
import 'detail.dart';
import 'kategori.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? nama;
  String? username;

  List<String> nama_fav = [];

  //reset
  void resetData() async {
    final pref = await SharedPreferences.getInstance();

    pref.setString('nama', '');
    pref.setString('username', '');
    pref.setBool('login', false);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Login();
    }));
  }

  // get
  Future<void> getData() async {
    final pref = await SharedPreferences.getInstance();

    nama = pref.getString('nama');
    username = pref.getString('username');

    if (pref.getStringList('title_favorite') == null) {
      nama_fav = [];
    } else {
      nama_fav = pref.getStringList('title_favorite')!;
    }
  }

  resipe() async {
    Uri url =
        Uri.parse("https://masak-apa-tomorisakura.vercel.app/api/recipes/1");
    var respon = await http.get(url);
    var data = json.decode(respon.body)["results"];
    return data;
  }

  Future fresh() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeApp();
    }));
  }

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              color: kPrimary,
              onRefresh: fresh,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    collapsedHeight: 180,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      centerTitle: false,
                      titlePadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        "Hallo, " + nama.toString(),
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: kPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          Number = 3;
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return HomeApp();
                                          }));
                                        });
                                      },
                                      icon: Icon(
                                        Icons.person,
                                        color: kPrimary,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Ayo Memasak Bersama Ku",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: fSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        margin: EdgeInsets.only(
                                          top: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: kDark,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: TextField(
                                          controller: search,
                                          onSubmitted: (value) {
                                            setState(() {
                                              search == value;
                                            });
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return Cari(
                                                keySearch: value,
                                              );
                                            }));
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Cari Resep",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (search.text == "") {
                                          } else {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return Cari(
                                                keySearch: search.text,
                                              );
                                            }));
                                          }
                                        },
                                        child: Container(
                                          height: 48,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: kPrimary,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: Icon(Icons.search,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: GestureDetector(
                            onTap: () {
                              Number = 2;
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomeApp();
                              }));
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/icon/6023631.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        color: kDark,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Ayo Jelajahi Aplikasi YukMasak",
                                            style: TextStyle(
                                              color: Color(0xFF303030),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Kamu Punya " +
                                                  nama_fav.length.toString() +
                                                  " Resep Masakan Yang Kamu Sukai Coba Kunjungi",
                                              style: TextStyle(
                                                color: Color(0xFF303030),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: kDark,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 20,
                            left: 20,
                            bottom: 10,
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Resep Favorite",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff303030),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ContentImage(
                                  gambar:
                                      "https://www.masakapahariini.com/wp-content/uploads/2021/03/ramen-jepang-ayam-400x240.jpg",
                                  views: "4.3 (200 views)",
                                  judul: "Resep Ramen Jepang",
                                  keyapi: 'resep-ramen-jepang-ayam',
                                ),
                                ContentImage(
                                  gambar:
                                      "https://www.masakapahariini.com/wp-content/uploads/2020/04/Nugget-Ayam-Pedas-780x440.jpg",
                                  views: "4.4 (306 views)",
                                  judul: "Resep Nugget Ayam Pedas",
                                  keyapi: 'resep-nugget-ayam-pedas',
                                ),
                                ContentImage(
                                  gambar:
                                      "https://www.masakapahariini.com/wp-content/uploads/2018/05/SS-UDANG-TABUR-SEREAL-STEP-7b-copy-400x240.jpg",
                                  views: "4.0 (176 views)",
                                  judul: "Resep Udang Tabur Sereal",
                                  keyapi: 'resep-udang-tabur-sereal',
                                ),
                                ContentImage(
                                  gambar:
                                      "https://www.masakapahariini.com/wp-content/uploads/2019/11/ayam-bekakak-400x240.jpg",
                                  views: "4.3 (86 views)",
                                  judul: "Resep Ayam Bekakak",
                                  keyapi: 'resep-ayam-bekakak-khas-bandung',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 20,
                            left: 20,
                            top: 20,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Kategori Resep",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff303030),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              kategori(
                                nama: "Dessert",
                                keyApi: "resep-dessert",
                              ),
                              kategori(
                                nama: "Masakan Hari Raya",
                                keyApi: "masakan-hari-raya",
                              ),
                              kategori(
                                nama: "Masakan Tradisional",
                                keyApi: "masakan-tradisional",
                              ),
                              kategori(
                                nama: "Menu Makan Malam",
                                keyApi: "makan-malam",
                              ),
                              kategori(
                                nama: "Menu Makan Siang",
                                keyApi: "makan-siang",
                              ),
                              kategori(
                                nama: "Resep Ayam",
                                keyApi: "resep-ayam",
                              ),
                              kategori(
                                nama: "Resep Daging",
                                keyApi: "resep-daging",
                              ),
                              kategori(
                                nama: "Resep Sayuran",
                                keyApi: "resep-sayuran",
                              ),
                              kategori(
                                nama: "Resep Seafood",
                                keyApi: "resep-seafood",
                              ),
                              kategori(
                                nama: "Sarapan",
                                keyApi: "sarapan",
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rekomendasi",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff303030),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder(
                            future: resipe(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return Detail(
                                                keyApi: snapshot.data[index]
                                                    ["key"],
                                                gambar: snapshot.data[index]
                                                    ["thumb"],
                                              );
                                            }),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data[index]
                                                              ["thumb"]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    color: kDark,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data[index]
                                                                ["key"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF303030),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Text(
                                                          snapshot.data[index]
                                                                      ["times"]
                                                                  .toString() +
                                                              " | " +
                                                              snapshot.data[
                                                                      index]
                                                                  ["dificulty"],
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF303030),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: kDark,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Center(
                                // child: CircularProgressIndicator(
                                //   backgroundColor: kPrimary,
                                //   color: Color(0xffF7F5FF),
                                // ),
                                child: SpinKitThreeBounce(
                                  color: kPrimary,
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class kategori extends StatelessWidget {
  final String nama;
  final String keyApi;
  const kategori({
    required this.nama,
    required this.keyApi,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Kategori(
            kategori: nama,
            kunci: keyApi,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        // width: 150,
        // height: 50,
        child: Center(
          child: Text(
            nama,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class ContentImage extends StatelessWidget {
  final String gambar;
  final String judul;
  final String views;
  final String keyapi;
  const ContentImage({
    required this.gambar,
    required this.judul,
    required this.views,
    required this.keyapi,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Detail(
              keyApi: keyapi,
              gambar: gambar,
            );
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 15,
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff181818).withOpacity(0.4),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          judul,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          views,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        height: 230,
        width: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(gambar),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
