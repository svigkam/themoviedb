import 'package:flutter/material.dart';
import 'package:themoviedb/Libarary/Widgets/Inherited/provider.dart';

import 'package:themoviedb/ui/widgets/app/my_app.dart';
import 'package:themoviedb/ui/widgets/app/my_app_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  await model.checkAuth();
  const app = MyApp();
  final widget = Provider(child: app, model: model);
  runApp(widget);
}
