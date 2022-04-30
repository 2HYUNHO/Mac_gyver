import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PricePage extends StatefulWidget {
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffF7F5F5),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xffF7F5F5),
      body: Container(
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'MacBook2020 M1',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 360,
                      child: const Text(
                        '같은 증상의 맥북 중 배터리 교체를 진단받은 비율이 가장 높아요',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              '맥가이버에 등록된 업체 배터리 교체 평균가격',
                              style: TextStyle(
                                  color: Color(0xff3182F5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 10),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        '62만원',
                                        style: TextStyle(
                                            color: Color(0xff828282),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      child: Text(
                                        'Apple 공인업체',
                                        style: TextStyle(
                                            color: Color(0xff828282),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Colors.grey, //color of divider
                                  width: 60, //width space of divider
                                  thickness: 1, //thickness of divier line
                                  indent: 12, //Spacing at the top of divider.
                                ),
                                Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        '31.5만원',
                                        style: TextStyle(
                                            color: Color(0xff3182F5),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      child: Text(
                                        '사설 수리업체',
                                        style: TextStyle(
                                            color: Color(0xff3182F5),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 160,
                      padding: EdgeInsets.all(25),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.5,
                    ),
                    TextButton(
                      child: Text(
                        "내 주변 업체에 문의하러 가기",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size(370, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        primary: Colors.white,
                        backgroundColor: Color(0xff3182F5),
                        onSurface: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
