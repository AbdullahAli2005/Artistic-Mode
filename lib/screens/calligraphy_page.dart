import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CalligraphyPage2 extends StatefulWidget {
  const CalligraphyPage2({super.key});

  @override
  _CalligraphyPage2State createState() => _CalligraphyPage2State();
}

class _CalligraphyPage2State extends State<CalligraphyPage2> {
  final GlobalKey _globalKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  Color _textColor = Colors.black;
  Color _bgColor = const ui.Color.fromARGB(255, 224, 224, 224);
  double _fontSize = 50;
  String _selectedFont = 'Diwani';
  String _bgType = 'Solid Color';

  final List<String> _fonts = [
    'Aladin',
    'Alkalami',
    'Badar',
    'Bein Al Arab',
    'Cairo',
    'Diwani',
    "Harf",
    'Naqsh',
    'Maghribi',
    'Badeen',
    'Kufi',
    'Thuluth',
    'Ruqah',
    'Sahr',
    'Sukhan',
  ];
  final List<String> _bgOptions = [
    'Solid Color',
    'Gradient',
    'Classical Background'
  ];

  final List<String> _classicalBackgrounds = [
    'assets/images/classic1.png',
    'assets/images/classic2.jpg',
    'assets/images/classic3.jpg',
    'assets/images/classic4.jpg',
    'assets/images/classic5.jpg',
    'assets/images/classic6.jpg',
    'assets/images/classic10.png',
    'assets/images/classic8.jpg',
    'assets/images/classic9.png',
  ];
  String? _selectedBackground = "assets/images/classic1.png";

  final List<List<Color>> _gradients = [
    [Colors.blue, Colors.purple],
    [Colors.orange, Colors.red],
    [const ui.Color.fromARGB(255, 111, 84, 210), Colors.pinkAccent],
    [
      const ui.Color.fromARGB(255, 236, 88, 199),
      const ui.Color.fromARGB(255, 248, 105, 65)
    ],
    [
      const Color.fromARGB(255, 2, 120, 74),
      const Color.fromARGB(255, 120, 236, 123)
    ],
    [Colors.grey, Colors.black],
  ];
  List<Color> _selectedGradient = [Colors.blue, Colors.purple];

