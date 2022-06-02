import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/payment_controller.dart';
import 'package:e_commerce_app/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

class PaymentMethodScreen extends StatefulWidget {
  PaymentModel model;
  PaymentMethodScreen(this.model);

  @override
  State<StatefulWidget> createState() {
    return PaymentMethodScreenState();
  }
}

class PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    cardHolderName = widget.model.name;
    cardNumber = widget.model.number;
    cvvCode = widget.model.cvv;
    expiryDate = widget.model.expireddate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: Text('Payment method'),
      ),
      resizeToAvoidBottomInset: false,
      body: GetBuilder<PaymentController>(
          init: PaymentController(),
          builder: (paymentcontroller) {
            return Container(
              decoration: BoxDecoration(
                // image: !useBackgroundImage
                //     ? const DecorationImage(
                //         image: ExactAssetImage('assets/bg.png'),
                //         fit: BoxFit.fill,
                //       )
                //     : null,
                color: Colors.grey.shade800,
              ),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    CreditCardWidget(
                      glassmorphismConfig: useGlassMorphism
                          ? Glassmorphism.defaultConfig()
                          : null,
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      obscureCardNumber: true,
                      obscureCardCvv: true,
                      isHolderNameVisible: true,
                      cardBgColor: Colors.red,
                      backgroundImage: 'assets/card_bg.png',
                      isSwipeGestureEnabled: true,
                      onCreditCardWidgetChange:
                          (CreditCardBrand creditCardBrand) {},
                      customCardTypeIcons: <CustomCardTypeIcon>[
                        CustomCardTypeIcon(
                          cardType: CardType.mastercard,
                          cardImage: Image.asset(
                            'assets/mastercard.png',
                            height: 48,
                            width: 48,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            CreditCardForm(
                              formKey: formKey,
                              obscureCvv: true,
                              obscureNumber: true,
                              cardNumber: widget.model.number,
                              cvvCode: cvvCode,
                              isHolderNameVisible: true,
                              isCardNumberVisible: true,
                              isExpiryDateVisible: true,
                              cardHolderName: cardHolderName,
                              expiryDate: expiryDate,
                              themeColor: Colors.blue,
                              textColor: Colors.white,
                              cardNumberDecoration: InputDecoration(
                                labelText: 'Number',
                                hintText: 'XXXX XXXX XXXX XXXX',
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                focusedBorder: border,
                                enabledBorder: border,
                              ),
                              expiryDateDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                focusedBorder: border,
                                enabledBorder: border,
                                labelText: 'Expired Date',
                                hintText: 'XX/XX',
                              ),
                              cvvCodeDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                focusedBorder: border,
                                enabledBorder: border,
                                labelText: 'CVV',
                                hintText: 'XXX',
                              ),
                              cardHolderDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                focusedBorder: border,
                                enabledBorder: border,
                                labelText: 'Card Holder',
                              ),
                              onCreditCardModelChange: onCreditCardModelChange,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[
                            //     const Text(
                            //       'Glassmorphism',
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 18,
                            //       ),
                            //     ),
                            //     Switch(
                            //       value: useGlassMorphism,
                            //       inactiveTrackColor: Colors.grey,
                            //       activeColor: Colors.white,
                            //       activeTrackColor: Colors.green,
                            //       onChanged: (bool value) => setState(() {
                            //         useGlassMorphism = value;
                            //       }),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[
                            //     const Text(
                            //       'Card Image',
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 18,
                            //       ),
                            //     ),
                            //     Switch(
                            //       value: useBackgroundImage,
                            //       inactiveTrackColor: Colors.grey,
                            //       activeColor: Colors.white,
                            //       activeTrackColor: Colors.green,
                            //       onChanged: (bool value) => setState(() {
                            //         useBackgroundImage = value;
                            //       }),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            GetBuilder<PaymentController>(
                              init: PaymentController(),
                              builder: (controller) => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  primary: primarycolor,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'halter',
                                      fontSize: 14,
                                      package: 'flutter_credit_card',
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    print('valid!');
                                    PaymentModel model = PaymentModel(
                                        name: cardHolderName,
                                        number: cardNumber,
                                        expireddate: expiryDate,
                                        cvv: cvvCode);
                                    controller
                                        .insertPaymentCard(model)
                                        .then((value) {
                                      print("inserted");
                                      Toast.show(
                                          "Payment method inserted", context,
                                          backgroundColor: Colors.green,
                                          duration: 2,
                                          gravity: Toast.TOP);
                                      Get.back();
                                    }).catchError((error) {
                                      print(error.toString());
                                    });
                                  } else {
                                    print('invalid!');
                                    Toast.show("Fill all form", context,
                                        backgroundColor: Colors.red,
                                        duration: 2,
                                        gravity: Toast.TOP);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
