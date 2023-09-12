import 'package:flutter/material.dart';

typedef BuildCheckChild<T> = Widget Function(BuildContext context, T t);

typedef Compare<T> = int Function(T o1, T o2);

typedef Contains<T> = bool Function(T model, String key);

typedef ToString<T> = String Function(T model);
