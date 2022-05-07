import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 140,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
      ),
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [],
            ),
          ),
          Positioned(
            right: 3,
            top: 2,
            child: const Icon(
              Icons.star_border_outlined,
              size: 30,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
