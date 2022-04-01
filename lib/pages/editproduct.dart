import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makefoood/pages/constants.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _material = TextEditingController();
  TextEditingController _make = TextEditingController();

  CollectionReference menu = FirebaseFirestore.instance.collection('Menu');

  Future<void> updateProduct() {
    return menu.doc(widget.id).update({
      'product_name': _name.text,
      'material': _material.text,
      'product_make': _make.text,
    }).then((value) {
      print("Data updated successfully");
      Navigator.pop(context);
    }).catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'แก้ไขข้อมูลเมนู',
                style: TextStyle(color: Colors.black, fontSize: 33),
              ),
            ),
            editformfield(context),
          ],
        ),
      ),
    );
  }

  Widget editformfield(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: menu.doc(widget.id).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          _name.text = data['product_name'];
          _material.text = data['material'];
          _make.text = data['product_make'];

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _name,
                          decoration: InputDecoration(
                            label: Text(
                              'ชื่อเมนู',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade700),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _material,
                          decoration: InputDecoration(
                            label: Text(
                              'วัตถุดิบ',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade700),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _make,
                          decoration: InputDecoration(
                            label: Text(
                              'วิธีการทำ',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade700),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'บันทึกข้อมูล',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  Color.fromARGB(255, 238, 204, 231),
                              child: IconButton(
                                  color: Colors.pink,
                                  onPressed: updateProduct,
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const Text('Loading');
      },
    );
  }
}
