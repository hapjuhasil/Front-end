import 'dart:core';

import 'package:flutter/material.dart';

String searchText = '';

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
            body: Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 29, left: 18, right: 18),
                    child: Column(
                      children: <Widget> [
                        const SizedBox(
                          height: 9,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Image.asset("images/search.png", height: 16, width: 16,),
                            hintText: '어떤 합주실을 찾으세요?',
                            filled: true,
                            fillColor: const Color(0xfff5f7f8),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.elliptical(8, 8))
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
                          },
                        ), // 검색창
                      ],
                    ),
                  );
                }

            )
        )
    );
  }
}