import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({Key? key}) : super(key: key);

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _controller = TextEditingController(text: '+91 ');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onKeyTap(String value) {
    setState(() {
      _controller.text += value;
    });
  }

  void _onBackspace() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        _controller.text = _controller.text.substring(0, _controller.text.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFB894F6);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header illustration area to match design
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.phone_iphone, color: Color(0xFFB894F6), size: 72),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Enter Your  Phone Number',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.flag_outlined),
              ),
              keyboardType: TextInputType.none,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/phone-verify');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Continue', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 28,
                crossAxisSpacing: 28,
                children: [
                  ...List.generate(9, (i) => _key('${i + 1}')),
                  const SizedBox.shrink(),
                  _key('0'),
                  _keyIcon(Icons.backspace_outlined, onTap: _onBackspace),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _key(String value) {
    const accent = Color(0xFFB894F6);
    return GestureDetector(
      onTap: () => _onKeyTap(value),
      child: Center(
        child: Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: accent,
          ),
        ),
      ),
    );
  }

  Widget _keyIcon(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Icon(icon, color: Colors.black87),
      ),
    );
  }
}