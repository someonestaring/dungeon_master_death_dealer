import 'package:flutter/material.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  SearchBodyState createState() => SearchBodyState();
}

class SearchBodyState extends State<SearchBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Search Body',
      ),
    );
  }
}
