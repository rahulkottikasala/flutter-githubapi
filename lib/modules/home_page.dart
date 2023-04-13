import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _commits = [];

  @override
  void initState() {
    super.initState();
    _getCommits();
  }

  void _getCommits() async {
    final response = await http
        .get(Uri.parse('https://api.github.com/repos/flutter/flutter/commits'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _commits = jsonResponse;
      });
    } else {
      // print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 40.0,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.receipt_long, color: Colors.amber),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Github Log",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _commits.length,
                itemBuilder: (BuildContext context, int index) {

                  bool isNumeric(String str) {
                    return RegExp(r'^-?[0-9]+$').hasMatch(str);
                  }

                  String ids = _commits[index]['sha'];
                  String lastDigit = ids[ids.length - 1];

                  bool isNumber = isNumeric(lastDigit);

                  return ListTile(
                    title: Text(_commits[index]['commit']['author']['name']),
                    subtitle: Container(
                      color: isNumber ? Colors.amber : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        _commits[index]['sha'],
                      ),
                    ),
                  );
                },
                separatorBuilder: ((BuildContext context, index) {
                  return const Divider();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
