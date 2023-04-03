import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/model/link_model.dart';
import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/dropdown_menu_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../league_create_view_model.dart';
import '../../navigation/league_create_flow.dart';

class LeagueCreateSocialMediaView extends StatefulWidget {
  final LeagueCreateViewModel viewModel;

  const LeagueCreateSocialMediaView(this.viewModel, {Key? key})
      : super(key: key);

  @override
  _LeagueCreateSocialMediaViewState createState() =>
      _LeagueCreateSocialMediaViewState();
}

class _LeagueCreateSocialMediaViewState
    extends State<LeagueCreateSocialMediaView> implements BaseSateWidget {
  List<LinkModel?> socialPlatforms = [];
  List<TextEditingController> socialControllers = [];

  @override
  void initState() {
    observers();
    super.initState();
    widget.viewModel.fetchSocialMedias();
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
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: button(),
      scrollable: true,
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          guideLines(),
          const SpacingWidget(LayoutSize.size48),
          socialPicker()
        ],
      ),
    );
  }

  @override
  observers() {}

  Widget guideLines() {
    return const TextWidget(
        text: "You can add the links to social media stuff",
        style: Style.subtitle);
  }

  Widget socialPicker() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: socialPlatforms.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      DropdownMenuWidget(
                        widget.viewModel.socialMedias,
                        (item) {
                          socialPlatforms[index]?.platformId = item?.id;
                          socialPlatforms[index]?.link =
                              socialControllers[index].text;
                        },
                        hint: "Platform",
                        currentModel: null,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputTextWidget(
                            enabled: true,
                            label: "Link",
                            icon: Icons.add_link,
                            controller: socialControllers[index],
                            validator: (value) {
                              socialPlatforms[index]?.link =
                                  socialControllers[index].text;
                              return null;
                            }),
                      ),
                      const SpacingWidget(LayoutSize.size8),
                      ButtonWidget(
                          enabled: true,
                          type: ButtonType.iconButton,
                          onPressed: () async {
                            Clipboard.getData(Clipboard.kTextPlain)
                                .then((value) {
                              var paste =
                                  value?.text?.trim().replaceAll(' ', '') ?? '';
                              socialPlatforms[index]?.link = paste;
                              socialControllers[index].text = paste;
                            });
                          },
                          label: 'paste',
                          icon: Icons.paste),
                      const SpacingWidget(LayoutSize.size8),
                      ButtonWidget(
                          enabled: true,
                          type: ButtonType.iconButton,
                          onPressed: () async {
                            setState(() {
                              socialPlatforms.removeAt(index);
                              socialControllers.removeAt(index);
                            });
                          },
                          label: 'delete',
                          icon: Icons.delete),
                    ],
                  ),
                ],
              );
            },
          ),
          const SpacingWidget(LayoutSize.size32),
          ButtonWidget(
              enabled: true,
              icon: Icons.add,
              type: ButtonType.iconButton,
              onPressed: () async {
                setState(() {
                  socialPlatforms.add(LinkModel('', ''));
                  socialControllers.add(TextEditingController());
                });
              },
              label: 'New media'),
        ],
      ),
    );
  }

  Widget button() {
    return ButtonWidget(
      enabled: socialPlatforms.isNotEmpty,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.setSocialMedia(socialPlatforms);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(LeagueCreateNavigator.tags);
    return false;
  }
}