  List<Color> _generateRandomGradient() {
    Random random = Random();
    return List.generate(
        3,
        (_) => Color.fromARGB(
              255,
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ARTISTIC MODE',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ), // Ensure text is visible
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/appbar_background2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          /// Foreground Content
          Column(
            children: [
              /// Fixed Preview Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: RepaintBoundary(
                  key: _globalKey,
                  child: _buildPreviewCard(),
                ),
              ),

              /// Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      top: 0.0, left: 16, bottom: 16, right: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16), // Space after preview
                      _buildInputField(),
                      const SizedBox(height: 16),
                      _buildFontOptionsCard(),
                      const SizedBox(height: 16),
                      _buildBackgroundOptionsCard(),
                      const SizedBox(height: 16),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Enter Text',
            border: InputBorder.none,
          ),
          onChanged: (text) => setState(() {}),
        ),
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: _bgType == 'Solid Color' ? _bgColor : null,
          gradient: _bgType == 'Gradient'
              ? LinearGradient(
                  colors: _selectedGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)
              : null,
          image:
              _bgType == 'Classical Background' && _selectedBackground != null
                  ? DecorationImage(
                      image: AssetImage(_selectedBackground!),
                      fit: BoxFit.cover)
                  : null,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            _textController.text,
            style: TextStyle(
                fontSize: _fontSize,
                color: _textColor,
                fontFamily: _selectedFont),
          ),
        ),
      ),
    );
  }

  Widget _buildFontOptionsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown('Select Font:', _selectedFont, _fonts,
                (newFont) => setState(() => _selectedFont = newFont)),
            _buildColorPicker('Text Color:', _textColor,
                (color) => setState(() => _textColor = color)),
            _buildFontSizeSlider(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundOptionsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown('Background Type:', _bgType, _bgOptions,
                (newType) => setState(() => _bgType = newType)),
            if (_bgType == 'Solid Color')
              _buildColorPicker('Background Color:', _bgColor,
                  (color) => setState(() => _bgColor = color)),
            if (_bgType == 'Gradient') _buildGradientPicker(),
            if (_bgType == 'Classical Background')
              _buildClassicalBackgroundPicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(elevation: 3),
          onPressed: () async => await _saveImage(),
          icon: const Icon(
            Icons.save,
            color: Colors.deepPurpleAccent,
          ),
          label: const Text(
            'Save',
            style: TextStyle(color: Colors.deepPurpleAccent),
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(elevation: 3),
          onPressed: _shareImage,
          icon: const Icon(Icons.share, color: Colors.deepPurpleAccent),
          label: const Text(
            'Share',
            style: TextStyle(color: Colors.deepPurpleAccent),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> options,
      Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      // child: DropdownButtonFormField<String>(
      //   decoration: InputDecoration(
      //       labelText: label, border: const OutlineInputBorder()),
      //   value: value,
      //   items: options
      //       .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
      //       .toList(),
      //   onChanged: (newVal) => onChanged(newVal!),
      // ),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: (newVal) => onChanged(newVal!),
        items: options
            .map((opt) => DropdownMenuItem(
                  value: opt,
                  child: Text(
                    opt,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ))
            .toList(),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor:
              const ui.Color.fromARGB(255, 228, 230, 231), // Soft background
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: ui.Color.fromARGB(255, 85, 112, 126),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.blueGrey),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 6,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildColorPicker(
      String label, Color color, Function(Color) onColorSelected) {
    return ListTile(
      title: Text(label),
      trailing: Icon(Icons.color_lens, color: color),
      onTap: () => _pickColor(color, onColorSelected),
    );
  }

  Widget _buildGradientPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Select Gradient:'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Wrap(
              spacing: 10,
              children: [
                ..._gradients.map((grad) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedGradient = grad),
                        child: Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            gradient: LinearGradient(
                                colors: grad,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            border: Border.all(
                                color: _selectedGradient == grad
                                    ? const ui.Color.fromARGB(255, 70, 70, 70)
                                    : Colors.transparent,
                                width: 2),
                          ),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    child: ElevatedButton(
                      onPressed: () => setState(
                          () => _selectedGradient = _generateRandomGradient()),
                      style: ElevatedButton.styleFrom(
                          elevation: 3,
                          backgroundColor:
                              const ui.Color.fromARGB(255, 140, 98, 254)),
                      child: const Text(
                        'Random Gradient',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassicalBackgroundPicker() {
    return Align(
      child: Wrap(
        spacing: 10,
        children: _classicalBackgrounds
            .map((bg) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 8.0),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedBackground = bg),
                    child: Image.asset(bg,
                        width: 74, height: 48, fit: BoxFit.cover),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildFontSizeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Font Size: ${_fontSize.toInt()}'),
        Slider(
          value: _fontSize,
          activeColor: const ui.Color.fromARGB(255, 140, 98, 254),
          thumbColor: const ui.Color.fromARGB(255, 140, 98, 254),
          min: 20,
          max: 100,
          label: _fontSize.toInt().toString(),
          onChanged: (value) => setState(() => _fontSize = value),
        ),
      ],
    );
  }

  void _pickColor(Color initialColor, Function(Color) onColorSelected) {
    Get.dialog(
      AlertDialog(
        title: const Text('Pick a Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: initialColor,
            onColorChanged: onColorSelected,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close'))
        ],
      ),
    );
  }

  Future<void> _shareImage() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = File('${directory.path}/name_design.png');
      await imagePath.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(imagePath.path)],
          text: 'Check out my calligraphy design!');
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to share image',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  // Function to Capture & Save Image
  Future<void> _saveImage() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Get the directory
      Directory dir = Directory('/storage/emulated/0/Pictures/ArtisticMode');
      await dir.create(recursive: true);
      String filePath =
          "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.png";

      // Save the file
      File imgFile = File(filePath);
      await imgFile.writeAsBytes(pngBytes);

      // Make it visible in the gallery
      await _refreshGallery(imgFile.path);

      Fluttertoast.showToast(
          msg: "Image Saved Successfully", toastLength: Toast.LENGTH_SHORT);
    } catch (e) {
      print("Error saving image: $e");
      Fluttertoast.showToast(
          msg: "Image Saved", toastLength: Toast.LENGTH_SHORT);
    }
  }

  // Function to Make Image Visible in Gallery (Android Only)
  Future<void> _refreshGallery(String filePath) async {
    try {
      final result = await Process.run('am', [
        'broadcast',
        '-a',
        'android.intent.action.MEDIA_SCANNER_SCAN_FILE',
        '-d',
        'file://$filePath'
      ]);
      print("Gallery Refresh: ${result.stdout}");
    } catch (e) {
      print("Error refreshing gallery: $e");
    }
  }
}
