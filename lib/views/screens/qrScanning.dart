

import 'dart:io';
import 'dart:typed_data';

import 'package:CatCultura/utils/auxArgsObjects/argsRouting.dart';
import 'package:CatCultura/viewModels/EventUnicViewModel.dart';
import 'package:CatCultura/views/widgets/errorWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../data/response/apiResponse.dart';
import '../../utils/Session.dart';
import '../../viewModels/OrganizerEventsViewModel.dart';
import '../../viewModels/TagEventsViewModel.dart';
import '../widgets/events/eventInfoTile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../widgets/myDrawer.dart';

class QRScanning extends StatefulWidget {
  QRScanning(this.eventId, {super.key});

  final String eventId;
  final EventUnicViewModel viewModel = EventUnicViewModel();

  @override
  State<QRScanning> createState() => _QRScanningState();
}

class _QRScanningState extends State<QRScanning> {

  late EventUnicViewModel viewModel = widget.viewModel;
  late String eventId = widget.eventId;
  Barcode? result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }


  @override
  void initState() {
    viewModel.requestPermission();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventUnicViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EventUnicViewModel>(builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title:
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text("Escaneja el QR")
                    ]
                ),
              )
              ,
            ),
            drawer: MyDrawer("qrScan",Session()),
            body: Column(
              children: [
                Expanded(
                  flex: 5,
                    child: _buildQrView(context)),
                //UNKNOWN TERRAIN
                Expanded(
                flex: 1,
                child: FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                        if (result != null)
                          Row(
                            children: [
                              Text("Capturat. Codi ${result!.code!}"),
                              ElevatedButton(onPressed: () => {
                                              Navigator.pop(context,
                                              QrCodeArgs(result!.code!)
                                              )
                                            }, child: Text("Confirmar"))
                            ],
                          )
                          // Text(
                          //   'Barcode Type: ${result!.format}   Data: ${result!.code}')
                        else
                          const Text('Scan a code'),
                          
              ],
            )
            )
          )
          ]
          )

          );
        },
        )
    );
  }


  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 450.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      cameraFacing: CameraFacing.back,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      // onPermissionSet: (ctrl, p) =>
      // {
      //   debugPrint(p.toString()),
      //   _onPermissionSet(context, ctrl, p),
      //   viewModel.setPermission(p),
      //   debugPrint("Permission OK")
      // },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    // setState(() {
    //   this.controller = controller;
    // });
    // controller.scannedDataStream.listen((scanData) {
    //   setState(() {
    //     result = scanData;
    //   });
    // });

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}