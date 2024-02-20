import 'dart:core';

import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'hapjuhasil', // 앱의 아이콘 이름
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xff8247FF),
            elevation: 3,
            child: Image.asset('images/map.png'),
          ),
        )
    );
  }
}