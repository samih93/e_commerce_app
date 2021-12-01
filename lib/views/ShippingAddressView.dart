import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/ShippingController.dart';
import 'package:e_commerce_app/widgets/CustomTextFormField.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

class ShippingAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Shipping Address"),
        backgroundColor: primarycolor,
      ),
      body: GetBuilder<ShippingController>(
        init: Get.find(),
        builder: (shippingController) => Form(
          key: shippingController.formstate,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  CustomTextFormField(
                    //  controller: ,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'First Name is required';
                      }
                    },
                    onSave: (value) {
                      shippingController.firstname = value;
                    },
                    hint: 'First Name ...',
                    text: 'First Name*',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    //  controller: ,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Last Name is required';
                      }
                    },
                    onSave: (value) {
                      shippingController.lastname = value;
                    },
                    hint: 'Last Name ...',
                    text: 'Last Name*',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    //  controller: ,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Address is required';
                      }
                    },
                    onSave: (value) {
                      shippingController.address = value;
                    },
                    hint: 'Address  ...',
                    text: 'Address*',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    //  controller: ,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'State is required';
                      }
                    },
                    onSave: (value) {
                      shippingController.state = value;
                    },
                    hint: 'State  ...',
                    text: 'State*',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'City is required';
                      }
                    },
                    onSave: (value) {
                      shippingController.city = value;
                    },
                    hint: 'City  ...',
                    text: 'City*',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .3,
                          child: TextFormField(
                            controller:
                                shippingController.countryTextEditingcontroller,
                            onSaved: (value) {
                              shippingController.country = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Country ...",
                              fillColor: Colors.white,
                            ),
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                exclude: <String>['KN', 'MF'],
                                //Optional. Shows phone code before the country name.
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  // print('Select country: ${country.displayName}');
                                  shippingController
                                      .countryTextEditingcontroller
                                      .text = country.displayName;
                                  //print(shippingController.country);
                                },
                                // Optional. Sets the theme for the country list picker.
                                countryListTheme: CountryListThemeData(
                                  // Optional. Sets the border radius for the bottomsheet.
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  // Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            // initialValue: shippingController.country.toString(),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .6,
                          child: CustomTextFormField(
                            //  controller: ,
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Phone is required';
                              }
                            },
                            onSave: (value) {
                              shippingController.phone = value;
                            },
                            hint: 'Phone ...',
                            text: 'Phone*',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    //  controller: ,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Postcode is required';
                      }
                    },
                    onSave: (value) {
                      shippingController.lastname = value;
                    },
                    hint: 'Postcode ...',
                    text: 'Postcode*',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
