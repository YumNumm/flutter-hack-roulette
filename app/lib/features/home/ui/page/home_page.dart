import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/core/providers/package_info.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);

    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Text(packageInfo.appName),
          Text(packageInfo.packageName),
          Text(packageInfo.version),
          Text(packageInfo.buildNumber),
          Text(packageInfo.buildSignature),
          Text(packageInfo.buildSignature),
        ],
      ),
    );
  }
}
