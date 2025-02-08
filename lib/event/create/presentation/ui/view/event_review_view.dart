import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/scoring_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';

class EventReviewView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventReviewView(this.viewModel, {super.key});

  @override
  EventReviewViewState createState() => EventReviewViewState();
}

class EventReviewViewState extends State<EventReviewView>
    implements BaseSateWidget {
  bool termsAccepted = false;

  @override
  void initState() {
    observers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainObserver();
  }

  @override
  Observer mainObserver() {
    return Observer(builder: (_) => viewState());
  }

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: buttonWidget(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacingWidget(LayoutSize.size24),
        title(),
        const SpacingWidget(LayoutSize.size8),
        banner(),
        const SpacingWidget(LayoutSize.size8),
        name(),
        const SpacingWidget(LayoutSize.size8),
        rules(),
        const SpacingWidget(LayoutSize.size8),
        optionsWidget(),
        const SpacingWidget(LayoutSize.size8),
        classes(),
        const SpacingWidget(LayoutSize.size8),
        tagWidget(),
        const SpacingWidget(LayoutSize.size8),
        scoringWidget(),
        const SpacingWidget(LayoutSize.size8),
        acceptance(),
        const SpacingWidget(LayoutSize.size96),
      ],
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const TextWidget(
        text: "Review",
        style: Style.title,
        align: TextAlign.start,
      ),
    );
  }

  Widget name() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const TextWidget(
            text: "Event name",
            style: Style.subtitle,
            align: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidget(
            text: widget.viewModel.eventName,
            style: Style.paragraph,
            align: TextAlign.start,
          ),
        )
      ],
    );
  }

  Widget scoringWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const TextWidget(
            text: "Score board",
            style: Style.subtitle,
            align: TextAlign.start,
          ),
        ),
        ScoringWidget(editing: false, scoring: widget.viewModel.eventScore)
      ],
    );
  }

  Widget tagWidget() {
    return widget.viewModel.tags!.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const TextWidget(
                  text: "Tags",
                  style: Style.subtitle,
                  align: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: widget.viewModel.tags!
                      .where((e) => widget.viewModel.eventTags.contains(e?.id))
                      .map((item) {
                        return Padding(
                          padding: EdgeInsets.all(2),
                          child: ActionChip(
                              label: Text(item?.name ?? ''), onPressed: () {}),
                        );
                      })
                      .toList()
                      .cast<Widget>(),
                ),
              )
            ],
          );
  }

  Widget rules() {
    return (widget.viewModel.eventRules?.isNotEmpty ?? false)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const TextWidget(
                  text: "Rules",
                  style: Style.subtitle,
                  align: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextWidget(
                  text: widget.viewModel.eventRules ?? '',
                  style: Style.paragraph,
                  align: TextAlign.justify,
                ),
              ),
              const SpacingWidget(LayoutSize.size16),
            ],
          )
        : Container();
  }

  Widget optionsWidget() {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: widget.viewModel.eventAllowTeams,
              onChanged: null,
            ),
            const TextWidget(text: "Racing teams", style: Style.paragraph)
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: widget.viewModel.eventAllowMembersOnly,
              onChanged: null,
            ),
            const TextWidget(text: "Members only", style: Style.paragraph)
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: widget.viewModel.hasFee,
              onChanged: null,
            ),
            const TextWidget(text: "Registration fee", style: Style.paragraph)
          ],
        )
      ],
    );
  }

  Widget classes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const TextWidget(
            text: "Class/Category",
            style: Style.subtitle,
            align: TextAlign.start,
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.viewModel.eventClasses.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextWidget(
                          text:
                              " ${widget.viewModel.eventClasses[index]?.name} : ${widget.viewModel.eventClasses[index]?.maxEntries.toString()} ",
                          style: Style.paragraph),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget banner() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.height,
            child: Image.memory(
              base64Decode(widget.viewModel.eventBanner ?? ''),
              fit: BoxFit.fill,
            )),
      ),
    );
  }

  Widget acceptance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const TextWidget(
            text: "All set?",
            style: Style.subtitle,
            align: TextAlign.start,
          ),
        ),
        Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: termsAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      termsAccepted = !termsAccepted;
                    });
                  },
                ),
                Wrap(
                  children: const [
                    TextWidget(text: "Yes, ready to proceed", style: Style.caption),
                  ],
                )
              ],
            ))
      ],
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: termsAccepted,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.createEvent();
      },
      label: "Create Draft",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep();
    return false;
  }
}
