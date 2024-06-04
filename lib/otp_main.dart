//212287
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OTPMain extends StatefulWidget {
  OTPMain({super.key, required this.step});

  int step;

  @override
  State<OTPMain> createState() => _OTPMainState();
}

class _OTPMainState extends State<OTPMain> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController OTPCodeController = TextEditingController();
  bool isValidated = false;
  String otp = '';

  @override
  void dispose() {
    phoneNumberController.dispose();
    OTPCodeController.dispose();
    super.dispose();
  }

  void validateForm() {
    final form = formKey.currentState;
    if (form != null) {
      if (widget.step == 1) {
        setState(() {
          isValidated = form.validate() && isChecked;
        });
      } else if (widget.step == 2) {
        setState(() {
          isValidated = form.validate();
          otp = OTPCodeController.text;
        });
      }
    }
  }

  //Phone number check
  String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      return 'Phone number must be only numeric';
    }
    return null;
  }

  //OTP check
  String? validateOTP(String? otp) {
    if (otp == null || otp.isEmpty) {
      return 'OTP is required';
    }
    bool isNumeric = RegExp(r'^[0-9]+$').hasMatch(otp);
    bool isCorrectLength = otp.length == 6;
    if (!isNumeric) {
      return 'OTP must be only numeric';
    }
    if (!isCorrectLength) {
      return 'OTP must be 6 digits long';
    }
    return null;
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.green;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.only(top: 5.w, left: 5.w),
            child: Image.asset('images/upm.jpg'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5.w),
                child: const Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 45.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCE4F0),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: widget.step == 1 ? buildOTPWelcomePage() : buildOTPActivatePage(),
                  ),
                ),
              ),
            ],
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Disclaimer | Privacy Statement",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Text('© Dayse Lew, 2024'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOTPWelcomePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Row(
          children: [
            Flexible(
              child: Text(
                'Enter your mobile number to activate your account.',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Icon(Icons.info_outline),
          ],
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Image.asset('images/flag.png', width: 40),
                  Container(
                    margin: const EdgeInsets.only(left: 45.0),
                    child: const Text('+60     '),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: phoneNumberController,
                  validator: validatePhoneNumber,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter phone number',
                  ),
                  onChanged: (value) => validateForm(),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                  validateForm();
                });
              },
            ),
            const Text('I agree to the terms & conditions'),
          ],
        ),
        ElevatedButton(
          onPressed: isValidated
              ? () {
            setState(() {
              widget.step = 2;
              isValidated = false;
              isChecked = false;
            });
          }
              : null,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Get Activation Code',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOTPActivatePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Row(
          children: [
            Flexible(
              child: Text(
                'Enter the activation code you received via SMS.',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Icon(Icons.info_outline),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Form(
                    key: formKey,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: OTPCodeController,
                      validator: validateOTP,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'OTP',
                      ),
                      onChanged: (value) => validateForm(),
                    ),
                  ),
                  Text(
                    '${otp.length}/6',
                  ),
                ],
              ),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Didn't receive? "),
            Text(
              "Tap here",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        ElevatedButton(
            onPressed: isValidated
                ? () {
              Navigator.pushNamed(context, '/');
            }
                : null,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Activate',
                style: TextStyle(fontSize: 20.0),
              ),
            )),
      ],
    );
  }
}
