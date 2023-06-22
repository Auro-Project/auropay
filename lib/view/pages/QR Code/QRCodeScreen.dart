// import 'dart:async';
//
// import 'package:auropay/view/widgets/CustomAppBar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:camera/camera.dart';
//
// class QRScanner extends StatefulWidget {
//   const QRScanner({Key? key}) : super(key: key);
//
//   @override
//   State<QRScanner> createState() => _QRScannerState();
// }
//
// class _QRScannerState extends State<QRScanner> {
//   late CameraController _cameraController;
//   late Future<void> _initializeCameraControllerFuture;
//   bool isScanCompleted = false;
//
//   @override
//   void initState() {
//     super.initState();
//     initializeCamera();
//     startTimer();
//   }
//
//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }
//
//   Future<void> initializeCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;
//
//     _cameraController = CameraController(
//       firstCamera,
//       ResolutionPreset.high,
//     );
//
//     _initializeCameraControllerFuture = _cameraController.initialize();
//
//     setState(() {});
//   }
//
//   void startTimer() {
//     const delay = Duration(seconds: 3);
//     Timer(delay, () {
//       if (!isScanCompleted) {
//         Navigator.pushReplacementNamed(context, '/qramount');
//       }
//     });
//   }
//
//   Future<void> scanBarcode() async {
//     try {
//       await _initializeCameraControllerFuture;
//
//       final imagePath = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666', // Custom scanner color
//         'Cancel', // Custom cancel button text
//         true, // Enable flash
//         ScanMode.QR, // Specify the scan mode (QR, BARCODE, or DEFAULT)
//       );
//
//       if (imagePath != '-1' && !isScanCompleted) {
//         isScanCompleted = true;
//         Navigator.pushReplacementNamed(context, '/qramount');
//       }
//     } catch (e) {
//       print('Error scanning barcode: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: myAppBar(context, 'QR Code Scanner'),
//       body: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             const Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Place the QR code in the area",
//                     style: TextStyle(
//                       fontFamily: "SF Pro Display",
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     "Scanning will start automatically",
//                     style: TextStyle(
//                       fontFamily: "SF Pro Display",
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 4,
//               child: Stack(
//                 children: [
//                   FutureBuilder<void>(
//                     future: _initializeCameraControllerFuture,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         return CameraPreview(_cameraController);
//                       } else {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Expanded(
//               child: Text(
//                 "Wait until the scan completes",
//                 style: TextStyle(
//                   fontFamily: "SF Pro Display",
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
