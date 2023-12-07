///
///  Copyright © 2022-2023 PSPDFKit GmbH. All rights reserved.
///
///  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
///  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
///  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
///  This notice may not be removed from this file.
///

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget_controller.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget.dart';

import 'utils/platform_utils.dart';

class PspdfkitManualSaveExampleWidget extends StatefulWidget {
  final String documentPath;
  final dynamic configuration;

  const PspdfkitManualSaveExampleWidget(
      {Key? key, required this.documentPath, this.configuration})
      : super(key: key);

  @override
  _PspdfkitManualSaveExampleWidgetState createState() =>
      _PspdfkitManualSaveExampleWidgetState();
}

class _PspdfkitManualSaveExampleWidgetState
    extends State<PspdfkitManualSaveExampleWidget> {
  late PspdfkitWidgetController pspdfkitWidgetController;

  @override
  Widget build(BuildContext context) {
    if (PlatformUtils.isCurrentPlatformSupported()) {
      return Scaffold(
          extendBodyBehindAppBar: PlatformUtils.isAndroid(),
          appBar: AppBar(),
          body: SafeArea(
              top: false,
              bottom: false,
              child: Container(
                  padding: PlatformUtils.isIOS()
                      ? null
                      : const EdgeInsets.only(top: kToolbarHeight),
                  child: Column(children: <Widget>[
                    Expanded(
                      child: PspdfkitWidget(
                        documentPath: widget.documentPath,
                        configuration: widget.configuration,
                        onPspdfkitWidgetCreated: (controller) {
                          pspdfkitWidgetController = controller;
                        },
                      ),
                    ),
                    SizedBox(
                        child: Column(children: <Widget>[
                      ElevatedButton(
                          onPressed: () async {
                            await pspdfkitWidgetController.save();
                          },
                          child: const Text('Save Document'))
                    ]))
                  ]))));
    } else {
      return Text(
          '$defaultTargetPlatform is not yet supported by PSPDFKit for Flutter.');
    }
  }

  Future<void> onPlatformViewCreated(int id) async {
    pspdfkitWidgetController = PspdfkitWidgetController(id);
  }
}
