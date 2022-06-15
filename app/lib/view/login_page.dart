import 'package:app/view/top_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/authentication.dart';
import '../utils/firestore/users.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Center(
          child: Container(
            width: 280,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Container(
                    width: 120,
                    child: Image.network('https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png'),
                  ),
                  SizedBox(height: 60),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'メールアドレス',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'パスワード',
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                    ),
                    onPressed: () async {
                      print('log ::: ElevatedButton.onPressed');
                      var result = await Authentication.signInByEmail(email: emailController.text, password: passwordController.text);
                      if (result is UserCredential) {
                          var _result = await UserFirestore.getUser(result.user!.uid);
                          if (_result) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TopPage()));
                          }
                      }
                    },
                    child: Text(
                      'ログイン',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
