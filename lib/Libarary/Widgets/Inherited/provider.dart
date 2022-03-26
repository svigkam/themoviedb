import 'package:flutter/material.dart';

class NotifierProvider<Model extends ChangeNotifier> extends StatefulWidget {
  final Model Function() create;
  final bool isManagingModel;
  final Widget child;
  const NotifierProvider({
    Key? key,
    required this.create,
    required this.child,
     this.isManagingModel = true,
  }) : super(key: key);
  @override
  State<NotifierProvider<Model>> createState() =>
      _NotifierProviderState<Model>();

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedNotifierProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            InheritedNotifierProvider<Model>>()
        ?.widget;
    return widget is InheritedNotifierProvider<Model> ? widget.model : null;
  }
}

class _NotifierProviderState<Model extends ChangeNotifier>
    extends State<NotifierProvider<Model>> {
  late final Model _model;

  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedNotifierProvider(model: _model, child: widget.child);
  }

  @override
  void dispose() {
    if(widget.isManagingModel) {
    _model.dispose();

    }
    super.dispose();
  }
}

class InheritedNotifierProvider<Model extends ChangeNotifier>
    extends InheritedNotifier {
  final Model model;
  const InheritedNotifierProvider(
      {Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);
}

// class Provider<Model> extends InheritedWidget {
//   final Model model;
//   const Provider({Key? key, required this.model, required Widget child})
//       : super(key: key, child: child);

//   static Model? watch<Model>(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<Provider<Model>>()?.model;
//   }

//   static Model? read<Model>(BuildContext context) {
//     final widget = context
//         .getElementForInheritedWidgetOfExactType<Provider<Model>>()
//         ?.widget;
//     return widget is Provider<Model> ? widget.model : null;
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return model != oldWidget;
//   }
// }
