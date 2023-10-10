import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
//custom import
import 'package:gadget_express/components/horizontal_list.dart';
import 'package:gadget_express/Components/products.dart';
import 'package:gadget_express/Pages/cart.dart';
import 'package:gadget_express/components/cart_provider.dart';

import 'package:gadget_express/pages/messages.dart';


class HomePage extends StatelessWidget {
  final CartManager? cartManager;
   late DialogFlowtter dialogFlowtter;

     HomePage({super.key, required this.cartManager});


  @override
  Widget build(BuildContext context) {
  Widget imageCarousel = SizedBox(
    height: 200.0,
    child: CarouselSlider(
      options: CarouselOptions(
          autoPlay: false,
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: [
        Image.asset('Images/Home/g1.jpg'),
        Image.asset('Images/Home/g2.jpg'),
        Image.asset('Images/Home/g3.jpg'),
        Image.asset('Images/Home/g4.jpg'),
        Image.asset('Images/Home/g5.jpg')
    ],
    ),
  );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.black26,
        title: const Text("Gadget Express"),
        actions:  <Widget>[
          const IconButton(icon: Icon(Icons.search, color: Colors.black), onPressed: null),
          IconButton(icon: const Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(cartManager: cartManager)));
          }),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children:  <Widget>[
          UserAccountsDrawerHeader(
              accountName:  const Text("Balakrishnan"),
              accountEmail: const Text("adithyavbk@gmail.com"),
          currentAccountPicture: GestureDetector(
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person,color: Colors.white),
            ),
          ),
            decoration: const BoxDecoration(
              color: Colors.black45,
            ),
          ),

          const InkWell(
            child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home,color: Colors.amber)
            ),
          ),

          const InkWell(
            child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person,color: Colors.amber)
            ),
          ),

          const InkWell(
            child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket,color: Colors.amber)
            ),
          ),

           InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  CartScreen(cartManager: cartManager,)));
            },
            child: const ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(Icons.shopping_cart,color: Colors.amber)
            ),
          ),

          const InkWell(
            child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite,color: Colors.amber)
            ),
          ),

          const Divider(),

           InkWell(
            onTap: (){
        //      Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyStatefulWidget()));
            },
            child: const ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.logout, color: Colors.red,)
            ),
          ),

           InkWell(
            child: ListTile(
                title: const Text('Chatbot Assistance'),
                leading: const Icon(Icons.chat, color: Colors.blue),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Chatbot(),),
                );
                }
            ),
          ),
        ],
      )),
      body: Column(
        children: <Widget>[
          imageCarousel,

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Categories'),
          ),
          const HorizontalList(),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Recent Products'),
          ),
            Flexible(child: Products(cartManager: cartManager,)),
        ],
      ),
    );
  }
}
