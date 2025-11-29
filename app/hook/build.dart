import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    // GLBモデルをassetsとして登録
    // Flutter Sceneで読み込めるように設定
    // 現時点ではassets/models/にあるGLBファイルを
    // pubspec.yamlで既に登録しているため、特別な処理は不要

    final logger = Logger('')
      ..level = Level.ALL
      ..onRecord.listen((record) => print(record.message));

    logger.info('Build hook executed for ${input.packageName}');
    logger.info('Assets will be loaded from assets/models/');
  });
}
