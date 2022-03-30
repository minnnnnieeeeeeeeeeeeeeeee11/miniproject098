import 'package:makefoood/pages/showproduct.dart';
import 'package:makefoood/pages/showproductuser.dart';
import 'package:flutter/material.dart';
import 'package:makefoood/pages/loginpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('image/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              menuHeader(),
              Padding(padding: EdgeInsets.only(bottom: 500)),
              bottomBtn(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox bottomBtn() {
    return SizedBox(
      width: 180,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowProductUser(),
                ));
          },
          child: const Text(
            'เริ่มต้นใช้งาน',
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
            foregroundColor: MaterialStateProperty.all(Colors.blue),
          ),
        ),
      ),
    );
  }

  Row menuHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
          },
          icon: const Icon(Icons.person),
          label: const Text(
            'Admin',
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        Container(
          width: 2,
          height: 20,
          color: Colors.white,
        ),
      ],
    );
  }
}
