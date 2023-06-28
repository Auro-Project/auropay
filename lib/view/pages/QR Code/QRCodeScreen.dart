import 'package:auropay/view/widgets/AppButtons.dart';
import 'package:auropay/view/widgets/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({Key? key}) : super(key: key);

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView>
    with SingleTickerProviderStateMixin {
  static const flashlighton = CupertinoIcons.bolt;
  static const flashlightoff = CupertinoIcons.bolt_slash_fill;
  static const frontCamera = 'Kamera Depan';

  var flashState = flashlightoff;
  var cameraState = frontCamera;
  MobileScannerController controller = MobileScannerController();
  String? result;

  Future<void> _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('link url bermasalah')));
    }
  }

  bool _isFlashOn(IconData current) {
    return flashlighton == current;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // MobileScanner(
          //   controller: controller,
          //   onDetect: ((qrcode, args) {
          //     setState(() {
          //       result = qrcode.rawValue;
          //     });
          //   }),
          // ),
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                setState(() {
                  result = barcode.rawValue;
                });
              }
            },
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 10,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.close_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 10,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text(
                    'Scan AuroPay\nPayment QR Code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.w500),
                  )),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.25),
                  child: appButtonFunc(
                      context, gradient(context), 'Show My Code ', () => showMyQR(context)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (controller == null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'hasil convert : $result',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  Clipboard.setData(
                                          ClipboardData(text: '$result'))
                                      .then((value) {
                                    if (kDebugMode) {
                                      print('copied');
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Teks disalin')));
                                  });
                                },
                                child: Icon(Icons.copy,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8)),
                              ),
                            ],
                          ),
                        if (result != null)
                          Text(
                            'Scan QR Code',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8)),
                          ),
                        const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        result == null ? const SizedBox() : openLink(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _isFlashOn(flashState)
                                            ? Colors.orange
                                            : Colors.grey,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(30)),
                                child: InkWell(
                                  onTap: () {
                                    controller.toggleTorch();
                                    if (_isFlashOn(flashState)) {
                                      setState(() {
                                        flashState = flashlightoff;
                                      });
                                    } else {
                                      setState(() {
                                        flashState = flashlighton;
                                      });
                                    }
                                  },
                                  child: Icon(
                                    flashState,
                                    color: _isFlashOn(flashState)
                                        ? Colors.orange
                                        : Colors.grey,
                                  ),
                                )),
                            const SizedBox(
                              width: 60,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _isFlashOn(flashState)
                                            ? Colors.orange
                                            : Colors.grey,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(30)),
                                child: InkWell(
                                  onTap: () async {
                                    final ImagePicker picker = ImagePicker();
                                    // Pick an image
                                    final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (image != null) {
                                      if (await controller
                                          .analyzeImage(image.path)) {
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Barcode found!'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      } else {
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('No barcode found!'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                    color: _isFlashOn(flashState)
                                        ? Colors.orange
                                        : Colors.grey,
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showMyQR(BuildContext context) {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height*0.6,
            padding: EdgeInsets.all(16),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 40),
                Text('John Doe',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Account Number: 123456789',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16)),
                SizedBox(height: 40),
                Image.network(
                  'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=Example',  // Replace with actual QR code image URL
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          );
        }
    );
  }


  openLink(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      showModalBottomSheet(
        useSafeArea: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Image.asset(
                      'assets/images/confirm.png',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Payment",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tuck Shop",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                        fontFamily: 'SF Pro Display',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        hintStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //title with information of the user
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //label Paying to in grey, textfield with name of the user
                    Text(
                      'Store Name',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tuck Shop",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Product Name',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Book",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: appButtonFunc(context, gradient(context), 'Pay Now',
                      margin: EdgeInsets.only(bottom: 40), () {
                    Navigator.pushNamed(context, '/receipt');
                  }),
                ),
              )
            ],
          );
        },
      );
    });
    return const SizedBox();
  }
}
