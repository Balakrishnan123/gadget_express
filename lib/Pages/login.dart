import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gadget_express/Pages/registration.dart';
import 'package:gadget_express/components/cart_provider.dart';
import 'package:gadget_express/home.dart';


class MyStatefulWidget extends StatefulWidget {
  final CartManager? cartManager;

  const MyStatefulWidget({Key? key, required this.cartManager}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              /*          child: const Text(
                  'Gadget Express',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )*/
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                key: const Key('username_field'),
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                key: Key('password_field'),
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                  key: const Key('login_button'),
                  child: const Text('Login'),
                  onPressed: () {
                    final enteredUsername = nameController.text;
                    final enteredPassword = passwordController.text;

                    isValidLogin(enteredUsername: enteredUsername, enteredPassword: enteredPassword)
                        .then((isValid) {
                      if (isValid) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(cartManager: widget.cartManager),
                          ),
                        );
                      } else {
                        showErrorDialog(context, 'Invalid username or password');
                      }
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()),
                    );
                  },
                )
              ],
            ),
          ],
        ));
  }
}
Future<bool> isValidLogin({required String enteredUsername, required String enteredPassword}) {
  // Query Firestore to check if the entered username and password match any user record
  final usersCollection = FirebaseFirestore.instance.collection('User');

  return usersCollection
      .where('Name', isEqualTo: enteredUsername)
      .where('Password', isEqualTo: enteredPassword)
      .get()
      .then((querySnapshot) {
    return querySnapshot.docs.isNotEmpty;
  }).catchError((error) {
    print("Error querying Firestore: $error");
    return false;
  });
}
void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}