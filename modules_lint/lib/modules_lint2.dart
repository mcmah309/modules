import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';


PluginBase createPlugin() => _onlyImportLibrariesLint();

class _onlyImportLibrariesLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        OnlyImportlibrariesLintRule(),
      ];
}

class OnlyImportlibrariesLintRule extends DartLintRule {
  OnlyImportlibrariesLintRule() : super(code: _code);
  
  static const _code = LintCode(
    name: 'only_import_libraries',
    problemMessage: 'Only libraries from the local project can be imported',
  );
  
  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addImportDirective((node) {
      print("prefix ${node.prefix}");
      reporter.reportErrorForNode(code, node);
    });
  }

  // @override
  // List<Fix> getFixes() => [_OnlyImportLibrariesFix()];
}

// class _OnlyImportLibrariesFix extends DartFix {
//   @override
//   void run(
//     CustomLintResolver resolver,
//     ChangeReporter reporter,
//     CustomLintContext context,
//     AnalysisError analysisError,
//     List<AnalysisError> others,
//   ) {
//     context.registry.addVariableDeclarationList((node) {
//       if (!analysisError.sourceRange.intersects(node.sourceRange)) return;
      
//       final changeBuilder = reporter.createChangeBuilder(
//         message: 'Make provider final',        
//         priority: 10,
//       );
      
//       changeBuilder.addDartFileEdit((builder) {
//         final nodeKeyword = node.keyword;
//         final nodeType = node.type;
//         if (nodeKeyword != null) {            
//         builder.addSimpleReplacement(
//             SourceRange(nodeKeyword.offset, nodeKeyword.length),
//             'final',
//           );
//         } else if (nodeType != null) {
//           builder.addSimpleInsertion(nodeType.offset, 'final ');
//         }
//       });
//     });
//   }
// }