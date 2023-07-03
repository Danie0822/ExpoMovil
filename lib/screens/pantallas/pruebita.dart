
import 'package:flutter/material.dart';

class Daniels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nombre de la empresa'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Carousel(),
              const SizedBox(height: 20),
              const Text('Notificaciones', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              NotificationList(),
            ],
          ),
        ),
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _currentIndex = (_currentIndex + 1) % 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/icons/ricaldone.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Título ${index + 1}', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 5),
                    Text('Descripción breve de la tarjeta ${index + 1}'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key('notification_$index'),
          onDismissed: (direction) {},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/icons/ricaldone.png'),
              ),
              title: Text('Notificación ${index + 1}'),
              subtitle: Text('Descripción de la notificación ${index + 1}'),
            ),
          ),
        );
      },
    );
  }
}