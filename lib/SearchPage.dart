import 'dart:core';

import 'package:flutter/material.dart';

String searchText = '';

List<String> buttonItems = ['거리 순','평점 높은 순','낮은 가격 순','높은 가격 순'];
String selectedButton = buttonItems[0];

List<String> titleList = [];
List<String> hapjusilImageList = [];
List<Hapjusil> hapjusilList = [];

class Hapjusil{
  late String image;
  late String place;
  late String name;
  late double score;
  late int scoreCnt;
  late bool heart;

  Hapjusil(this.image, this.place, this.name, this.score, this.scoreCnt, this.heart);
}

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
                            FilterButton(),// 필터 버튼
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("정렬",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black),),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedButton = buttonItems[0];
                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                if(selectedButton==buttonItems[0])
                                                  Text(buttonItems[0],style: TextStyle(fontSize: 12,color: Colors.purple),)
                                                else
                                                  Text(buttonItems[0],style: TextStyle(fontSize: 12,color: Colors.black),)
                                              ],
                                            )
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedButton = buttonItems[1];
                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                if(selectedButton==buttonItems[1])
                                                  Text(buttonItems[1],style: TextStyle(fontSize: 12,color: Colors.purple),)
                                                else
                                                  Text(buttonItems[1],style: TextStyle(fontSize: 12,color: Colors.black),)
                                              ],
                                            )
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedButton = buttonItems[2];
                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                if(selectedButton==buttonItems[2])
                                                  Text(buttonItems[2],style: TextStyle(fontSize: 12,color: Colors.purple),)
                                                else
                                                  Text(buttonItems[2],style: TextStyle(fontSize: 12,color: Colors.black),)
                                              ],
                                            )
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedButton = buttonItems[3];
                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                if(selectedButton==buttonItems[3])
                                                  Text(buttonItems[3],style: TextStyle(fontSize: 12,color: Colors.purple),)
                                                else
                                                  Text(buttonItems[3],style: TextStyle(fontSize: 12,color: Colors.black),)
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                    duration: Duration(days: 365),
                                    backgroundColor: Colors.white,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.71),
                                ),
                                side: const BorderSide(color: Color(0xffE0E0E0), width: 0.94),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    selectedButton,
                                    style: const TextStyle(fontSize: 16.0,color: Color(0xff656565)),
                                  ),
                                  const SizedBox(width: 2.0),
                                  Image.asset("images/down_arrow.png",width: 24,height: 24,),
                                ],
                              ),
                            ), // 정렬 버튼
                          ],
                        ), // 필터 버튼, 정렬 버튼
                        Expanded(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 열 수 지정
                                mainAxisSpacing: 113, // 수직 간격
                                crossAxisSpacing: 10, // 수평 간격
                              ),
                              itemCount: titleList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SearchListItem(index: index);
                              }
                            ),
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

//검색결과 리스트의 아이템 위젯
class SearchListItem extends StatelessWidget{
  final int index;
  const SearchListItem({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      runSpacing: 8,
      children:[
        GestureDetector(
          onTap: () {
            // 카드를 클릭했을 때 처리할 동작 구현
            // 예를 들어 ContentPage로 이동하는 코드 추가
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ContentPage()),
            // );
          },
          child:Card(
              elevation: 3,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.elliptical(20, 20))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                          children:[
                            Image.asset(hapjusilList[index].image),
                            Positioned(
                              bottom: 10,
                              right: 12,
                              child:Column(
                                children:[
                                  if(hapjusilList[index].heart)
                                    Image.asset('images/heart_true.png')
                                  else
                                    Image.asset('images/heart_false.png')
                                ],
                              ),
                            )
                          ]
                      ),
                    ],
                  ), // 즐겨찾기 표시
                  const SizedBox(height: 4,),
                  Text(
                    hapjusilList[index].place,
                    style: const TextStyle(
                        fontSize: 11
                    ),
                  ), // 위치
                  const SizedBox(height: 7,),
                  Text(
                    hapjusilList[index].name,
                    style: const TextStyle(
                        fontSize: 13
                    ),
                  ), // 합주실 이름
                  const SizedBox(height: 7,),
                  Row(
                    children: [
                      Image.asset('images/star.png'),
                      const SizedBox(width: 2,),
                      Text(
                          hapjusilList[index].score.toString()
                      ),
                      const SizedBox(width: 2,),
                      Text(
                        '(${hapjusilList[index].scoreCnt})',
                        style: const TextStyle(
                            fontSize: 12
                        ),
                      )
                    ],
                  ), // 평점
                ],
              )
          ),
        ),
      ],
    );
  }

}