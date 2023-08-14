import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ValueNotifier<T> useNotifierState<T>(ValueNotifier<T> initialData) {
  return use(_StateHook(initialData: initialData));
}

class _StateHook<T> extends Hook<ValueNotifier<T>> {
  const _StateHook({required this.initialData});

  final ValueNotifier<T> initialData;

  @override
  _StateHookState<T> createState() => _StateHookState();
}

class _StateHookState<T> extends HookState<ValueNotifier<T>, _StateHook<T>> {
  late final ValueNotifier<T> _state = hook.initialData..addListener(_listener);

  @override
  void dispose() => _state.dispose();

  @override
  ValueNotifier<T> build(BuildContext context) => _state;

  void _listener() => setState(() {});

  @override
  Object? get debugValue => _state.value;

  @override
  String get debugLabel => 'useNotifierState<$T>';
}
