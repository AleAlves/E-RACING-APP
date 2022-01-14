import 'dart:convert';

import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/league_item_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/shortcut_widget.dart';
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
  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed,
        scrollable: true);
  }

  @override
  void initState() {
    widget.viewModel.getLeague();
    super.initState();
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        banner(),
        description(),
        social(),
        panel(),
      ],
    );
  }

  Widget banner() {
    return widget.viewModel.media == null
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: LoadingShimmer(
              height: 200,
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.memory(
                    base64Decode(widget.viewModel.media?.image ?? ''),
                    fit: BoxFit.fill,
                  )),
            ),
          );
  }

  Widget description() {
    return ClassExpandedCardHolderWidget(
      ready: widget.viewModel.league != null,
      header: TextWidget(
        widget.viewModel.league?.name ?? '',
        Style.title,
        align: TextAlign.left,
      ),
      body: [
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
    return CardWidget(
      ready: widget.viewModel.league != null,
      placeholderHeight: 100,
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Wrap(
              spacing: 10.0,
              children: widget.viewModel.league == null
                  ? [Container()]
                  : widget.viewModel.league!.links!
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
      ),
    );
  }

  Widget panel() {
    return CardWidget(
        child: Row(
          children: [
            ShortcutWidget(
              onPressed: () {},
            ),
            ShortcutWidget(
              onPressed: () {},
            ),
            ShortcutWidget(
              onPressed: () {},
            ),
            ShortcutWidget(
              onPressed: () {},
            ),
            ShortcutWidget(
              onPressed: () {},
            ),
          ],
        ),
        onPressed: () {},
        ready: true);
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

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
