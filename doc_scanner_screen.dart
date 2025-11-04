import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocScannerScreen extends StatelessWidget {
  const DocScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFFB894F6);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lightbulb_outline, color: Colors.black),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'HD',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Camera view with purple brackets
          Expanded(
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  // Center square
                  Center(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        border: Border.all(color: purple, width: 4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  // Corner brackets
                  _cornerBracket(alignment: Alignment.topLeft, purple: purple),
                  _cornerBracket(alignment: Alignment.topRight, purple: purple),
                  _cornerBracket(alignment: Alignment.bottomLeft, purple: purple),
                  _cornerBracket(alignment: Alignment.bottomRight, purple: purple),
                ],
              ),
            ),
          ),

          // Bottom sheet controls
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Mode row with underline under Docs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _modeLabel('Paragraph to word'),
                    Column(
                      children: [
                        _modeLabel('Docs', bold: true),
                        const SizedBox(height: 4),
                        Container(width: 24, height: 2, color: purple),
                      ],
                    ),
                    _modeLabel('ID Card'),
                    _modeLabel('Image to text'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _circleButton(icon: Icons.photo_library_outlined, purple: purple),
                    _circleButton(icon: Icons.brightness_1, purple: purple, hollow: true),
                    _cameraButton(purple),
                    _circleButton(icon: Icons.insert_drive_file_outlined, purple: purple),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _modeLabel(String text, {bool bold = false}) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
        color: Colors.black87,
      ),
    );
  }

  Widget _circleButton({required IconData icon, required Color purple, bool hollow = false}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: hollow ? Colors.white : purple.withOpacity(0.2),
        shape: BoxShape.circle,
        boxShadow: hollow
            ? null
            : const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
        border: hollow ? Border.all(color: purple, width: 2) : null,
      ),
      child: Icon(icon, color: purple),
    );
  }

  Widget _cameraButton(Color purple) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: purple.withOpacity(0.5), blurRadius: 16, spreadRadius: 1),
          const BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Icon(Icons.camera_alt_outlined, color: purple, size: 26),
    );
  }

  Widget _cornerBracket({required Alignment alignment, required Color purple}) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: purple, width: 6),
                      left: BorderSide(color: purple, width: 6),
                      right: BorderSide(color: alignment == Alignment.topLeft || alignment == Alignment.bottomLeft ? Colors.transparent : purple, width: 6),
                      bottom: BorderSide(color: alignment == Alignment.topLeft || alignment == Alignment.topRight ? Colors.transparent : purple, width: 6),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}