import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/state_widget_generator.dart';
export 'src/state_widget_generator.dart';

Builder stateWidgetBuilder(BuilderOptions options) =>
    LibraryBuilder(StateWidgetGenerator(), generatedExtension: '.widget.dart');
