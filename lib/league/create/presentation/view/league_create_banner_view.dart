import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../league_create_view_model.dart';
import '../navigation/league_create_flow.dart';

class LeagueCreateBannerView extends StatefulWidget {
  final LeagueCreateViewModel viewModel;

  const LeagueCreateBannerView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateBannerViewState createState() => _LeagueCreateBannerViewState();
}

class _LeagueCreateBannerViewState extends State<LeagueCreateBannerView>
    implements BaseSateWidget {
  var isSwitched = false;
  File bannerFile = File('');
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    observers();
    super.initState();
    widget.viewModel.fetchTerms();
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
      scrollable: false,
      onBackPressed: onBackPressed,
      state: ViewState.ready,
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
          bannerPicker(),
          const SpacingWidget(LayoutSize.size16),
          imageSizeHint()
        ],
      ),
    );
  }

  Widget guideLines() {
    return const TextWidget(
        text: "Pick a banner for you league, this is welcome card",
        style: Style.subtitle);
  }

  Widget imageSizeHint() {
    return const TextWidget(
      text: "Image suggested size: 700x100",
      style: Style.caption,
      align: TextAlign.start,
    );
  }

  Widget bannerPicker() {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.height,
            child: bannerFile.path.isEmpty
                ? widget.viewModel.banner == null
                    ? Container()
                    : Image.memory(
                        base64Decode(widget.viewModel.banner ?? ''),
                        fit: BoxFit.fill,
                      )
                : Image.file(
                    bannerFile,
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        ButtonWidget(
            type: ButtonType.iconButton,
            icon: Icons.image_search,
            enabled: true,
            onPressed: () async {
              var image = await _picker.pickImage(source: ImageSource.gallery);
              setState(() {
                bannerFile = File(image?.path ?? '');

                var raw = base64Encode(bannerFile.readAsBytesSync());
                widget.viewModel.setBanner(raw);
              });
            })
      ],
    );
  }

  Widget button() {
    return ButtonWidget(
      enabled: bannerFile.path.isNotEmpty || widget.viewModel.banner != null,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.onRoute(LeagueCreateNavigator.tags);
      },
      label: "Next",
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onRoute(LeagueCreateNavigator.description);
    return false;
  }
}
