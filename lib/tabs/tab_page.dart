import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lxd_x/lxd_x.dart';
import 'package:movable_tabs/movable_tabs.dart';
import 'package:os_logo/os_logo.dart';
import 'package:provider/provider.dart';
import 'package:window_title_bar/window_title_bar.dart';
import 'package:yaru_icons/yaru_icons.dart';

import '../home/home_page.dart';
import '../home/instance_actions.dart';
import '../home/instance_commands.dart';
import '../home/instance_context.dart';
import '../home/quick_menu.dart';
import '../preferences/preferences_actions.dart';
import '../preferences/preferences_commands.dart';
import '../terminal/terminal_page.dart';
import 'tab_actions.dart';
import 'tab_commands.dart';
import 'tab_intents.dart';
import 'tab_item.dart';
import 'tab_model.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TabModel(),
      builder: (context, child) => PreferencesCommands(
        child: PreferencesActions(
          child: InstanceCommands(
            child: InstanceActions(
              child: TabCommands(
                child: TabActions(
                  child: Focus(
                    autofocus: true,
                    child: Scaffold(
                      appBar: WindowTitleBar(
                        titleSpacing: 0,
                        centerTitle: false,
                        title: const _TabBar(),
                      ),
                      body: const _TabStack(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabStack extends StatelessWidget {
  const _TabStack();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TabModel>();
    return IndexedStack(
      index: model.currentIndex,
      children: [
        for (final tab in model.tabs)
          ChangeNotifierProvider.value(
            value: tab,
            key: ValueKey(tab),
            builder: (context, child) {
              final tab = context.watch<TabItem>();
              final instance =
                  tab.name != null ? context.selectInstance(tab.name!) : null;
              return FocusScope(
                node: tab.focusScope,
                child: instance == null
                    ? HomePage(
                        onSelected: (instance) => tab.name = instance.name,
                      )
                    : TerminalPage(
                        instance: instance,
                        onExit: () => tab.name = null,
                      ),
              );
            },
          ),
      ],
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final model = context.watch<TabModel>();
    return MovableTabBar(
      count: model.tabs.length,
      builder: (context, index) {
        return ChangeNotifierProvider.value(
          value: model.tabs[index],
          builder: (context, child) {
            final tab = context.watch<TabItem>();
            final instance =
                tab.name != null ? context.selectInstance(tab.name!) : null;
            return MovableTabButton(
              selected: index == model.currentIndex,
              onPressed: () => model.currentIndex = index,
              onClosed: Actions.handler(
                context,
                CloseTabIntent(index),
              ),
              icon: instance != null
                  ? OsLogo.asset(
                      name: instance.os,
                      size: 32,
                    )
                  : const SizedBox(width: 8),
              label: Text(instance?.name ?? l10n.homeTab),
            );
          },
        );
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(YaruIcons.plus),
            iconSize: 16,
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            onPressed: Actions.handler(context, const AddTabIntent()),
          ),
          const SizedBox(width: 2),
          QuickMenuButton(
            onSelected: (instance) {
              Actions.maybeInvoke(context, AddTabIntent(instance));
            },
          ),
          const SizedBox(width: kMinInteractiveDimension),
        ],
      ),
      onMoved: (from, to) {
        Actions.invoke(context, MoveTabIntent(from, to));
      },
    );
  }
}
