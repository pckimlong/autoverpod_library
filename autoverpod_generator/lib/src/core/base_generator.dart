import 'package:source_gen/source_gen.dart';

/// Base class for all generators in the riverpod_widget package
abstract class BaseGenerator extends Generator {
  /// The name of the generator, used for identification and file naming
  String get name;
}
