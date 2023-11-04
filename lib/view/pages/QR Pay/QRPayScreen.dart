import '../../../model/UserModel.dart';
import '../../../services/database.dart';
import '../../../services/payments_service.dart';
import '../../../view/widgets/CustomError.dart';
import '../../../view/widgets/AppButtons.dart';
import '../../../view/widgets/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;


class ScannerView extends StatefulWidget {
  const ScannerView({Key? key}) : super(key: key);

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView>
    with SingleTickerProviderStateMixin {
  static const flashLightOn = CupertinoIcons.bolt;
  static const flashLightOff = CupertinoIcons.bolt_slash_fill;
  static const frontCamera = 'open Camera';
  TextEditingController _amountController = TextEditingController();
  late String? _spenton;
  bool isLoading = false;
  UserModel? currentUser;
  final DatabaseService _databaseService = DatabaseService();


  var flashState = flashLightOff;
  var cameraState = frontCamera;
  MobileScannerController controller = MobileScannerController();
  String? result;

  bool _isFlashOn(IconData current) {
    return flashLightOn == current;
  }

  Future<void> _performDebit() async {
    setState(() {
      isLoading = true;
    });

    final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      setState(() {
        isLoading = false;
      });
      showGlobalSnackBar(context, 'You are not logged in.');
      return;
    }

    if (_amountController.text.trim().isEmpty) {
      setState(() {
        isLoading = false;
      });
      showGlobalSnackBar(context, 'Please enter an amount to debit.');
      return;
    }

    int debitAmount = int.parse(_amountController.text.trim());
    String result = await PaymentsService(_databaseService).performDebit(
        debitAmount: debitAmount,
        userId: userId,
        spentOn: _spenton! // Assuming _spentOn is a String variable with the description of the spending
    );

    setState(() {
      isLoading = false;
    });

    showGlobalSnackBar(context, result);
    if (result == 'Balance debited successfully!') {
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/'));
    }
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
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Scan AuroPay\nPayment QR Code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontWeight: FontWeight.w500),
                    ),
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
                                'Result convert : $result',
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
                                    showGlobalSnackBar(context, 'Texts were removed');
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
                        result == null ? const SizedBox() : payNow(context, 'Regular Journal'),
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
                                        flashState = flashLightOff;
                                      });
                                    } else {
                                      setState(() {
                                        flashState = flashLightOn;
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
                                        showGlobalSnackBar(context, 'QR Found');
                                      } else {
                                        if (!mounted) return;
                                        showGlobalSnackBar(context, 'No QR Found');
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
            padding: const EdgeInsets.all(16),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 40),
                Text('John Doe',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Account Number: 123456789',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16)),
                const SizedBox(height: 40),
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

  payNow(BuildContext context, String spenton) {
    _spenton = spenton;
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
                      controller: _amountController,
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
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
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
                      spenton,
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
                      margin: const EdgeInsets.only(bottom: 40),() {
                        _performDebit();
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
