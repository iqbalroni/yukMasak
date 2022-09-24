import 'package:flutter/material.dart';

class Tes extends StatefulWidget {
  const Tes({Key? key}) : super(key: key);

  @override
  _TesState createState() => _TesState();
}

class _TesState extends State<Tes> {
  List<String> arr = <String>['Tes', 'Kedua', 'ketiga', 'keempat', 'kelima'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: arr.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            color: Colors.amber,
            child: RaisedButton(
              onPressed: () async {
                arr = arr + ['iqbal', 'roni', 'saputra'];
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Warning!!'),
                      content: Text(arr.toString()),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
                setState(() {});
              },
              child: Text(arr[index].toString()),
            ),
          );
        },
      ),
    );
  }
}
