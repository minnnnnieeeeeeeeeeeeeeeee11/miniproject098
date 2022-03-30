import 'package:makefoood/pages/constants.dart';
import 'package:flutter/material.dart';

class BodyDetail extends StatefulWidget {
  const BodyDetail({Key? key}) : super(key: key);

  @override
  State<BodyDetail> createState() => _BodyDetailState();
}

class _BodyDetailState extends State<BodyDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Container(
            height: size.height * 0.35,
            decoration: BoxDecoration(color: kPrimaryColor),
            child: Image.asset('image/food1.png'),
          ),
        ),
      ],
    );
  }
}
