import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lxd_x/lxd_x.dart';
import 'package:movable_tabs/movable_tabs.dart';
import 'package:os_logo/os_logo.dart';
import 'package:provider/provider.dart';
import 'package:snapd/snapd.dart';

import '../home/home_page.dart';
import '../home/quick_menu.dart';
import '../snap/snap_banner.dart';
import '../terminal/terminal_page.dart';
import 'tab_actions.dart';
import 'tab_commands.dart';
import 'tab_intents.dart';
import 'tab_item.dart';
import 'tab_model.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TabModel(),
      child: const TabPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final model = context.watch<TabModel>();
    return TabCommands(
      child: TabActions(
        child: Focus(
          autofocus: true,
          child: Scaffold(
            appBar: MovableTabBar(
              count: model.tabs.length,
              builder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: model.tabs[index],
                  builder: (context, child) {
                    final tab = context.watch<TabItem>();
                    return MovableTabButton(
                      selected: index == model.currentIndex,
                      onPressed: () => model.currentIndex = index,
                      onClosed: Actions.handler(
                        context,
                        CloseTabIntent(index),
                      ),
                      icon: tab.instance != null
                          ? OsLogo.asset(
                              name: tab.instance!.os,
                              size: 32,
                            )
                          : null,
                      label: Text(tab.instance?.name ?? l10n.homeTab),
                    );
                  },
                );
              },
              trailing: Builder(
                builder: (context) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      splashRadius: 16,
                      iconSize: 16,
                      onPressed: Actions.handler(context, const AddTabIntent()),
                    ),
                    const SizedBox(width: 2),
                    QuickMenuButton(
                      onSelected: (instance) {
                        Actions.maybeInvoke(context, AddTabIntent(instance));
                      },
                    ),
                  ],
                ),
              ),
              onMoved: (from, to) {
                Actions.invoke(context, MoveTabIntent(from, to));
              },
              preferredHeight: Theme.of(context).appBarTheme.toolbarHeight,
            ),
            body: SnapBanner(
              connection: const SnapConnection(
                interface: 'lxd',
                plug: SnapPlug(snap: 'workshops', plug: 'lxd'),
                slot: SnapSlot(snap: 'lxd', slot: 'lxd'),
              ),
              child: IndexedStack(
                index: model.currentIndex,
                children: [
                  for (final tab in model.tabs)
                    ChangeNotifierProvider.value(
                      value: tab,
                      key: ValueKey(tab),
                      builder: (context, child) {
                        final tab = context.watch<TabItem>();
                        return FocusScope(
                          node: tab.focusScope,
                          child: tab.instance == null
                              ? HomePage(
                                  onSelected: (instance) =>
                                      tab.instance = instance,
                                )
                              : TerminalPage(
                                  instance: tab.instance!,
                                  onExit: () => tab.instance = null,
                                ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
