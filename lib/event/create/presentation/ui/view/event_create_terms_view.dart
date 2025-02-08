import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../event_create_view_model.dart';

class EventCreateTermsView extends StatefulWidget {
  final EventCreateViewModel viewModel;

  const EventCreateTermsView(this.viewModel, {super.key});

  @override
  EventCreateTermsViewState createState() => EventCreateTermsViewState();
}

class EventCreateTermsViewState extends State<EventCreateTermsView>
    implements BaseSateWidget {
  var isValid = false;
  bool termsAccepted = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    observers();
    super.initState();
    _nameController.addListener(observers);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpacingWidget(LayoutSize.size24),
          title(),
          const SpacingWidget(LayoutSize.size16),
          content()
        ],
      ),
      bottom: acceptButtonWidget(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const TextWidget(
        text: "Terms & Agreements",
        style: Style.title,
        align: TextAlign.start,
      ),
    );
  }

  @override
  Widget content() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: TextWidget(
            text:
                "Terms and Agreement for Racing Community Welcome to the Racing Community! By accessing or using any services provided by the Racing Community, you agree to be bound by these terms and agreement. Please read them carefully before proceeding."
                "Eligibility: You must be 18 years of age or older to access or use the Racing Community services."
                "Account: You must create an account to access the Racing Community services. You agree to provide accurate and complete information when creating an account. You are responsible for maintaining the confidentiality of your account information and password."
                "Conduct: You agree to use the Racing Community services only for lawful purposes and in a manner consistent with these terms and agreement. You agree not to engage in any conduct that could damage, disable, overburden, or impair the Racing Community services."
                "Content: You are solely responsible for any content you post, upload, or share on the Racing Community services. You agree not to post, upload, or share any content that is unlawful, obscene, defamatory, or otherwise objectionable."
                "Intellectual Property: The Racing Community services and all content included on or within the Racing Community services, such as text, graphics, logos, images, audio clips, video, data, music, software, and other material, are owned or licensed by the Racing Community and are protected by copyright, trademark, patent, or other proprietary rights and laws."
                "Disclaimer: The Racing Community services are provided on an 'as is' and 'as available' basis. The Racing Community does not guarantee the accuracy, completeness, or usefulness of any information on the Racing Community services."
                "Limitation of Liability: The Racing Community will not be liable for any damages arising from the use or inability to use the Racing Community services, including but not limited to direct, indirect, incidental, punitive, and consequential damages"
                "Indemnification: You agree to indemnify, defend, and hold harmless the Racing Community and its affiliates, officers, directors, employees, agents, licensors, and suppliers from and against all claims, losses, expenses, damages, and costs, including reasonable attorneys' fees, arising from your use of the Racing Community services."
                "Termination: The Racing Community reserves the right to terminate your account and access to the Racing Community services at any time and for any reason without prior notice."
                "Modification: The Racing Community may modify these terms and agreement at any time without prior notice. Your continued use of the Racing Community services after such modifications will constitute your agreement to the modified terms and agreement."
                "Governing Law: These terms and agreement shall be governed by and construed in accordance with the laws of the state where the Racing Community is based, without giving effect to any principles of conflicts of law."
                "Entire Agreement: These terms and agreement constitute the entire agreement between you and the Racing Community regarding the use of the Racing Community services."
                "If you have any questions or concerns regarding these terms and agreement, please contact us at [contact email]."
                "Terms and Agreement for Racing Community Welcome to the Racing Community! By accessing or using any services provided by the Racing Community, you agree to be bound by these terms and agreement. Please read them carefully before proceeding."
                "Eligibility: You must be 18 years of age or older to access or use the Racing Community services."
                "Account: You must create an account to access the Racing Community services. You agree to provide accurate and complete information when creating an account. You are responsible for maintaining the confidentiality of your account information and password."
                "Conduct: You agree to use the Racing Community services only for lawful purposes and in a manner consistent with these terms and agreement. You agree not to engage in any conduct that could damage, disable, overburden, or impair the Racing Community services."
                "Content: You are solely responsible for any content you post, upload, or share on the Racing Community services. You agree not to post, upload, or share any content that is unlawful, obscene, defamatory, or otherwise objectionable."
                "Intellectual Property: The Racing Community services and all content included on or within the Racing Community services, such as text, graphics, logos, images, audio clips, video, data, music, software, and other material, are owned or licensed by the Racing Community and are protected by copyright, trademark, patent, or other proprietary rights and laws."
                "Disclaimer: The Racing Community services are provided on an 'as is' and 'as available' basis. The Racing Community does not guarantee the accuracy, completeness, or usefulness of any information on the Racing Community services."
                "Limitation of Liability: The Racing Community will not be liable for any damages arising from the use or inability to use the Racing Community services, including but not limited to direct, indirect, incidental, punitive, and consequential damages"
                "Indemnification: You agree to indemnify, defend, and hold harmless the Racing Community and its affiliates, officers, directors, employees, agents, licensors, and suppliers from and against all claims, losses, expenses, damages, and costs, including reasonable attorneys' fees, arising from your use of the Racing Community services."
                "Termination: The Racing Community reserves the right to terminate your account and access to the Racing Community services at any time and for any reason without prior notice."
                "Modification: The Racing Community may modify these terms and agreement at any time without prior notice. Your continued use of the Racing Community services after such modifications will constitute your agreement to the modified terms and agreement."
                "Governing Law: These terms and agreement shall be governed by and construed in accordance with the laws of the state where the Racing Community is based, without giving effect to any principles of conflicts of law."
                "Entire Agreement: These terms and agreement constitute the entire agreement between you and the Racing Community regarding the use of the Racing Community services."
                "If you have any questions or concerns regarding these terms and agreement, please contact us at [contact email]."
                "Terms and Agreement for Racing Community Welcome to the Racing Community! By accessing or using any services provided by the Racing Community, you agree to be bound by these terms and agreement. Please read them carefully before proceeding."
                "Eligibility: You must be 18 years of age or older to access or use the Racing Community services."
                "Account: You must create an account to access the Racing Community services. You agree to provide accurate and complete information when creating an account. You are responsible for maintaining the confidentiality of your account information and password."
                "Conduct: You agree to use the Racing Community services only for lawful purposes and in a manner consistent with these terms and agreement. You agree not to engage in any conduct that could damage, disable, overburden, or impair the Racing Community services."
                "Content: You are solely responsible for any content you post, upload, or share on the Racing Community services. You agree not to post, upload, or share any content that is unlawful, obscene, defamatory, or otherwise objectionable."
                "Intellectual Property: The Racing Community services and all content included on or within the Racing Community services, such as text, graphics, logos, images, audio clips, video, data, music, software, and other material, are owned or licensed by the Racing Community and are protected by copyright, trademark, patent, or other proprietary rights and laws."
                "Disclaimer: The Racing Community services are provided on an 'as is' and 'as available' basis. The Racing Community does not guarantee the accuracy, completeness, or usefulness of any information on the Racing Community services."
                "Limitation of Liability: The Racing Community will not be liable for any damages arising from the use or inability to use the Racing Community services, including but not limited to direct, indirect, incidental, punitive, and consequential damages"
                "Indemnification: You agree to indemnify, defend, and hold harmless the Racing Community and its affiliates, officers, directors, employees, agents, licensors, and suppliers from and against all claims, losses, expenses, damages, and costs, including reasonable attorneys' fees, arising from your use of the Racing Community services."
                "Termination: The Racing Community reserves the right to terminate your account and access to the Racing Community services at any time and for any reason without prior notice."
                "Modification: The Racing Community may modify these terms and agreement at any time without prior notice. Your continued use of the Racing Community services after such modifications will constitute your agreement to the modified terms and agreement."
                "Governing Law: These terms and agreement shall be governed by and construed in accordance with the laws of the state where the Racing Community is based, without giving effect to any principles of conflicts of law."
                "Entire Agreement: These terms and agreement constitute the entire agreement between you and the Racing Community regarding the use of the Racing Community services."
                "If you have any questions or concerns regarding these terms and agreement, please contact us at [contact email].",
            style: Style.paragraph,
            align: TextAlign.justify,
          ),
        ),
        const SpacingWidget(LayoutSize.size48),
        acceptanceCheckbox(),
        const SpacingWidget(LayoutSize.size96),
      ],
    );
  }

  Widget acceptanceCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
            TextWidget(
                text: "I did read the terms and I agree", style: Style.caption),
          ],
        )
      ],
    );
  }

  Widget acceptButtonWidget() {
    return ButtonWidget(
        enabled: termsAccepted,
        label: "Accept and continue",
        type: ButtonType.primary,
        onPressed: () {
          widget.viewModel.increaseStep();
          widget.viewModel.setAgreement(termsAccepted);
        });
  }

  @override
  observers() {
    setState(() {
      isValid = _formKey.currentState?.validate() == true;
    });
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }
}
