part of 'shared.dart';
const Color bluishClr = Color(0xFF4e5ae8);
const Color pinkClr = Color(0xFFFF69B4);
const Color lightblueColor = Color(0XFF83EAF1);
const Color blueColor = Color(0xFF63A4FF);
const Color primaryColor = bluishClr;
const Color yellowColor = Color(0xFFFFB746);
const Color redColor = Color(0xFFff4667);
const Color greenColor = Color(0xFF50C878);
const Color darkGreyColor = Color(0xFF121212);
const Color lightGreyColor = Color(0xFFf9f9f9);
const Color greyColor = Color(0xFF808080);
Color darkHeaderColor = const Color(0xFF424242);

class Themes{

static final light = ThemeData(
  backgroundColor: Colors.white,
  primaryColor: Colors.blue,
  brightness: Brightness.light
  );

static final dark = ThemeData(
  backgroundColor: darkGreyColor,
  primaryColor: darkGreyColor,
  brightness: Brightness.dark
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato (
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black
    )
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato (
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black
    )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato (
    textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.black
    )
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: darkHeaderColor
    )
  );
}

TextStyle get normalStyle{
  return GoogleFonts.lato (
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black
    )
  );
}

TextStyle get bigNormalStyle{
  return GoogleFonts.lato (
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black
    )
  );
}