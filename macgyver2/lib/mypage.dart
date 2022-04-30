import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:macgyver1/Componets/shop_card.dart';
import 'package:macgyver1/Device.dart';
import 'package:macgyver1/problem.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  get children => null;

  Widget _informationThree(String title, int value) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, color: Colors.black),
        ),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 13, color: Colors.black),
        ),
      ],
    );
  }

  Widget _informationTwo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "한입먹은사과",
            style: const TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            "ABC@apple.com",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _informationThree('수리이력 ', 2),
              SizedBox(width: 15),
              _informationThree('리뷰작성 ', 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _information() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.transparent,
                backgroundImage: Image.network(
                        "https://image.zdnet.co.kr/2022/03/03/e5c4619a509cbb6dcbd3713a6baee749.png")
                    .image,
              ),
              SizedBox(width: 15),
              _informationTwo()
            ],
          ),
        ],
      ),
    );
  }

  Widget _myApple() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "내 디바이스",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DevicePage()));
                },
                child: Text(
                  "+디바이스 추가하기",
                  style: TextStyle(fontSize: 13, color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProblemPage()));
          },
          child: Text(
            "수리하기",
            style: TextStyle(fontSize: 13, color: Colors.blueGrey),
          ),
        ),
      ],
    );
  }

  Widget _shoplist() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "즐겨찾는 수리점",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "펼쳐보기",
                style: TextStyle(fontSize: 13, color: Colors.blueGrey),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
              children:
                  List.generate(10, (index) => const ShopCard()).toList()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey),
        title: Text(
          "마이페이지",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 19.0),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF7F5F5),
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xffF7F5F5),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _information(),
                _myApple(),
                _shoplist(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
