import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/Controller/ShippingController.dart';
import 'package:e_commerce_app/models/Address.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustomTextFormField.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import 'package:toast/toast.dart';

class ShippingAddressScreen extends StatelessWidget {
  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Shipping Address",
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: primarygradient)),
        ),
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
                    initialvalue: shippingController.addressmodel != null
                        ? shippingController.addressmodel.firstname ?? ""
                        : "",
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
                    initialvalue: shippingController.addressmodel != null
                        ? shippingController.addressmodel.lastname ?? ""
                        : "",
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
                    initialvalue: shippingController.addressmodel != null
                        ? shippingController.addressmodel.location ?? ""
                        : "",
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
                    initialvalue: shippingController.addressmodel != null
                        ? shippingController.addressmodel.state ?? ""
                        : "",
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
                    initialvalue: shippingController.addressmodel != null
                        ? shippingController.addressmodel.city ?? ""
                        : "",
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
                            initialValue: shippingController.addressmodel !=
                                    null
                                ? shippingController.addressmodel.phone ?? ""
                                : "",
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
                    initialvalue: shippingController.addressmodel != null
                        ? shippingController.addressmodel.postcode ?? ""
                        : "",
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
                      text: shippingController.list_of_address.length == 0
                          ? "Add"
                          : "Update",
                      onPress: () {
                        // save form state to save all field
                        shippingController.formstate.currentState.save();
                        shippingController.insertAddress(Address(
                          id: shippingController.addressmodel != null
                              ? shippingController.addressmodel.id
                              : '',
                          firstname: shippingController.firstname,
                          lastname: shippingController.lastname,
                          location: shippingController.address,
                          state: shippingController.state,
                          city: shippingController.city,
                          postcode: shippingController.postcode,
                          country: shippingController.country,
                          phone: shippingController.phone,
                        ));
                        Get.back();

                        // Toast if added or updated
                        // if (shippingController.list_of_address.length == 0) {
                        //   Toast.show("Address Added", context,
                        //       duration: 2,
                        //       textColor: Colors.white,
                        //       backgroundColor: primarycolor,
                        //       gravity: Toast.CENTER);
                        // } else {
                        //   Toast.show("Address Updated", context,
                        //       duration: 2,
                        //       textColor: Colors.white,
                        //       backgroundColor: primarycolor,
                        //       gravity: Toast.CENTER);
                        // }
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
    ShippingController shippingController = Get.find();
    showCountryPicker(
      context: _context,
      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
      exclude: <String>['KN', 'MF'],
      //Optional. Shows phone code before the country name.
      showPhoneCode: true,

      onSelect: (Country country) {
        // print('Select country: ${country.displayName}');
        var countrycode = country.displayName.split("(");
        "(" + countrycode[1];
        shippingController.countryTextEditingcontroller.text =
            "(" + countrycode[1];
        //shippingController.country = "(" + countrycode[1];
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
