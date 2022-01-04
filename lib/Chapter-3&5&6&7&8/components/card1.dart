import 'package:flutter/material.dart';
import '../../fooderlich_theme.dart';
import '../models/models.dart';

class Card1 extends StatelessWidget {

  final ExploreRecipe recipe;

  const Card1({Key? key, required this.recipe}) : super(key: key);

  /*final String category = 'Editor\'s Choice';
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread.';
  final String chef = 'Ray Wenderlich';*/

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Container(
          //Apply a padding of 16 on all sides of the box. Flutter units are specified in logical pixels, which are like dp on Android.
          padding: const EdgeInsets.all(16),
          //Constrain the container’s size to a width of 350 and a height of 450.
          constraints: const BoxConstraints.expand(width: 350, height: 450),
          //Apply BoxDecoration. This describes how to draw a box.
          decoration: BoxDecoration(
            //In BoxDecoration, set up DecorationImage, which tells the box to paint an image.
            image: DecorationImage(
                //Set which image to paint in the box using an AssetImage, an image found in the starter project assets.
                // image: AssetImage('assets/flour_mix.jpg'),
                 image: AssetImage(recipe.backgroundImage),
                //Cover the entire box with that image.
                fit: BoxFit.cover),
            //Apply a corner radius of 10 to all sides of the container.
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Stack(
          children: [
            Text(recipe.subtitle, style: FooderlichTheme.darkTextTheme.bodyText1),
            Positioned(
              child: Text(
                recipe.title,
                style: FooderlichTheme.darkTextTheme.headline2,
              ),
              top: 20,
            ),
            Positioned(
              child: Text(
                recipe.message,
                style: FooderlichTheme.darkTextTheme.bodyText1,

              ),
              bottom: 30,
              right: 0,
            ),
            Positioned(
              child: Text(
                recipe.authorName,
                style: FooderlichTheme.darkTextTheme.bodyText1,
              ),
              bottom: 10,
              right: 0,
            )
          ],
        ),
      )),
    );
  }
}
