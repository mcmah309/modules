import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => _onlyImportNamedLibrariesLint();

class _onlyImportNamedLibrariesLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        OnlyImportlibrariesLintRule(),
      ];
}

class OnlyImportlibrariesLintRule extends DartLintRule {
  OnlyImportlibrariesLintRule() : super(code: _code);

  static const _code = LintCode(
    name: 'use_modules',
    problemMessage:
        'Only named libraries from the local project should be imported. Export this path from a named library and import that library, or add the `library <name>;` directive to the file at this path.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    final projectName = context.pubspec.name;
    final absoluteImportPrefix = "package:$projectName";
    context.registry.addImportDirective((node) {
      final element = node.element;
      if (element == null) return;
      final importedLibrary = element.importedLibrary;
      if (importedLibrary == null) return;
      final identifier = importedLibrary.identifier;
      if (identifier.startsWith(absoluteImportPrefix) &&
          importedLibrary.name.isEmpty &&
          importedLibrary.source.exists()) {
        reporter.reportErrorForNode(code, node);
      }
    });
  }
}
