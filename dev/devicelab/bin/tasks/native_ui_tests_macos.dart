// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_devicelab/framework/framework.dart';
import 'package:flutter_devicelab/framework/ios.dart';
import 'package:flutter_devicelab/framework/task_result.dart';
import 'package:flutter_devicelab/framework/utils.dart';

Future<void> main() async {
  await task(() async {
    final String projectDirectory = '${flutterDirectory.path}/dev/integration_tests/flutter_gallery';

    await inDirectory(projectDirectory, () async {
      section('Build gallery app');

      await flutter(
        'build',
        options: <String>[
          'macos',
          '-v',
          '--debug',
        ],
      );
    });

    section('Run platform unit tests');

    if (!await runXcodeTests(projectDirectory, 'platform=macOS', 'native_ui_tests_macos')) {
      return TaskResult.failure('Platform unit tests failed');
    }

    return TaskResult.success(null);
  });
}
