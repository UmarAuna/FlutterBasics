
import 'package:flutter/material.dart';
import '../../fooderlich_theme.dart';
import '../models/models.dart';

class Card3 extends StatelessWidget {

  final ExploreRecipe recipe;

  const Card3({Key? key, required this.recipe}): super(key: key);

  List<Widget> createTagChips() {
    final chips = <Widget>[];
    recipe.tags.take(6).forEach(
          (element) {
        final chip = Chip(
          label: Text(
            element,
            style: FooderlichTheme.darkTextTheme.bodyText1,
          ),
          backgroundColor: Colors.black.withOpacity(0.7),
          onDeleted: (){
            print('delete');
          },
        );
        chips.add(chip);
      },
    );

    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(recipe.backgroundImage),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),

        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.book, color: Colors.white, size: 40),
                  const SizedBox(height: 8),
                  Text(
                      recipe.title,
                      style: FooderlichTheme.darkTextTheme.headline2),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            Center(
              child:Wrap(
                alignment: WrapAlignment.start,
                spacing: 12,
                children: createTagChips()
               /* [

                  Chip(
                    label: Text(
                      'Healthy',
                      style: FooderlichTheme.darkTextTheme.bodyText1),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      onDeleted: (){
                        print('delete');
                      },
                    ),

                  Chip(
                    label: Text(
                      'Vegan',
                      style: FooderlichTheme.darkTextTheme.bodyText1),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      onDeleted: (){
                        print('delete');
                      },
                    ),

                  Chip(
                    label: Text(
                      'Carrots',
                      style: FooderlichTheme.darkTextTheme.bodyText1),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      onDeleted: (){
                        print('delete');
                      },
                    ),

                  Chip(
                    label: Text(
                      'Greens',
                      style: FooderlichTheme.darkTextTheme.bodyText1),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      onDeleted: (){
                        print('delete');
                      },
                    ),

                  Chip(
                    label: Text(
                      'Wheat',
                      style: FooderlichTheme.darkTextTheme.bodyText1),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      onDeleted: (){
                        print('delete');
                      },
                    ),

                  Chip(
                    label: Text(
                      'Pescetarian',
                      style: FooderlichTheme.darkTextTheme.bodyText1),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      onDeleted: (){
                        print('delete');
                      },
                    ),

                  Chip(
                    label: Text(
                      'Mint',
                      style: FooderlichTheme.darkTextTheme.bodyText1),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      onDeleted: (){
                        print('delete');
                      },
                    ),

                  Chip(
                    label: Text(
                      'Lemongrass',
                      style: FooderlichTheme.darkTextTheme.bodyText1),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      onDeleted: (){
                        print('delete');
                      },
                    ),
                ],*/
              )
            )
          ],
        ),
      ),
    );
  }

}