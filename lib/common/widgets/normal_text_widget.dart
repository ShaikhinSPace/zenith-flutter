import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalTextWidget extends StatelessWidget {
  final String text;
  const NormalTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont('Poppins').copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }
}

class Headline1Text extends StatelessWidget {
  final String text;
  const Headline1Text({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: Theme.of(context).textTheme.headlineLarge?.color,
        ),
      ),
    );
  }
}

class Headline2Text extends StatelessWidget {
  final String text;
  const Headline2Text({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.headlineMedium?.color,
        ),
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;
  const BodyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}

class CaptionText extends StatelessWidget {
  final String text;
  const CaptionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w300,
          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
        ),
      ),
    );
  }
}
