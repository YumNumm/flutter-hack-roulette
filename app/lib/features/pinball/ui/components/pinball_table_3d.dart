import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PinballTable3D extends HookConsumerWidget {
  const PinballTable3D({
    required this.onHoleDetected,
    super.key,
  });

  final void Function(int holeNumber) onHoleDetected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useState(false);

    useEffect(
      () {
        // 初期化処理
        unawaited(
          WidgetsBinding.instance.endOfFrame.then((_) {
            isInitialized.value = true;
          }),
        );
        return null;
      },
      [],
    );

    return ColoredBox(
      color: Colors.black87,
      child: Center(
        child: isInitialized.value
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.casino,
                    size: 64,
                    color: Colors.white54,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '3D ピンボールテーブル',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // シンプルな穴の視覚化
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(
                      6,
                      (index) => GestureDetector(
                        onTap: () {
                          // テスト用：タップで穴を選択
                          onHoleDetected(index + 1);
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.cyan.shade400,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyan.shade400.withValues(
                                  alpha: 0.5,
                                ),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: Colors.cyan.shade400,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    '※ 現在は簡易版です\n穴の番号をタップしてテストできます',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : const CircularProgressIndicator(
                color: Colors.cyan,
              ),
      ),
    );
  }
}
