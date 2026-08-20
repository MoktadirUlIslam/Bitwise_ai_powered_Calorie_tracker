import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // <-- ADD THIS IMPORT
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initCamera();
    });
  }

  Future<void> _initCamera() async {
    try {
      await Permission.camera.request();

      List<CameraDescription> cameras = [];
      try {
        cameras = await availableCameras();
      } catch (e) {
        await Future.delayed(const Duration(milliseconds: 500));
        cameras = await availableCameras();
      }

      if (cameras.isEmpty) {
        print("No cameras found on device.");
        return;
      }

      final firstCamera = cameras.first;
      _controller = CameraController(firstCamera, ResolutionPreset.medium);
      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print("!!! FINAL CAMERA ERROR: $e !!!");
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      setState(() {
        _isCameraInitialized = false;
      });

      final image = await _controller!.takePicture();
      print("Picture saved to: ${image.path}");

      if (mounted) {
        // Navigate back to home using go_router
        context.go('/');
      }
    } catch (e) {
      print("Error taking picture: $e");
      if (mounted) setState(() => _isCameraInitialized = true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/Homescreen'); // Navigate to home screen using go_router
          },
        ),
        title: const Text("Scan your food"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () {
              // Simple toggle flash logic placeholder
            },
          )
        ],
      ),
      body: Stack(
        children: [
          // Camera Preview
          Center(
            child: _isCameraInitialized
                ? CameraPreview(_controller!)
                : const CircularProgressIndicator(color: Colors.white),
          ),

          // Food Scanner Overlay (UI frame)
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),

          // Shutter Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}