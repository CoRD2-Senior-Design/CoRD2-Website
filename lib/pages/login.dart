import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late bool _isAuth;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() {
    print(FirebaseAuth.instance.currentUser);
    setState(() {
      _isAuth = FirebaseAuth.instance.currentUser != null;
    });
  }

  void signOut() async {
    var res = await FirebaseAuth.instance.signOut();
    setState(() {_isAuth = false;});
  }

  void login() async {
    if (emailController.text.isEmpty || passController.text.isEmpty) {
      return;
    }

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
      DocumentSnapshot user = await users.doc(credential.user?.uid).get();
      Map<String, dynamic> data = user.data() as Map<String, dynamic>;
      if (!data['isResponder']) {
        var res = FirebaseAuth.instance.signOut();
      } else {
        setState(() {
          _isAuth = true;
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return;
      } else if (e.code == 'wrong-password') {
        return;
      } else {
        return;
      }
    }
  }

  Widget welcomeCard() {
    return FractionallySizedBox(
      widthFactor: 0.5,
      heightFactor: 0.5,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                child: const Text(
                  "You're Logged In",
                  style: TextStyle(fontSize: 25.0)
                )
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: ElevatedButton(
                    onPressed: () => signOut(),
                    child: Text("Logout")
                )
              )
            ]
          )
        )
      )
    );
  }

  Widget loginCard() {
    return FractionallySizedBox(
      heightFactor: 0.5,
      widthFactor: 0.5,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                child: const Text(
                  "First Responder Login",
                  style: TextStyle(fontSize: 25.0)
                )
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: "Email"
                ),
              ),
              TextField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                    isDense: true,
                    hintText: "Password"
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: ElevatedButton(
                  onPressed: () => login(),
                  child: Text("Login")
                )
              )
            ]
          )
        )
      )
    );
  }

  Widget renderCard() {
    if (_isAuth) {
      return welcomeCard();
    } else {
      return loginCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Center(
          child: renderCard()
      ),
    );
  }
}