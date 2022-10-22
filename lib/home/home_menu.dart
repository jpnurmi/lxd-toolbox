import 'package:context_menu/context_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workshops/intents.dart';

List<PopupMenuEntry> buildHomeMenu({
  required BuildContext context,
}) {
  final l10n = AppLocalizations.of(context);
  return <PopupMenuEntry>[
    ContextMenuItem(
      onTap: Actions.handler(context, const AddTabIntent()),
      enabled: Actions.find<AddTabIntent>(context).isActionEnabled,
      child: Text(l10n.newTabMenuItem),
    ),
    ContextMenuItem(
      onTap: Actions.handler(context, const CloseTabIntent()),
      enabled: Actions.find<CloseTabIntent>(context).isActionEnabled,
      child: Text(l10n.closeTabMenuItem),
    ),
  ];
}
