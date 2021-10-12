import 'package:flutter/material.dart';
import 'author_card.dart';
import 'fooderlich_theme.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container (
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/smoothie.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: [
            const AuthorCard(
                authorName: 'Umar Saidu Auna',
                title: 'Smoothie Connoisseur',
                imageProvider: AssetImage('assets/umar.png')
            ),
            Expanded(
              child: Stack(
                children: [

                  Positioned(
                    bottom: 70,
                    left: 16,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'Smoothies',
                        style: FooderlichTheme.darkTextTheme.headline1,
                      )
                    )
                  ),
                  Positioned(
                    bottom:16,
                    right: 16,
                    child: Text(
                      'Recipe',
                      style: FooderlichTheme.darkTextTheme.headline1,
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}