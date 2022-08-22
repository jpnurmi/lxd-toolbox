import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lxd/lxd.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_widgets/ubuntu_widgets.dart';
import 'package:wizard_router/wizard_router.dart';

import '../terminal/terminal_settings.dart';
import '../widgets/product_logo.dart';
import '../widgets/wizard_page.dart';
import 'launcher_model.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LauncherModel(),
      child: const LauncherPage(),
    );
  }

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    final model = context.read<LauncherModel>();
    model.load(Wizard.of(context).arguments as LxdImage);

    _nameController = TextEditingController(text: model.name);
    _nameController.addListener(() => model.name = _nameController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LauncherModel>();
    final l10n = AppLocalizations.of(context);
    return WizardPage(
      title: Text(l10n.launchInstanceTitle),
      content: RoundedContainer(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(labelText: l10n.nameLabel),
                      validator: (value) {
                        if (value != null && !model.validateName(value)) {
                          return 'Alphanumeric and hyphen characters allowed';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    DropdownButtonFormField<String?>(
                      decoration: const InputDecoration(labelText: 'Theme'),
                      value: model.theme,
                      items: [null, ...terminalThemes.keys].map((theme) {
                        return DropdownMenuItem<String?>(
                          value: theme,
                          child: Text(theme ?? 'default'),
                        );
                      }).toList(),
                      onChanged: (value) => model.theme = value,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductLogo.asset(name: model.os, size: 192),
                    const SizedBox(height: 8),
                    Text(
                      model.os,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: Wizard.of(context).done,
          child: Text(l10n.cancelLabel),
        ),
        OutlinedButton(
          onPressed: () => Wizard.of(context).done(result: model.save()),
          child: Text(l10n.okLabel),
        ),
      ],
    );
  }
}
