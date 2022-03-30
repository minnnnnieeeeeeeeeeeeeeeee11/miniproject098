import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makefoood/pages/addproducts.dart';
import 'package:makefoood/pages/body.dart';
import 'package:makefoood/pages/constants.dart';
import 'package:makefoood/pages/editproduct.dart';
import 'package:makefoood/pages/productdetail.dart';
import 'package:flutter/material.dart';

class ShowProductUser extends StatefulWidget {
  const ShowProductUser({Key? key}) : super(key: key);

  @override
  _ShowProductUserState createState() => _ShowProductUserState();
}

class _ShowProductUserState extends State<ShowProductUser> {
  CollectionReference menu = FirebaseFirestore.instance.collection('Menu');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Make Food",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],

          // backgroundColor: Colors.transparent,
          // elevation: 0.0,
        ),
        drawer: Drawer(),
        body: ListView(
          children: [
            Body(),
            showlist(),
          ],
        ),
      ),
    );
  }

  Widget showlist() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Menu').snapshots(),
      // builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      builder: (context, snapshot) {
        List<Widget> listMe = [];
        if (snapshot.hasData) {
          var menu = snapshot.data;
          listMe = [
            Column(
              children: menu!.docs.map((DocumentSnapshot doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    leading: Image.asset('image/food.png'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(id: doc.id),
                        ),
                      ).then((value) => setState(() {}));
                    },
                    title: Text(
                      '${data['product_name']}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 236, 114, 155)),
                    ),
                    subtitle: Text("ดูวิธีการทำกันเลย"),
                  ),
                );
              }).toList(),
            ),
          ];
        }
        return Center(
          child: Column(
            children: listMe,
          ),
        );
      },
    );
  }

  Container txt() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: const Text(
        'Products list',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
