import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/ShippingController.dart';
import 'package:e_commerce_app/models/Address.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustomTextFormField.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

class ShippingAddress extends StatelessWidget {
  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
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
                    hint: "FirstName...",
                    text: '',
                  ),
                  SizedBox(
                    height: 10,
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
                    text: '',
                  ),
                  SizedBox(
                    height: 10,
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
                    text: '',
                  ),
                  SizedBox(
                    height: 10,
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
                    text: '',
                  ),
                  SizedBox(
                    height: 10,
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
                    text: '',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .22,
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
                              countryCodeselected();
                            },
                            // initialValue: shippingController.address.country.toString(),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .64,
                          child: TextFormField(
                            //  controller: ,
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Phone is required';
                              }
                            },
                            onSaved: (value) {
                              shippingController.phone = value;
                            },
                            decoration: InputDecoration(
                              hintText: "phone ...",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    //  controller: ,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Postcode is required';
                      }
                    },
                    onSave: (value) {
                      shippingController.postcode = value;
                    },
                    hint: 'Postcode ...',
                    text: '',
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: CustomButton(
                      text: "save",
                      onPress: () {
                        // save form state to save all field
                        shippingController.formstate.currentState.save();

                        shippingController.insertAddress(Address(
                          firstname: shippingController.firstname,
                          lastname: shippingController.lastname,
                          address: shippingController.address,
                          state: shippingController.state,
                          city: shippingController.city,
                          postcode: shippingController.postcode,
                          country: shippingController.country,
                          phone: shippingController.phone,
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void countryCodeselected() {
    ShippingController shippingController = ShippingController();
    showCountryPicker(
      context: _context,
      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
      exclude: <String>['KN', 'MF'],
      //Optional. Shows phone code before the country name.
      showPhoneCode: true,

      onSelect: (Country country) {
        // print('Select country: ${country.displayName}');
        var countrycode = country.displayName.split("(");
        shippingController.countryTextEditingcontroller.text =
            "(" + countrycode[1];
        shippingController.country = "(" + countrycode[1];
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
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }
}
