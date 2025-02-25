import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:ui' as ui show PointerDataPacket;
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/utils/screen_util.dart';
import 'auto_size_config.dart';

/// runAutoSizeApp.
///
/// width 设计稿尺寸 宽 dp or pt。
/// height 设计稿尺寸 高 dp or pt。
///
// void runAutoSizeApp(Widget app, {required double width, double? height}) {
//   AutoSizeConfig.setDesignWH(width: width, height: height);
//   AutoSizeWidgetsFlutterBinding.ensureInitialized()
//     ..attachRootWidget(app)
//     ..scheduleWarmUpFrame();
// }

/// AutoSize.
class AutoSize {
  /// getSize.
  static Size getSize() {
    final Size size = window.physicalSize;
    if (size == Size.zero) return size;
    final Size autoSize = size.width > size.height
        ? new Size(size.width / ScreenUtil.pixelRatio, AutoSizeConfig.designWidth)
        : new Size(AutoSizeConfig.designWidth, size.height / ScreenUtil.pixelRatio);
    return autoSize;
  }

  /// 获取适配后的像素密度。
  /// get the adapted pixel density.
  static double getPixelRatio() {
    final Size size = window.physicalSize;
    return (size.width > size.height ? size.height : size.width) / AutoSizeConfig.designWidth;
  }
}

/// A concrete binding for applications based on the Widgets framework.
///
/// This is the glue that binds the framework to the Flutter engine.
class AutoSizeWidgetsFlutterBinding extends WidgetsFlutterBinding {
  /// Returns an instance of the [WidgetsBinding], creating and
  /// initializing it if necessary. If one is created, it will be a
  /// [AutoSizeWidgetsFlutterBinding]. If one was previously initialized, then
  /// it will at least implement [WidgetsBinding].
  ///
  /// You only need to call this method if you need the binding to be
  /// initialized before calling [runApp].
  ///
  /// In the `flutter_test` framework, [testWidgets] initializes the
  /// binding instance to a [TestWidgetsFlutterBinding], not a
  /// [AutoSizeWidgetsFlutterBinding].
  static T? _ambiguate<T>(T? value) => value;

  static WidgetsBinding ensureInitialized() {
    AutoSizeWidgetsFlutterBinding();
    return WidgetsBinding.instance;
  }

  @override
  ViewConfiguration createViewConfiguration() {
    final double dpRatio = window.devicePixelRatio;
    //bool isTablet = false;
    bool isLandscape = false;

    var size = window.physicalSize / dpRatio;
    var width = size.width;
    var height = size.height;
    //
    // if (dpRatio <= 2 && (width >= 1000 || height >= 1000)) {
    //   isTablet = true;
    // } else if (dpRatio == 2 && (width >= 1920 || height >= 1920)) {
    //   isTablet = true;
    // } else {
    //   isTablet = false;
    // }
    // if (!isTablet) {
    //   if (width > height) {
    //     isLandscape = true;
    //   }
    // }
    //

    if (size == Size.zero) {
      return super.createViewConfiguration();
    }
    if (AutoSizeConfig.isFixWidth && !AutoSizeConfig.isTablet) {
      AutoSizeConfig.setDesignWH(width: AutoSizeConfig.designWidth, isFixWidth: AutoSizeConfig.isFixWidth);
      ScreenUtil.pixelRatio = AutoSize.getPixelRatio();
      ScreenUtil.autoSizeRatio = dpRatio / ScreenUtil.pixelRatio;
      ScreenUtil.isGetPixelRatio = true;
    } else if (!ScreenUtil.isGetPixelRatio) {
      if (AutoSizeConfig.designWidth < size.width && !AutoSizeConfig.isTablet) {
        if (size.width > size.height) {
          AutoSizeConfig.setDesignWH(width: size.height );
        } else {
          AutoSizeConfig.setDesignWH(width: size.width);
        }
      }
      ScreenUtil.pixelRatio = AutoSize.getPixelRatio();
      ScreenUtil.autoSizeRatio = dpRatio / ScreenUtil.pixelRatio;
      ScreenUtil.isGetPixelRatio = true;
    } else {}

    ScreenUtil.screenSize = AutoSize.getSize();

    ScreenUtil.heightTopSafeArea = window.padding.top / ScreenUtil.pixelRatio;
    ScreenUtil.heightBottomSafeArea = window.padding.bottom / ScreenUtil.pixelRatio;

    print("------------${ScreenUtil.screenSize ?? size}");
    return ViewConfiguration(
      size: ScreenUtil.screenSize ?? size,
      devicePixelRatio: ScreenUtil.pixelRatio,
    );
  }

  @override
  void initInstances() {
    super.initInstances();
    window.onPointerDataPacket = _handlePointerDataPacket;
  }

  @override
  void unlocked() {
    super.unlocked();
    _flushPointerEventQueue();
  }

  final Queue<PointerEvent> _pendingPointerEvents = Queue<PointerEvent>();

  void _handlePointerDataPacket(ui.PointerDataPacket packet) {
    // We convert pointer data to logical pixels so that e.g. the touch slop can be
    // defined in a device-independent manner.
    _pendingPointerEvents.addAll(PointerEventConverter.expand(packet.data, ScreenUtil.pixelRatio));
    if (!locked) _flushPointerEventQueue();
  }

  @override
  void cancelPointer(int pointer) {
    super.cancelPointer(pointer);
    if (_pendingPointerEvents.isEmpty && !locked) scheduleMicrotask(_flushPointerEventQueue);
    _pendingPointerEvents.addFirst(PointerCancelEvent(pointer: pointer));
  }

  void _flushPointerEventQueue() {
    assert(!locked);
    while (_pendingPointerEvents.isNotEmpty) _handlePointerEvent(_pendingPointerEvents.removeFirst());
  }

  final Map<int, HitTestResult> _hitTests = <int, HitTestResult>{};

  void _handlePointerEvent(PointerEvent event) {
    assert(!locked);
    HitTestResult? result;
    if (event is PointerDownEvent) {
      assert(!_hitTests.containsKey(event.pointer));
      result = HitTestResult();
      hitTest(result, event.position);
      _hitTests[event.pointer] = result;
      assert(() {
        if (debugPrintHitTestResults) debugPrint('$event: $result');
        return true;
      }());
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      result = _hitTests.remove(event.pointer);
    } else if (event.down) {
      result = _hitTests[event.pointer];
    } else {
      return; // We currently ignore add, remove, and hover move events.
    }
    if (result == null) return;
    dispatchEvent(event, result);
  }
}
