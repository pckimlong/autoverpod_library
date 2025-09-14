import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

/// Base class for all widget annotations
@Target({TargetKind.classType, TargetKind.function})
@sealed
abstract class WidgetAnnotation {
  const WidgetAnnotation();
}

/// Use for create form widget. This support both create and update form
/// update form usually mean it has future in build method which fetch the data to fill the initial form state
@Target({TargetKind.classType, TargetKind.function})
@sealed
class FormWidget extends WidgetAnnotation {
  const FormWidget();
}

const formWidget = FormWidget();

@Target({TargetKind.classType, TargetKind.function})
@sealed
class StateWidget extends WidgetAnnotation {
  const StateWidget();
}

const stateWidget = StateWidget();
