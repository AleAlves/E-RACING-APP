import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ext/color_extensions.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/trophies/domain/model/podium_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../core/ui/component/ui/text_widget.dart';
import '../league_trophies_view_model.dart';

class LeagueTrophiesView extends StatefulWidget {
  final LeagueTrophiesViewModel viewModel;

  const LeagueTrophiesView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueTrophiesViewState createState() => _LeagueTrophiesViewState();
}

class _LeagueTrophiesViewState extends State<LeagueTrophiesView>
    implements BaseSateWidget {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getTrophies();
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
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }

  @override
  Widget content() {
    return widget.viewModel.podiums == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: trophiesList(),
          );
  }

  Widget trophiesList() {
    return widget.viewModel.podiums?.isEmpty == true
        ? emptyBoxWidget()
        : trophiesWidget();
  }

  Widget trophiesWidget() {
    return Wrap(
      children: widget.viewModel.podiums!
          .map((podium) {
            return CardWidget(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: podiumWidget(podium),
              ),
              ready: true,
              onPressed: () {
                widget.viewModel.gotToEvent(podium?.eventId);
              },
            );
          })
          .toList()
          .cast<Widget>(),
    );
  }

  Widget podiumWidget(PodiumModel? podium) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            children: [
              TextWidget(
                text: podium?.eventName,
                style: Style.subtitle,
              ),
            ],
          ),
        ),
        const SpacingWidget(LayoutSize.size8),
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            children: [
              TextWidget(
                text: podium?.className,
                style: Style.caption,
              ),
            ],
          ),
        ),
        const SpacingWidget(LayoutSize.size16),
        podiumIndex(podium)
      ],
    );
  }

  Widget podiumIndex(PodiumModel? podium) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: MediaQuery.of(context).size.width * 0.07,
                  color: getPodiumColor(1).first,
                  child: TextWidget(
                    text: "1",
                    style: Style.caption,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SpacingWidget(LayoutSize.size16),
                TextWidget(
                  text:
                      "${podium?.firstPlace?.profile?.firstName} ${podium?.firstPlace?.profile?.surName}",
                  style: Style.paragraph,
                  align: TextAlign.start,
                ),
              ],
            ),
            CountryCodePicker(
              onChanged: print,
              padding: EdgeInsets.zero,
              showCountryOnly: true,
              enabled: false,
              initialSelection: podium?.firstPlace?.profile?.country,
              hideMainText: true,
              showFlagMain: true,
              showFlag: false,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: MediaQuery.of(context).size.width * 0.07,
                  color: getPodiumColor(2).first,
                  child: TextWidget(
                    text: "2",
                    style: Style.caption,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SpacingWidget(LayoutSize.size16),
                TextWidget(
                  text:
                      "${podium?.secondPlace?.profile?.firstName} ${podium?.secondPlace?.profile?.surName}",
                  style: Style.paragraph,
                  align: TextAlign.start,
                ),
              ],
            ),
            CountryCodePicker(
              onChanged: print,
              padding: EdgeInsets.zero,
              showCountryOnly: true,
              enabled: false,
              initialSelection: podium?.secondPlace?.profile?.country,
              hideMainText: true,
              showFlagMain: true,
              showFlag: false,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: MediaQuery.of(context).size.width * 0.07,
                  color: getPodiumColor(3).first,
                  child: TextWidget(
                    text: "3",
                    style: Style.caption,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SpacingWidget(LayoutSize.size16),
                TextWidget(
                  text:
                      "${podium?.thirdPlace?.profile?.firstName} ${podium?.thirdPlace?.profile?.surName}",
                  style: Style.paragraph,
                  align: TextAlign.start,
                ),
              ],
            ),
            CountryCodePicker(
              onChanged: print,
              padding: EdgeInsets.zero,
              showCountryOnly: true,
              enabled: false,
              initialSelection: podium?.thirdPlace?.profile?.country,
              hideMainText: true,
              showFlagMain: true,
              showFlag: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget emptyBoxWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SpacingWidget(LayoutSize.size256),
          const TextWidget(
            text: "No trophies yet",
            style: Style.title,
          ),
          const SpacingWidget(LayoutSize.size24),
          Icon(
            Icons.playlist_remove_outlined,
            size: 56,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
