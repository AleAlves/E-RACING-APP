import 'dart:convert';

import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_holder_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';

class LeagueDetailWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueDetailWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueDetailWidgetState createState() => _LeagueDetailWidgetState();
}

class _LeagueDetailWidgetState extends State<LeagueDetailWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.getLeague();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ViewStateWidget(
            content: content(),
            state: widget.viewModel.state,
            onBackPressed: _onBackPressed);
      },
    );
  }

  @override
  Widget content() {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.memory(
                base64Decode(widget.viewModel.media?.image ?? ''),
                fit: BoxFit.fill,
              )),
        ),
        CardHolderWidget(
          widget: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextWidget(
                        widget.viewModel.league?.name ?? '',
                        Style.title,
                        align: TextAlign.center,
                      ),
                      const BoundWidget(BoundType.medium),
                      TextWidget(
                        widget.viewModel.league?.description ?? '',
                        Style.description,
                        align: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: widget.viewModel.tags!
                    .map((item) {
                      return  ActionChip(
                        label: Text(item?.name ?? ''),
                        onPressed: () {},
                      );
                    })
                    .toList()
                    .cast<Widget>(),
              ),
            ],
          ),
        )
      ],
    ));
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
