import 'package:flutter/material.dart';

class Card {
  String name;
  String image;
  bool isFlipped;

  Card({
    required this.name,
    required this.image,
    required this.isFlipped,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Flip Card Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String  backUrl = 'https://i.ebayimg.com/images/g/1E4AAOSwJfdiE9eO/s-l1200.jpg';
  List<Card> _cardList = [];
  List<Card> _flippedCards = [];

  void _createCards(){
    _cardList.clear();
    _flippedCards.clear();

    for (int i = 0; i < 8; i++){
      _cardList.add(Card(name: 'card$i', image: backUrl, isFlipped: false));
      _cardList.add(Card(name: 'card$i', image: backUrl, isFlipped: false));
    }
  }
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), 
    );
  }
}
