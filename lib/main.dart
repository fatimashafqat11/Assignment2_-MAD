import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Book',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  List _people = [];
  List _numbers = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('lib/assets/people.json');
    final data = await json.decode(response);
    final String response2 =
        await rootBundle.loadString('lib/assets/numbers.json');
    final data2 = await json.decode(response2);
    setState(() {
      _people = data["people"];
      _numbers = data2["numbers"];
      index =
          _numbers.indexWhere((element) => element["id"] == _people[2]["id"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phone Book',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              ElevatedButton(
                child: const Text('Load Data'),
                onPressed: readJson,
              ),
              _people.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Text("Id: " + _people[2]["id"]),
                          Text("Name: " + _people[2]["name"]),
                          Text("Number: " + _numbers[index]["phone"]),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
