import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:macgyver1/price.dart';

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
        ListItem(1, "디스플레이"),
        ListItem(2, "버튼불량"),
        ListItem(3, "전원불량"),
        ListItem(4, "터치패드")
      ],
      _dropdown2Items = [
        ListItem(1, "화면번인"),
        ListItem(2, "하판교체"),
        ListItem(3, "배터리수명"),
        ListItem(4, "오작동")
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
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                        icon: Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 360,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: '세부항목',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        value: _value,
                        items: _dropdown2Items.map((ListItem item) {
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
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                        icon: Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ],
                )
              ],
            ),
            TextButton(
              child: Text(
                "진단받기",
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PricePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
