import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shimmer/shimmer.dart';

import '../../../main.dart';
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
            Shimmer.fromColors(
                baseColor: ERcaingApp.color[10] as Color,
                highlightColor: ERcaingApp.color[20] as Color,
                child: Container(
                  height: 60.0,
                  width: 80.0,
                  color: Colors.white,
                )),
            Expanded(
              child: Observer(
                builder: (_) {
                  return ListView.builder(
                    itemCount: widget.viewModel.leagues?.length,
                    itemBuilder: (context, index) {
                      return CardWidget(
                          widget.viewModel.leagues?[index]?.name,
                          widget.viewModel.medias?[index]?.image
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
