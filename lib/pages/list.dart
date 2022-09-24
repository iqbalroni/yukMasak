import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yukmasak/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'detail.dart';

class ListMasakan extends StatefulWidget {
  const ListMasakan({Key? key}) : super(key: key);

  @override
  _ListMasakanState createState() => _ListMasakanState();
}

class _ListMasakanState extends State<ListMasakan> {
  resipe() async {
    Uri url =
        Uri.parse("https://masak-apa-tomorisakura.vercel.app/api/recipes/1");
    var respon = await http.get(url);
    var data = json.decode(respon.body)["results"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimary,
          title: Text("List Masakan"),
        ),
        body: FutureBuilder(
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
              return Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Detail(
                              keyApi: snapshot.data[index]["key"],
                              gambar: snapshot.data[index]["thumb"],
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
                                        snapshot.data[index]["thumb"]),
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index]["key"].toString(),
                                      style: TextStyle(
                                        color: Color(0xFF303030),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        snapshot.data[index]["times"]
                                                .toString() +
                                            " | " +
                                            snapshot.data[index]["dificulty"],
                                        style: TextStyle(
                                          color: Color(0xFF303030),
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitThreeBounce(
                    color: kPrimary,
                    size: 40.0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
