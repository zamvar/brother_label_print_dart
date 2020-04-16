import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

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

  static Future<String> printLabelFromImage(
      String ip, PrinterModel model, File image, int width, int height) async {


    return await _channel.invokeMethod("printLabelFromImage", {
      "ip": ip,
      "model": model.index,
      "data": image.readAsBytesSync(),
      "width": width,
      "height": height
    });
  }

  static Future<String> printLabelFromPdf(
    String ip, PrinterModel model, File pdf, int numberOfPages) async {

    return await _channel.invokeMethod("printLabelFromPdf", {
      "ip": ip,
      "model": model.index,
      "data": pdf.readAsBytesSync(),
      "numberOfPages": numberOfPages
    });
  }
}
