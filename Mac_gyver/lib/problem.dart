import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:macgyver1/Price/Price_water.dart';
import 'package:macgyver1/Price/price_battery.dart';
import 'package:macgyver1/Price/price_display.dart';

class ProblemPage extends StatefulWidget {
  @override
  _ProblemPageState createState() => _ProblemPageState();
}

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

class _ProblemPageState extends State<ProblemPage> {
  int _value = 1;
  List<ListItem> _dropdownItems = [
    ListItem(1, "화면 또는 디스플레이에 금이 감"),
    ListItem(2, "키보드, 마우스 또는 트랙패드 문제"),
    ListItem(3, "액체 또는 물로 인한 손상"),
    ListItem(4, "팬 또는 열 문제"),
    ListItem(5, "포트가 정상적으로 작동하지 않음"),
    ListItem(6, "인클로저가 손상되거나 긁힘"),
    ListItem(7, "마이크 문제"),
    ListItem(8, "배터리 문제"),
  ];
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    Size screenSize = deviceData.size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                            'Yun♥에 어떤 문제가 있나요?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Container(
                      width: 360,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(fontSize: 18, color: Color(0xff828282)),
                          labelText: '카테고리',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        value: _value,
                        items: _dropdownItems.map((ListItem item) {
                          return DropdownMenuItem<int>(
                            child: Text(item.name),
                            value: item.value,
                          );
                        }).toList(),
                        onChanged: (int? value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                        hint: Text('Select item'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        icon: Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ],
                )
              ],
            ),
            TextButton(
              child: Text(
                "카테고리선택",
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
              onPressed: () {
                if (_value == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayPage(
                        value: _value,
                      ),
                    ),
                  );
                } else if (_value == 8) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PricePage(
                        value: _value,
                      ),
                    ),
                  );
                } else if (_value == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaterPage(
                        value: _value,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
