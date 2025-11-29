import 'package:flutter_scene_importer/build_hooks.dart';
import 'package:hooks/hooks.dart';

void main(List<String> args) async {
  await build(args, (config, output) async {
    buildModels(
      buildInput: config,
      inputFilePaths: [
        'assets/models/dash.glb',
        'assets/models/flutter_logo.glb',
      ],
    );
  });
}
