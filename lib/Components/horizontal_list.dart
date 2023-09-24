import 'package:flutter/material.dart';


class HorizontalList extends StatelessWidget {
  const HorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const <Widget>[
          Category(image_location: 'Images/Cats/electronics.png', image_caption:'Smartwatch'),
          Category(image_location: 'Images/Cats/headset.png', image_caption:'Headset'),
          Category(image_location: 'Images/Cats/laptop-screen.png', image_caption:'Laptop'),
          Category(image_location: 'Images/Cats/mobile-phone.png', image_caption:'Smartphones'),
          Category(image_location: 'Images/Cats/monitor.png', image_caption:'Desktops')
        ],
      ),
    );
  }
}
class Category extends StatelessWidget {
  const Category({super.key, required this.image_location, required this.image_caption});
  final String image_location;
  final String image_caption;
  
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2.0),
    child: InkWell(
      child: SizedBox(
        width: 100.0,
        child: ListTile(
          title: Image.asset(image_location,
          width: 100.0,
            height: 80.0,
          ),
          subtitle: Container(
            alignment: Alignment.topCenter,
            child: Text(image_caption,style: const TextStyle(fontSize: 12),),
          )
        ),
      ),
    )
    );
  }
}

