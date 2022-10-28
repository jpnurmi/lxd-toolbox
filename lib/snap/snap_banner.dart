import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapd/snapd.dart';
import 'package:ubuntu_service/ubuntu_service.dart';

import 'snap_model.dart';

class SnapBanner extends StatelessWidget {
  const SnapBanner({
    super.key,
    required this.child,
    required this.connection,
  });

  final Widget child;
  final SnapConnection connection;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SnapModel(getService<SnapdClient>())..init(),
      builder: (context, child) {
        final model = context.watch<SnapModel>();
        return Column(
          children: [
            if (model.isReady &&
                model.isSnap &&
                !model.isConnected(connection) &&
                !model.isDismissed(connection))
              _SnapBanner(connection),
            Expanded(child: child!),
          ],
        );
      },
      child: child,
    );
  }
}

class _SnapBanner extends StatelessWidget {
  const _SnapBanner(this.connection);

  final SnapConnection connection;

  @override
  Widget build(BuildContext context) {
    final model = context.read<SnapModel>();
    return MaterialBanner(
      leading: const Icon(Icons.error, size: 48),
      leadingPadding: const EdgeInsets.all(8),
      padding: EdgeInsets.zero,
      content: Row(
        children: [
          Expanded(
            child: Text(
              'The ${connection.interface} interface is not connected.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tooltip(
              message: 'Dismiss',
              waitDuration: const Duration(seconds: 1),
              child: IconButton(
                iconSize: 16,
                splashRadius: 16,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.close),
                onPressed: () => model.dismiss(connection),
              ),
            ),
          ),
        ],
      ),
      forceActionsBelow: true,
      actions: [
        ElevatedButton(
          onPressed: () => model.connect(connection),
          child: const Text('Connect'),
        ),
      ],
    );
  }
}
