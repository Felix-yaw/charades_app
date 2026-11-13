import 'package:flutter/widgets.dart';

import '../../../core/utils/size_config.dart';

class AppMetricsScope extends StatefulWidget {
  const AppMetricsScope({super.key, required this.child});

  final Widget child;

  @override
  State<AppMetricsScope> createState() => _AppMetricsScopeState();
}

class _AppMetricsScopeState extends State<AppMetricsScope>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenSize.captureFromBinding();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    ScreenSize.captureFromBinding();
  }

  @override
  void didChangeTextScaleFactor() {
    ScreenSize.captureFromBinding(bumpRevision: false);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ScreenSize.revision,
      builder: (context, child) {
        return KeyedSubtree(
          key: ValueKey<int>(ScreenSize.revision.value),
          child: widget.child,
        );
      },
    );
  }
}
