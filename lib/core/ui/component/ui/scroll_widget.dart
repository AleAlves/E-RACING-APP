import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  final String title;
  final Widget body;

  const ScrollWidget(this.title, this.body, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title)
            ),
          ),
        ];
      },
      body: body,
    );
  }
}
