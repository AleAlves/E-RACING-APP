import 'dart:convert';

import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/shortcut_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/social_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/tag_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
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
          padding: const EdgeInsets.all(16.0),
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
    return TagCollectionWidget(
      tagIds: widget.viewModel.league?.tags,
      tags: widget.viewModel.tags,
    );
  }

  Widget social() {
    return SocialCollectionWidget(
      links: widget.viewModel.league?.links,
      socialPlatforms: widget.viewModel.socialMedias,
    );
  }

  Widget panel() {
    return ShortcutCollectionWidget(
      shortcuts: widget.viewModel.menus?.toList(),
      onPressed: widget.viewModel.deeplink,
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
