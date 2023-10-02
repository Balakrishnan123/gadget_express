
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
   RegistrationPage({super.key});
  final nameController = TextEditingController();
  final passController = TextEditingController();
   final emailController = TextEditingController();
   final confirmPassword = TextEditingController();
   bool isFieldEmpty(String text) {
     return text.trim().isEmpty;
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gadget Express'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
                        child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child:  TextField(

                key: const Key('username_field'),
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child:   TextField(
                key: const Key('email_address'),
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child:  TextField(
                key: const Key('password_field'),
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child:   TextField(
                key: const Key('confirm_pass'),
                controller: confirmPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
              ),
            ),
        Container(
          height: 40,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final password = passController.text;
                final email = emailController.text;
                final confirmPass = confirmPassword.text;
                if (isFieldEmpty(name) || isFieldEmpty(password) || isFieldEmpty(email)) {
                  showErrorDialog(context, 'Please fill all the fields to proceed');
                }else if (password != confirmPass) {
                  showErrorDialog(context, 'Password and confirm password do not match');
                }
                else {
                  createUser(name: name, password: password, email: email, context: context);
                  Navigator.pop(context);
                }
              },
              child: const Text('Register'),
            ),
        ),
          ],
        ),
      ),
    );
  }

  void createUser({required BuildContext context,required String name, required String password, required String email}) async{
    final docUser = FirebaseFirestore.instance.collection('User').doc();

    final json = {
      'Name':name,
      'Password':password,
      'Email':email
    };
    await docUser.set(json);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration Successful. Proceed to Login.'),
        duration: Duration(seconds: 10), // Adjust the duration as needed
      ),
    );
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

}