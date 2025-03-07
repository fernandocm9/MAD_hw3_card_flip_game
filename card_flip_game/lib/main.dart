import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class Card {
  String name;
  String frontImage;
  String backImage;
  bool isFlipped;
  bool isMatched;

  Card({
    required this.name,
    required this.frontImage,
    required this.backImage,
    required this.isFlipped,
    required this.isMatched,
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
      title: 'Flip Card Game',
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
  String backImage = 'https://i.ebayimg.com/images/g/1E4AAOSwJfdiE9eO/s-l1200.jpg';
  List<Card> _cardList = [];
  List<Card> _flippedCards = [];

  final frontImages = [
    'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Cat_November_2010-1a.jpg/220px-Cat_November_2010-1a.jpg',
    'https://bestfriends.org/sites/default/files/styles/hero_mobile/public/hero-dash/Victory3427MW_Dashboard_Standard.jpg?h=b02ff9d2&itok=HRMUvhfY',
    'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?auto=compress&cs=tinysrgb&w=1200',
    'https://images.pexels.com/photos/34098/south-africa-hluhluwe-giraffes-pattern.jpg?auto=compress&cs=tinysrgb&w=1200',
    'https://images.pexels.com/photos/792381/pexels-photo-792381.jpeg?auto=compress&cs=tinysrgb&w=1200',
    'https://images.pexels.com/photos/62289/yemen-chameleon-chamaeleo-calyptratus-chameleon-reptile-62289.jpeg?auto=compress&cs=tinysrgb&w=1200',
    'https://images.pexels.com/photos/52500/horse-herd-fog-nature-52500.jpeg?auto=compress&cs=tinysrgb&w=1200'
  ];

  @override
  void initState() {
    super.initState();
    _createCards();
  }

  void _createCards() {
    _cardList.clear();
    _flippedCards.clear();

    for (int i = 0; i < 8; i++) {
      _cardList.add(Card(
          name: 'card$i',
          frontImage: frontImages[i],
          backImage: backImage,
          isFlipped: false,
          isMatched: false));
      _cardList.add(Card(
          name: 'card$i',
          frontImage: frontImages[i],
          backImage: backImage,
          isFlipped: false,
          isMatched: false));
    }
    _cardList.shuffle(Random());
    setState(() {});
  }

  void winCondition() {
    if (_cardList.every((element) => element.isMatched)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Congratulations!'),
            content: const Text('You won the game!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Done'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.count(
          crossAxisCount: 4,
          children: List.generate(_cardList.length, (index) {
            return GestureDetector(
              onTap: () {
                if (!_cardList[index].isFlipped && !_cardList[index].isMatched) {
                  setState(() {
                    _cardList[index].isFlipped = true;
                    _flippedCards.add(_cardList[index]);

                    if (_flippedCards.length == 2) {
                      if (_flippedCards[0].name == _flippedCards[1].name) {
                        _flippedCards[0].isMatched = true;
                        _flippedCards[1].isMatched = true;
                        _flippedCards.clear();
                        winCondition();
                      } else {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() {
                            _flippedCards[0].isFlipped = false;
                            _flippedCards[1].isFlipped = false;
                            _flippedCards.clear();
                          });
                        });
                      }
                    }
                  });
                }
              },
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(_cardList[index].isFlipped
                        ? _cardList[index].frontImage
                        : backImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          })),
    );
  }
}