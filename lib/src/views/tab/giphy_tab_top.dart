import 'package:flutter/material.dart';

class GiphyTabTop extends StatefulWidget {
  GiphyTabTop({Key? key}) : super(key: key);

  @override
  State<GiphyTabTop> createState() => _GiphyTabTopState();
}

class _GiphyTabTopState extends State<GiphyTabTop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: 50,
      height: 2,
      color: Theme.of(context).textTheme.bodyLarge!.color!,
    );
  }
}
