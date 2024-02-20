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
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FilterButton(),
                          ],
                        )
                      ],
                    ),
                  );
                }

            )
        )
    );
  }
}
//필터 버튼
class FilterButton extends StatelessWidget{
  const FilterButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.71),
          side: const BorderSide(color: Color(0xffE0E0E0), width: 0.94),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/filter.png",height: 24,width: 24,),
          const SizedBox(width: 7.0),
          const Text(
            "필터",
            style: TextStyle(fontSize: 16.0,color: Color(0xff656565)),
          ),
        ],
      ),
    );
  }
}