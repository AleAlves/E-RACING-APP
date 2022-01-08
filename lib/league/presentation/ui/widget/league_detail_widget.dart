import 'dart:convert';

import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_holder_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:e_racing_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeagueDetailWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueDetailWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueDetailWidgetState createState() => _LeagueDetailWidgetState();
}

class _LeagueDetailWidgetState extends State<LeagueDetailWidget>
    implements BaseSateWidget {
  bool _expanded = false;

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
            onBackPressed: _onBackPressed,
            scrollable: true);
      },
    );
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [banner(), description(), social()],
    );
  }

  Widget banner() {
    return ClipRRect(
      child: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Image.memory(
            base64Decode(widget.viewModel.media?.image ?? ''),
            fit: BoxFit.fill,
          )),
    );
  }

  Widget description() {
    return CardHolderWidget(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ExpansionTile(
                      title: TextWidget(
                        widget.viewModel.league?.name ?? '',
                        Style.title,
                        align: TextAlign.start,
                      ),
                      children: [
                        const BoundWidget(BoundType.medium),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            widget.viewModel.league?.description ?? '',
                            Style.description,
                            align: TextAlign.justify,
                          ),
                        ),
                        tags(),
                      ],
                      trailing: Ink(
                        decoration: const ShapeDecoration(
                          color: ERcaingApp.color,
                          shape: CircleBorder(),
                        ),
                        child: _expanded
                            ? const Icon(
                                Icons.keyboard_arrow_up_outlined,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => _expanded = expanded);
                      }),
                ],
              ),
            ),
          )
        ],
      ),
      onPressed: () {},
    );
  }

  Widget tags() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 5.0,
          children: widget.viewModel.tags!
              .map((item) {
                return ActionChip(
                  label: Text(item?.name ?? ''),
                  onPressed: () {},
                );
              })
              .toList()
              .cast<Widget>(),
        ),
      ],
    );
  }

  Widget social() {
    return CardHolderWidget(
      onPressed: () {},
      child: Row(
        children: [
          Wrap(
            spacing: 10.0,
            children: widget.viewModel.league!.links!
                .map((item) {
                  return Column(
                    children: [
                      ButtonWidget(
                        type: ButtonType.icon,
                        onPressed: () {},
                        icon: _getIcon(item?.platformId),
                        label: widget.viewModel.socialMedias
                                ?.firstWhere((element) =>
                                    element?.id == item?.platformId)
                                ?.name ??
                            '',
                      ),
                    ],
                  );
                })
                .toList()
                .cast<Widget>(),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String? platformId) {
    var index = widget.viewModel.socialMedias
        ?.firstWhere((element) => element?.id == platformId)
        ?.name
        .toLowerCase();
    switch (index) {
      case "whatsapp":
        return FontAwesomeIcons.whatsapp;
      case "discord":
        return FontAwesomeIcons.discord;
      case "site":
      default:
        return FontAwesomeIcons.globe;
    }
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
