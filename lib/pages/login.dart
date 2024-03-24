import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cord2_website/components/dashboard.dart';
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
  late String _error = "";
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() {
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
      setState(() {
        _error = "Please fill out all fields";
        _loading = false;
      });
      return;
    }

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
      DocumentSnapshot user = await users.doc(credential.user?.uid).get();
      Map<String, dynamic> data = user.data() as Map<String, dynamic>;
      if (!data['isResponder']) {
        var res = await FirebaseAuth.instance.signOut();
      } else {
        setState(() {
          _loading = false;
          _isAuth = true;
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        setState(() {
          _error = "Unknown user/password";
          _loading = false;
        });
        return;
      } else if (e.code == 'wrong-password' || e.code == "invalid-credential") {
        setState(() {
          _error = "Incorrect user/password";
          _loading = false;
        });
        return;
      } else {
        setState(() {
          _error = "An unknown error occurred, please try again";
          _loading = false;
        });
        return;
      }
    }
  }

  Widget welcomeCard() {
    return FractionallySizedBox(
      widthFactor: 0.95,
      heightFactor: 0.8,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                child: const Dashboard()
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: "Email"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Password"
                  ),
                ),
              ),
              if (_error.isNotEmpty) Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: Text(_error, style: const TextStyle(color: Colors.red))
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _loading = true;
                        _error = "";
                      });
                      login();
                    },
                      child: _loading ? const CircularProgressIndicator() : const Text("Login"),
                  )
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