import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/country_picker_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/profile/presentation/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/component/ui/tag_collection_widget.dart';
import '../../../core/ui/component/ui/text_widget.dart';

class ProfileUpdateView extends StatefulWidget {
  final ProfileViewModel viewModel;

  const ProfileUpdateView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _ProfileUpdateViewState createState() => _ProfileUpdateViewState();
}

class _ProfileUpdateViewState extends State<ProfileUpdateView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  late String password = "";
  late String? country = "BR";
  bool hasChanges = false;

  @override
  void initState() {
    widget.viewModel.fetchProfile();
    _nameController.addListener(observers);
    _surnameController.addListener(observers);
    _nameController.text = widget.viewModel.profileModel?.name ?? '';
    _surnameController.text = widget.viewModel.profileModel?.surname ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        body: content(),
        bottom: buttonUpdateWidget(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size128),
        titleWidget(),
        const SpacingWidget(LayoutSize.size48),
        Form(
          child: profileForm(),
          key: _formKey,
        ),
        tagsWidget()
      ],
    );
  }

  Widget titleWidget() {
    return const TextWidget(
        text: "You can update your basic information", style: Style.subtitle);
  }

  Widget profileForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              InputTextWidget(
                  enabled: true,
                  label: 'Name',
                  icon: Icons.person,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty == true) {
                      return 'valid name needed';
                    }
                    return null;
                  }),
              const SpacingWidget(LayoutSize.size16),
              InputTextWidget(
                  enabled: true,
                  label: 'Surname',
                  icon: Icons.person,
                  controller: _surnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty == true) {
                      return 'valid surname needed';
                    }
                    return null;
                  }),
              const SpacingWidget(LayoutSize.size16),
              CountryPickerWidget(
                country: widget.viewModel.profileModel?.country,
                onCountrySelected: (code) {
                  setState(() {
                    country = code;
                    hasChanges = hasAnyChange();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tagsWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TagCollectionWidget(
        tagIds: widget.viewModel.profileModel?.tags,
        tags: widget.viewModel.tags,
      ),
    );
  }

  Widget buttonUpdateWidget() {
    return ButtonWidget(
      enabled: hasChanges,
      type: ButtonType.primary,
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          widget.viewModel.update(
              _nameController.text, _surnameController.text, country ?? '');
        }
      },
      label: "Update",
    );
  }

  bool hasAnyChange() {
    return widget.viewModel.profileModel?.name != _nameController.text ||
        widget.viewModel.profileModel?.surname != _surnameController.text ||
        widget.viewModel.profileModel?.country != country;
  }

  @override
  observers() {
    _nameController.addListener(() {
      setState(() {
        hasChanges = hasAnyChange();
      });
    });
    _surnameController.addListener(() {
      setState(() {
        hasChanges = hasAnyChange();
      });
    });
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }
}
