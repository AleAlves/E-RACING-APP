import 'package:e_racing_app/core/ext/access_extension.dart';
import 'package:e_racing_app/core/ext/event_iconography_extension.dart';
import 'package:e_racing_app/core/navigation/routes.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_simple_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/membership_action_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/shortcut_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/social_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/tag_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/ext/dialog_extension.dart';
import '../league_detail_view_model.dart';

class LeagueDetailView extends StatefulWidget {
  final LeagueDetailViewModel viewModel;

  const LeagueDetailView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueDetailViewState createState() => _LeagueDetailViewState();
}

class _LeagueDetailViewState extends State<LeagueDetailView>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.getLeague();
    widget.viewModel.getPlayerEvents();
    widget.viewModel.getMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      state: widget.viewModel.state,
      onBackPressed: onBackPressed,
      scrollable: true,
      floatAction: FloatActionButtonWidget(
        icon: Icons.build,
        title: "Edit",
        onPressed: () {
          // widget.viewModel.setFlow(LeagueFlow.edit);
        },
      ),
    );
  }

  @override
  Widget content() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
          child: header(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: panel(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: social(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: playersEvent(),
        ),
        const SpacingWidget(LayoutSize.size64),
      ],
    );
  }

  Widget header() {
    return CardWidget(
      padding: EdgeInsets.zero,
      ready: true,
      child: Column(
        children: [
          BannerWidget(
            media: widget.viewModel.media,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: description(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: membership(),
          ),
        ],
      ),
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: widget.viewModel.league?.name ?? '',
                  style: Style.title,
                  align: TextAlign.left,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWidget(
              text: widget.viewModel.league?.description ?? '',
              style: Style.paragraph,
              align: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget tags() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TagCollectionWidget(
        tagIds: widget.viewModel.league?.tags,
        tags: widget.viewModel.tags,
      ),
    );
  }

  Widget social() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacingWidget(LayoutSize.size16),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: TextWidget(text: "Social media", style: Style.paragraph),
        ),
        const SpacingWidget(LayoutSize.size4),
        SocialCollectionWidget(
          hide: widget.viewModel.league?.links == null,
          links: widget.viewModel.league?.links,
          socialPlatforms: widget.viewModel.socialMedias,
        ),
      ],
    );
  }

  Widget panel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShortcutCollectionWidget(
          shortcuts: widget.viewModel.menus?.toList(),
          onPressed: widget.viewModel.deeplink,
        ),
      ],
    );
  }

  Widget membership() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 8),
      child: MembershipActionWidget(
        leagueModel: widget.viewModel.league,
        onStartMembership: () {
          widget.viewModel.stopMembership();
        },
        onStopMembership: () {
          confirmationDialogExt(
            context: context,
            issueMessage: "Do you wanto to cancel your membership?",
            consentMessage: "Yes, I do",
            onPositive: () {
              widget.viewModel.stopMembership();
            },
          );
        },
        isMember: isLeagueMember(widget.viewModel.league),
      ),
    );
  }

  Widget playersEvent() {
    return widget.viewModel.playerEvents == null
        ? CardWidget(
            child: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
            ),
            ready: false)
        : playerContentWidget();
  }

  Widget playerContentWidget() {
    return widget.viewModel.playerEvents?.isEmpty == true
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpacingWidget(LayoutSize.size16),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextWidget(
                    text: "Your competitions", style: Style.paragraph),
              ),
              const SpacingWidget(LayoutSize.size4),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.viewModel.playerEvents?.length,
                itemBuilder: (context, index) {
                  return EventSimpleCardWidget(
                    icon: getIcon(widget.viewModel.playerEvents?[index]?.type),
                    color:
                        getColor(widget.viewModel.playerEvents?[index]?.type),
                    event: widget.viewModel.playerEvents?[index],
                    onPressed: () {
                      Session.instance.setEventId(
                          widget.viewModel.playerEvents?[index]?.id);
                      Modular.to.pushNamed(Routes.event);
                    },
                  );
                },
              ),
            ],
          );
  }

  @override
  Future<bool> onBackPressed() async {
    // widget.viewModel.setFlow(LeagueFlow.list);
    return true;
  }
}
