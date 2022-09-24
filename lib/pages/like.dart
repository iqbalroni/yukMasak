import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';
import 'detail.dart';

class Like extends StatefulWidget {
  const Like({Key? key}) : super(key: key);

  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  List<String> nama_fav = [];
  List<String> gambar_fav = [];
  List<String> kunci_fav = [];

  Future<void> getDataFavorite() async {
    final pref = await SharedPreferences.getInstance();

    if (pref.getStringList('title_favorite') == null) {
      return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
              "Data Resep Favorite Masih Kosong",
            ),
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
      nama_fav = pref.getStringList('title_favorite')!;
      kunci_fav = pref.getStringList('key_favorite')!;
      gambar_fav = pref.getStringList('tumb_favorite')!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimary,
          title: Text("Resep Favorite"),
        ),
        body: ListView(
          children: [
            FutureBuilder(
              future: getDataFavorite(),
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
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: nama_fav.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Detail(
                                keyApi: kunci_fav[index],
                                gambar: gambar_fav[index],
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
                                          gambar_fav[index].toString()),
                                      fit: BoxFit.cover,
                                    ),
                                    color: kDark,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
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
                                        nama_fav[index].toString(),
                                        style: TextStyle(
                                          color: Color(0xFF303030),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
