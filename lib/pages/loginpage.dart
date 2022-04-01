import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:makefoood/pages/loginprofile.dart';
import 'package:makefoood/pages/register.dart';
import 'package:makefoood/pages/showproduct.dart';
import 'package:makefoood/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  LoginProfile loginprofile = LoginProfile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('image/login.png'), fit: BoxFit.cover),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 35, top: 130),
                      child: const Text(
                        'ยินดีต้อนรับ',
                        style: TextStyle(color: Colors.white, fontSize: 33),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 35, top: 180),
                      child: const Text(
                        'โปรดเข้าสู่ระบบก่อนเข้าใช้งาน',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    formfield(context),
                  ],
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  SingleChildScrollView formfield(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 35, right: 35),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                        EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? email) {
                        loginprofile.email = email;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        label: const Text(
                          'Email',
                          style: TextStyle(fontSize: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator:
                          RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
                      onSaved: (String? password) {
                        loginprofile.password = password;
                      },
                      style: const TextStyle(),
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text(
                          'Password',
                          style: TextStyle(fontSize: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff4c505b),
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () async {
                                if (_loginFormKey.currentState!.validate()) {
                                  _loginFormKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: loginprofile.email!,
                                            password: loginprofile.password!)
                                        .then((value) {
                                      _loginFormKey.currentState!.reset();
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const ShowProductPage();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {}
                                }
                              },
                              icon: const Icon(
                                Icons.arrow_forward,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
