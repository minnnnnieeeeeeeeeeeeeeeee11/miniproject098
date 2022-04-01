import 'package:makefoood/pages/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          HomeBanner(size: size),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'เมนูอาหาร',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.25,
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Image.asset(
              'image/13.png',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: const Text(
                      "let's cook",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 22),
                    child: Text(
                      'ถ้าจิตใจห่อเหี่ยว ให้อาหารจะเยียวยา',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
