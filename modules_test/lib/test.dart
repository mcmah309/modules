import 'dart:math';

// expect_lint: prefer_named_local_libs
import 'non_library_1.dart';
// expect_lint: prefer_named_local_libs
import 'package:modules_test/non_library_2.dart';

import 'library_x.dart';
import 'package:modules_test/library_y.dart';

import 'package:rust_core/prelude.dart';

part 'part.dart';

void main() {
  calculate();
  calculate2();
  calculate3();
  calculate4();
  calculate5();
  var _ = max(1,2);
  Ok(1);
}