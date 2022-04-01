import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makefoood/pages/addproducts.dart';
import 'package:makefoood/pages/body.dart';
import 'package:makefoood/pages/constants.dart';
import 'package:makefoood/pages/editproduct.dart';
import 'package:makefoood/pages/home.dart';
import 'package:makefoood/pages/loginpage.dart';
import 'package:flutter/material.dart';

class ShowProductPage extends StatefulWidget {
  const ShowProductPage({Key? key}) : super(key: key);

  @override
  _ShowProductPageState createState() => _ShowProductPageState();
}

class _ShowProductPageState extends State<ShowProductPage> {
  CollectionReference menu = FirebaseFirestore.instance.collection('Menu');

  Future<void> deleteProduct({required String id}) {
    return menu
        .doc(id)
        .delete()
        .then((value) => print("Deleted data Successfully"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

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
              icon: Icon(Icons.logout_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProductPage(),
              ),
            ).then((value) => setState(() {}));
          },
          child: const Icon(
            Icons.add,
          ),
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
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProductPage(id: doc.id),
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
                    trailing: IconButton(
                      onPressed: () {
                        var alertDialog = AlertDialog(
                          title: const Text('ยืนยันการลบข้อมูลเมนู'),
                          content: Text(
                              'คุณต้องการลบเมนู ${data['product_name']} ใช่หรือไม่'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('ยกเลิก')),
                            TextButton(
                                onPressed: () {
                                  deleteProduct(id: doc.id)
                                      .then((value) => Navigator.pop(context));
                                },
                                child: const Text(
                                  'ยืนยัน',
                                  style: TextStyle(color: Colors.red),
                                )),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (context) => alertDialog,
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
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
}
