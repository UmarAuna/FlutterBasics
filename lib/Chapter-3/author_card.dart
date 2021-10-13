
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';

import 'cirlce_image.dart';

class AuthorCard extends StatefulWidget {

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
  _AuthorCardState createState() => _AuthorCardState();
}
//The refactor also created the _AuthorCardState state class. It stores mutable data that can change over the lifetime of the widget.
class _AuthorCardState extends State<AuthorCard> {
  bool _isFavorited = false;

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
              CircleImage(imageProvider: widget.imageProvider, imageRadius: 28,),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.authorName!,
                  style: FooderlichTheme.lightTextTheme.headline2,),
                  Text(widget.title!,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  )
                ],
              )

            ],),
            IconButton(
              icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
              iconSize: 30,
              color: Colors.red[400],
              onPressed: () {
                // const snackBar = SnackBar(content: Text('Press Favourite'));
               // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() {
                  _isFavorited = !_isFavorited;
                });
              },
            )
          ],
        )
      );
  }
}