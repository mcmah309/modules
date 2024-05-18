import 'dart:math';

import 'library_x.dart';
import 'package:modules_test/library_y.dart';
// expect_lint: prefer_named_local_libs
import 'non_library_1.dart';
// expect_lint: prefer_named_local_libs
import 'package:modules_test/non_library_2.dart';
import 'package:rust_core/prelude.dart';

//import 'package:';

void main() {
  calculate();
  calculate2();
  calculate3();
  calculate4();
  var _ = max(1,2);
  Ok(1);
}