import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import './navbar.dart';
import './login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    var $ScreenWidth = MediaQuery.of(context).size.width;
    var $ScreenHeight = MediaQuery.of(context).size.height;
    var $generalCam = 250.0;
    var $logoPercentage = 10;

    // var $paused = 0;

    return Scaffold(
      key: scaffoldKey,
      drawer: const Navbar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10
            ),
            // ignore: sized_box_for_whitespace
            Container(
              width: $ScreenWidth,
              height: $ScreenHeight * ($logoPercentage/100),
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => scaffoldKey.currentState?.openDrawer(),
                  ),
                  Image.asset(
                    'assets/placeholder.jpg'
                  ),
                  Visibility(
                    visible: true, //TODO: Change visibility when there is connection
                    maintainAnimation: true,
                    maintainState: true,
                    maintainSize: true,
                    child: IconButton(
                      icon: const Icon(Icons.sync),
                      onPressed: () {
                        print("ASDASd"); //TODO: Change to sync in database
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50
            ),

            // ignore: sized_box_for_whitespace
            GestureDetector(
              onDoubleTap: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              onTap: () async {
                await controller?.pauseCamera();
                setState(() {});
              },
              child: Container(
                width: $generalCam,
                height: $generalCam,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                // color: Colors.blue,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onViewCreated,
                    onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.green,
                      borderRadius: 20,
                      borderLength: 40,
                      borderWidth: 15,
                      cutOutSize: $generalCam,
                    ),
                    // onQRViewCreated: onQRViewCreated
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Expanded(
              // ignore: sized_box_for_whitespace
              child: Container(
                width: $ScreenWidth,
                // color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: $ScreenWidth * (70/100),
                      height: 150,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            spreadRadius: 0.5
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: $ScreenWidth,
                            height: 30,
                            child: const Text(
                              'ID Number',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          const Divider(
                            height: 2,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            color: Colors.black45,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: $ScreenWidth,
                            height: 30,
                            child: 
                            (result?.code == null) ? 
                            const Text(
                              'No ID scanned',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              )
                            ) :
                            Text(
                              '${result?.code}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            )
                          )
                        ],
                      )
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    (result != null) ? //TODO: REPLACE CONDITION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              print("IN"); //TODO: REPLACE TO IN AND OUT
                            });
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green[300],
                            padding: const EdgeInsets.fromLTRB(40, 15, 40, 15)
                          ),
                        child: const Text(
                          'IN',
                          style: TextStyle(
                            fontSize: 40
                          ),
                        )
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              print("OUT"); //TODO: REPLACE
                            });
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[300],
                            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15)
                          ), 
                          child: const Text(
                            'OUT',
                            style: TextStyle(
                              fontSize: 40
                            ),
                          ),
                        ),
                      ],
                    ) : const Text(
                      "Scan an ID",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  void _onViewCreated(QRViewController controller){
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) { 
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}