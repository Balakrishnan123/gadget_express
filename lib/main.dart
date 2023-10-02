import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'components/cart_provider.dart';
import 'firebase_options.dart';
import 'package:gadget_express/Pages/login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
     ChangeNotifierProvider(
          create: (context) => CartManager(),
          child:  const MyApp(),// Create an instance of CartManager
        ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  final CartManager? cartManager;



   const MyApp({super.key, this.cartManager});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          title: const Text("Gadget Express"),
        ),
        body:   MyStatefulWidget(cartManager: cartManager),
      ),
    );
  }
}