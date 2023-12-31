import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardTotal extends StatefulWidget {

  final IconData? leadingIcon;
  final String? title;
  final String trailingText;
  final double currentValue;
  final double maxValue;

  const CardTotal({
    Key? key,
    this.leadingIcon,
    this.title,
    required this.trailingText,
    required this.currentValue,
    required this.maxValue,
  }): super(key: key);

  @override
  State<CardTotal> createState() => _CardTotalState();
}

class _CardTotalState extends State<CardTotal> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: widget.leadingIcon != null ? Icon(widget.leadingIcon) : null,
              title: widget.title != null ? Text(widget.title ?? '', style: GoogleFonts.poppins()) : null,
              trailing: Text(widget.trailingText, style: GoogleFonts.poppins()),
            ),
            widget.currentValue != 0 && widget.maxValue != 0
                ? LinearProgressIndicator(
              value: widget.currentValue / widget.maxValue,
              color: Colors.teal,
              backgroundColor: Colors.grey[200],
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
