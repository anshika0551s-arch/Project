import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );
  final _apiService = ApiService();
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Verify Phone',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Phone icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(105, 73, 255, 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone_android,
                size: 40,
                color: Color(0xFFB894F6),
              ),
            ),
            const SizedBox(height: 30),
            
            // Title and description
            Text(
              'Code is sent to 283 835 2999',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            // OTP input fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => _buildOtpTextField(index),
              ),
            ),
            const SizedBox(height: 40),
            
            // Verify button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          final otp = _controllers.map((c) => c.text).join();
                          final response = await _apiService.verifyPhone(
                            '2838352999', // Hardcoded for now
                            otp,
                          );
                          if (response.statusCode == 200) {
                            Navigator.pushNamed(context, '/verified');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Verification failed. Please try again.'),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('An error occurred. Please try again.'),
                            ),
                          );
                        }
                        setState(() {
                          _isLoading = false;
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB894F6),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        'Verify and Create Account',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Didn't recieve code? Request again",
              style: GoogleFonts.poppins(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 28,
                crossAxisSpacing: 28,
                children: [
                  ...List.generate(9, (i) => _digitKey('${i + 1}')),
                  const SizedBox.shrink(),
                  _digitKey('0'),
                  _keyIcon(Icons.backspace_outlined, onTap: _onBackspace),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpTextField(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.none,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          }
        },
      ),
    );
  }

  Widget _digitKey(String value) {
    const accent = Color(0xFFB894F6);
    return GestureDetector(
      onTap: () {
        // Append to first empty OTP field for demo purposes
        for (int i = 0; i < _controllers.length; i++) {
          if (_controllers[i].text.isEmpty) {
            _controllers[i].text = value;
            if (i < _focusNodes.length - 1) {
              _focusNodes[i + 1].requestFocus();
            }
            break;
          }
        }
      },
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

  void _onBackspace() {
    for (int i = _controllers.length - 1; i >= 0; i--) {
      if (_controllers[i].text.isNotEmpty) {
        _controllers[i].clear();
        _focusNodes[i].requestFocus();
        break;
      }
    }
  }
}
