
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';

import 'cirlce_image.dart';

class AuthorCard extends StatelessWidget {

  final String? authorName;
  final String? title;
  final ImageProvider? imageProvider;

  const AuthorCard({
    Key? key,
    this.authorName,
    this.title,
    this.imageProvider,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          //give spaces between two items, This adds extra space
          //evenly between the outer row’s children, placing the IconButton at the far right of
          // the screen.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              CircleImage(imageProvider: imageProvider, imageRadius: 28,),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(authorName!,
                  style: FooderlichTheme.lightTextTheme.headline2,),
                  Text(title!,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  )
                ],
              )

            ],),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              iconSize: 30,
              color: Colors.grey[200],
              onPressed: () {
                const snackBar = SnackBar(content: Text('Press Favourite'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            )
          ],
        )
      );
  }
}