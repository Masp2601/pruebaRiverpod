import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_prueba/common/utils/constants.dart';
import 'package:riverpod_prueba/common/widgets/appStyle.dart';
import 'package:riverpod_prueba/common/widgets/custom_text.dart';
import 'package:riverpod_prueba/common/widgets/reusable_text.dart';
import 'package:riverpod_prueba/common/widgets/showDialoge.dart';
import 'package:riverpod_prueba/features/auth/controller/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();

  // Variable para almacenar el país seleccionado
  Country? selectedCountry;

  Country country = Country(
    phoneCode: '57',
    countryCode: 'COL',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'COL',
    example: 'COL',
    displayName: 'Colombia',
    displayNameNoCountryCode: 'COL',
    e164Key: '',
  );

  sendCodeUser() {
    if (phone.text.isEmpty) {
      showAlertDialog(
          context: context, message: 'Ingrese su número de telefono');
    } else if (phone.text.length < 8) {
      showAlertDialog(
          context: context, message: 'Ingrese la cantidad de números correcta');
    } else {
      ref.read(authControllerProvider).sendSms(
          context: context, phone: '+${country.phoneCode}${phone.text}');
    }
  }

  double pxToDouble(double px) {
    double scaleFactor = MediaQuery.of(context).devicePixelRatio;
    double logicalPixels = px / scaleFactor;
    return logicalPixels;
  }

  @override
  Widget build(BuildContext context) {
    double width = pxToDouble(642);
    double height = pxToDouble(944);

    // Verificar el ancho de la pantalla para decidir si mostrar la imagen lateral o no
    bool isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppConst.buttonBackground,
          ),
          onPressed: () {},
        ),
        title: ReusableText(
          text: 'Atrás',
          style: appStyle(15, AppConst.dark, FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    if (isLargeScreen)
                      Expanded(
                        flex: 2,
                        child: ClipRect(
                          child: SizedBox(
                            width: width,
                            height: height,
                            child: Image.asset(
                              "assets/images/Imagen_lateral.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    if (isLargeScreen) const SizedBox(width: 20),
                    Expanded(
                      flex: isLargeScreen ? 3 : 1,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ReusableText(
                                text:
                                    'Ingresa tu número de celular para iniciar',
                                style: appStyle(
                                    12, AppConst.dark, FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Mostrar el selector de país
                                      showCountryPicker(
                                          context: context,
                                          countryListTheme:
                                              CountryListThemeData(
                                            backgroundColor: AppConst.light,
                                            bottomSheetHeight:
                                                AppConst.heigth * 0.8,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  AppConst.radius),
                                              topRight: Radius.circular(
                                                  AppConst.radius),
                                            ),
                                          ),
                                          onSelect: (code) {
                                            // Almacenar el país seleccionado
                                            setState(() {
                                              country = code;
                                            });
                                          });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      child: ReusableText(
                                        // Mostrar el código del país seleccionado
                                        text:
                                            '${country.flagEmoji} + ${country.phoneCode}',
                                        style: appStyle(
                                            18, AppConst.dark, FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: phone,
                                      keyboardType: TextInputType.number,
                                      hinText: 'Número de celular',
                                      hintStyle: appStyle(
                                          16, AppConst.dark, FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  sendCodeUser();
                                },
                                child: Image.asset(
                                  "assets/images/Continuar.png",
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
