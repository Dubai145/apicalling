import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: first(),
    debugShowCheckedModeBanner: false,
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  List<hhh> list = [];
  bool s = false;

  @override
  Widget build(BuildContext context) {
    return s
        ? Scaffold(appBar: AppBar(
      backgroundColor:Color(0xFF38d754),

    ),
            body: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                    subtitle: Text("${list[index].title}"),
                    title:Text("${list[index].userId}"),
                    trailing: Text("${list[index].body}"),
                    leading: Text("${list[index].id}"));
              },
            ),
          )
        : Center(child: CircularProgressIndicator(color: Colors.red,));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forapi();
  }

  forapi() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List res = jsonDecode(response.body);

    setState(() {
      for (int i = 0; i < res.length; i++) {
        hhh dd = hhh.fromJson(res[i]);
        list.add(dd);
      }
      s = true;
    });
  }
}

class hhh {
  int? userId;
  int? id;
  String? title;
  String? body;

  hhh({this.userId, this.id, this.title, this.body});

  hhh.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
