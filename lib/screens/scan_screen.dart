import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/theme.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedImage;
  bool _isAnalyzing = false;

  Future<void> _pickImage(ImageSource source) async {
    final image = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (image == null) return;

    setState(() {
      _selectedImage = image;
    });
  }

  Future<void> _analyzeCrop() async {
    if (_selectedImage == null) return;

    setState(() {
      _isAnalyzing = true;
    });

    // Temporary AI simulation.
    // This will be replaced by the real on-device AI model later.
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Save scan locally on the device.
    final prefs = await SharedPreferences.getInstance();

    final scans = prefs.getStringList('scan_history') ?? [];

    final scan = {
      'disease': 'Early Blight',
      'confidence': '91%',
      'severity': 'Moderate',
      'date': DateTime.now().toIso8601String(),
    };

    scans.insert(0, jsonEncode(scan));

    await prefs.setStringList('scan_history', scans);

    if (!mounted) return;

    setState(() {
      _isAnalyzing = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DiseaseResultScreen(
          image: _selectedImage!,
        ),
      ),
    );
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan crop'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EEE9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: CropGuardColors.border,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _selectedImage == null
                      ? const _EmptyScanArea()
                      : Stack(
                          children: [
                            Positioned.fill(
                              child: FutureBuilder(
                                future: _selectedImage!.readAsBytes(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return Image.memory(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),

                            Positioned(
                              top: 12,
                              right: 12,
                              child: IconButton(
                                onPressed: _clearImage,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                _selectedImage == null
                    ? 'Position the affected leaf clearly inside the frame.'
                    : 'Image ready for analysis.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: CropGuardColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              if (_selectedImage == null)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.photo_outlined),
                        label: const Text('Gallery'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _pickImage(ImageSource.camera);
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                        ),
                        label: const Text('Capture'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              CropGuardColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                    ),
                  ],
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isAnalyzing
                        ? null
                        : _analyzeCrop,
                    icon: _isAnalyzing
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.analytics_outlined,
                          ),
                    label: Text(
                      _isAnalyzing
                          ? 'Analyzing crop...'
                          : 'Analyze crop',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          CropGuardColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          CropGuardColors.primary,
                      disabledForegroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size.fromHeight(52),
                    ),
                  ),
                ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}


// ============================================================
// Empty scan area
// ============================================================

class _EmptyScanArea extends StatelessWidget {
  const _EmptyScanArea();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            size: 48,
            color: CropGuardColors.primary,
          ),

          SizedBox(height: 16),

          Text(
            'Capture a crop image',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: CropGuardColors.textPrimary,
            ),
          ),

          SizedBox(height: 6),

          Text(
            'Take a photo or choose one from gallery',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: CropGuardColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}


// ============================================================
// Disease Result Screen
// ============================================================

class DiseaseResultScreen extends StatelessWidget {
  final XFile image;

  const DiseaseResultScreen({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis result'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: image.readAsBytes(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox(
                      height: 260,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return ClipRRect(
                    borderRadius:
                        BorderRadius.circular(16),
                    child: Image.memory(
                      snapshot.data!,
                      width: double.infinity,
                      height: 260,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              const Text(
                'Possible disease detected',
                style: TextStyle(
                  fontSize: 14,
                  color:
                      CropGuardColors.textSecondary,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Early Blight',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color:
                      CropGuardColors.textPrimary,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _ResultValue(
                      title: 'Confidence',
                      value: '91%',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _ResultValue(
                      title: 'Severity',
                      value: 'Moderate',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: CropGuardColors.surface,
                  borderRadius:
                      BorderRadius.circular(14),
                  border: Border.all(
                    color: CropGuardColors.border,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What to do',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Remove severely affected leaves and monitor nearby plants. Avoid prolonged leaf wetness and follow recommended integrated pest management practices.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color:
                            CropGuardColors
                                .textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style:
                      OutlinedButton.styleFrom(
                    minimumSize:
                        const Size.fromHeight(48),
                  ),
                  child: const Text(
                    'Scan another crop',
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}


// ============================================================
// Result value widget
// ============================================================

class _ResultValue extends StatelessWidget {
  final String title;
  final String value;

  const _ResultValue({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CropGuardColors.surface,
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: CropGuardColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color:
                  CropGuardColors.textSecondary,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color:
                  CropGuardColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}