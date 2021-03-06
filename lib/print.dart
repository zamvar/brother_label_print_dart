import 'dart:async';

import 'package:brotherlabelprintdart/printerModel.dart';
import 'package:brotherlabelprintdart/templateLabel.dart';
import 'package:flutter/services.dart';

class Brotherlabelprintdart {
  static const MethodChannel _channel =
      const MethodChannel('brotherlabelprintdart');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> printLabelFromTemplate(
      String ip, PrinterModel model, List<TemplateLabel> labels) async {
    List<String> data = List<String>();

    for (TemplateLabel label in labels) {
      data += label.toNative();
    }

    return await _channel.invokeMethod('printLabelFromTemplate',
        {"ip": ip, "model": model.index, "data": data});
  }
}
