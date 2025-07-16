import 'package:final_project_ypu/Booking_scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Patient_information extends StatefulWidget {
  static String id = "Patient_information";
  const Patient_information({super.key});

  @override
  State<Patient_information> createState() => _Patient_informationState();
}

class _Patient_informationState extends State<Patient_information> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _patientPhoneController = TextEditingController();
  final TextEditingController _patientAgeController = TextEditingController();
  final TextEditingController _patientGenderController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _phone = "";
  String _age = "";
  String _gender = "";
  String _Name = "";

  bool _isLoading = false; // Flag to show loading animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3F51B5),
        title: Text(
          'Patient Information',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [const Color(0xFF3F51B5), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30.h),
                      Image.asset('assets/images/Person.png', width: 100.w),
                      SizedBox(height: 15.h),
                      Text(
                        "Patient Information",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Please fill in the patient details",
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
                TextFormField(
                  controller: _patientNameController,
                  keyboardType:
                      TextInputType.text, // تأكد من أن هذا يقبل نصوص فقط
                  decoration: _buildInputDecoration("Name", Icons.person),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name.';
                    }
                    // التأكد من أن المدخل يحتوي فقط على حروف (الأحرف الكبيرة والصغيرة فقط)
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return 'Name must be a string.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.h),
                // حقل رقم الهاتف (يقبل أرقام فقط)
                TextFormField(
                  controller: _patientPhoneController,

                  keyboardType: TextInputType.phone,
                  decoration: _buildInputDecoration("Phone", Icons.phone),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number.';
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      // التحقق من أن الرقم مكون من 10 أرقام
                      return 'Phone number must be 10 digits.';
                    }
                    return null;
                  },
                  onSaved: (value) => _phone = value!,
                ),
                SizedBox(height: 20.h),

                // حقل العمر (يقبل فقط بين 1 و 99)
                TextFormField(
                  controller: _patientAgeController,

                  keyboardType: TextInputType.number,
                  decoration: _buildInputDecoration("Age", Icons.numbers),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age.';
                    }
                    int? age = int.tryParse(value);
                    if (age == null || age < 1 || age > 99) {
                      return 'Age must be between 1 and 99.';
                    }
                    return null;
                  },
                  onSaved: (value) => _age = value!,
                ),
                SizedBox(height: 20.h),

                // اختيار الجنس
                DropdownButtonFormField<String>(
                  decoration: _buildInputDecoration("Gender", Icons.person),
                  items:
                      <String>['Male', 'Female'].map<DropdownMenuItem<String>>((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a gender.';
                    }
                    return null;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _gender = newValue!;
                      _patientGenderController.text = newValue!;
                    });
                  },
                ),
                SizedBox(height: 40.h),

                // زر التالي
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });

                      Future.delayed(const Duration(seconds: 2), () {
                        _formKey.currentState!.save();
                        setState(() {
                          _isLoading = false;
                        });

                        // الانتقال إلى صفحة الحجز
                        _Name = _patientNameController.text;
                        _phone = _patientPhoneController.text;
                        _age = _patientAgeController.text;
                        _gender = _patientGenderController.text;

                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Patient_Booking(
                                      name: _Name,
                                      phone: _phone,
                                      age: _age,
                                      gender: _gender,
                                    ),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F51B5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: TextStyle(fontSize: 18.sp),
                  ),
                  child: Text("Next", style: TextStyle(color: Colors.white)),
                ),

                // عرض أنيميشن التحميل عند الضغط
                if (_isLoading)
                  Center(
                    child: Lottie.asset(
                      'assets/animations/Animation - 1738136512865.json',
                      height: 100.h,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لإنشاء تصميم الحقول بشكل موحد
  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFE0F7FA),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      prefixIcon: Icon(icon, color: const Color(0xFF2196F3)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Color(0xFF2196F3), width: 2.w),
      ),
    );
  }
}
