import 'package:flutter/rendering.dart';
import 'package:makefoood/pages/body_detail.dart';
import 'package:makefoood/pages/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "รายละเอียด",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.favorite_sharp),
              onPressed: () {},
            )
          ],
        ),
        body: showDetail(context),
      ),
    );
  }

  Widget showDetail(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference menu = FirebaseFirestore.instance.collection('Menu');
    return FutureBuilder<DocumentSnapshot>(
      future: menu.doc(widget.id).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ListView(
            children: [
              Expanded(
                child: Column(
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
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${data['product_name']}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Text(
                            'วัตถุดิบในการทำ ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${data['material']}',
                            style: const TextStyle(
                                height: 1.5,
                                fontSize: 20,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'วิธีการทำ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${data['product_make']}',
                            style: const TextStyle(
                                height: 1.5,
                                fontSize: 20,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const Text('Loading');
      },
    );
  }

  SizedBox picture() {
    return SizedBox(
      height: 280,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('image/11.jpg')),
        ),
      ),
    );
  }
}
