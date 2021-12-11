import 'dart:io';

import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../league_view_model.dart';

class LeagueListWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueListWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueListWidgetState createState() => _LeagueListWidgetState();
}

class _LeagueListWidgetState extends State<LeagueListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget("Create league", ButtonType.normal, () {
              widget.viewModel.flow = LeagueFlow.create;
            }),
            Expanded(
              child: Observer(
                builder: (_) {
                  return ListView.builder(
                    itemCount: widget.viewModel.leagues?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.file(
                          File(widget.viewModel.medias?[index].image ?? ''),
                          fit: BoxFit.fill,
                        ),
                        title: TextWidget(
                            widget.viewModel.leagues?[index].name ?? '',
                            Style.label),
                        subtitle: TextWidget(
                            widget.viewModel.leagues?[index].description ?? '',
                            Style.label),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LeagueFlow.list;
    return false;
  }
}
