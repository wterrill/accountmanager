import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1B2E44),
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 500,
            height: 150,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset(
                'assets/images/MXOTechAccountManager.png',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // CircleAvatar( child:
                Image.asset('assets/images/avatar.png', width: 100),
                // ),
                const SizedBox(width: 20),
                const Text('AM Amy',
                    style: TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),
          )
        ],
      ),
    );
  }
}
