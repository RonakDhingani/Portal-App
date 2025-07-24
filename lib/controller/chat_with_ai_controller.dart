import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groq/groq.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inexture/common_widget/global_value.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../common_widget/app_string.dart';
import '../common_widget/asset.dart';
import '../screen/chat_with_ai/chat_with_ai/chat_message_component/chat_message.dart';

class ChatWithAiController extends GetxController {
  final TextEditingController txtController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<ChatMessage> messages = <ChatMessage>[];
  late final Groq groq;
  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  bool isTyping = false;
  bool isErrorLimitReach = false;
  String _lastWords = "";
  ValueNotifier<double> sliderValue = ValueNotifier(0.5);
  ValueNotifier<ImageItem> imageValueListen = ValueNotifier(
    ImageItem(id: "1", name: "Himalayas", path: AssetImg.himalayasImg),
  );
  String selectedImagePath = AssetImg.himalayasImg;

  @override
  void onInit() {
    super.onInit();
    loadSelectedImage();
    groq = Groq(
      apiKey: const String.fromEnvironment(
        'API_KEY',
      ),
      model: "llama3-70b-8192",
    );
    messages.add(
      ChatMessage(
        text:
            'Hello ${userName ?? ''} ${gender == 'male' ? 'Sir' : 'Mam'},\tHow can I help you?',
        isUserMessage: false,
      ),
    );
    listenForPermissions();
    if (!speechEnabled) {
      initSpeech();
    }
    groq.startChat();
    speechToText.statusListener = (status) {
      update();
      log("speech to text 1: $status");
    };
  }

  @override
  void onClose() {
    scrollController.dispose();
    txtController.dispose();
    isErrorLimitReach = false;
    super.onClose();
  }

  Future<void> loadSelectedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedImageId = prefs.getString('selectedImageId');
    String? savedImagePath = prefs.getString('selectedImagePath');
    double? slidValue = prefs.getDouble('sliderValue') ?? 0.5;

    if (savedImageId != null && savedImagePath != null) {
      if (savedImageId == "custom_image_chat") {
        if (File(savedImagePath).existsSync()) {
          selectedImagePath = savedImagePath;
        }
      } else {
        var selectedImageItem =
            imageList.firstWhere((image) => image.id == savedImageId);
        selectedImagePath = selectedImageItem.path;
        imageValueListen.value = selectedImageItem;
      }
      sliderValue.value = slidValue;
      update();
    } else {
      selectedImagePath = imageList.first.path;
      update();
    }
  }

  Future<void> saveSelectedImage(
      {required String imageId,
      required double sliderValue,
      required String imagePath}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedImageId');
    await prefs.remove('selectedImagePath');
    await prefs.remove('sliderValue');

    await prefs.setString('selectedImageId', imageId);
    await prefs.setString('selectedImagePath', imagePath);
    await prefs.setDouble('sliderValue', sliderValue);
    selectedImagePath = imagePath;
  }

  Future<void> pickImageFromGallery() async {
    final photosPermission = await Permission.photos.request();
    final storagePermission = await Permission.storage.request();

    if (photosPermission.isGranted || storagePermission.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImagePath = image.path;
        update();
      }
    } else if (photosPermission.isPermanentlyDenied ||
        storagePermission.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      print("Permission denied!");
    }
  }

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
    update();
  }

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    if (status.isDenied) {
      requestForPermission();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  void startListening() async {
    var systemLocale = await speechToText.systemLocale();
    await speechToText.listen(
      onResult: onSpeechResult,
      onSoundLevelChange: (level) {},
      onDevice: true,
      listenOptions: SpeechListenOptions(
        listenMode: ListenMode.deviceDefault,
        partialResults: true,
        autoPunctuation: true,
        cancelOnError: true,
      ),
      localeId: systemLocale?.localeId ?? 'en_US',
    );
    update();
  }

  void stopListening() async {
    await speechToText.stop();
    update();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = "${result.recognizedWords} ";
    txtController.text = _lastWords;
    update();
  }

  void handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    txtController.clear();

    ChatMessage userMessage = ChatMessage(text: text, isUserMessage: true);
    messages.add(userMessage);
    update();
    scrollToBottomWithDelay(const Duration(milliseconds: 200));

    isTyping = true;
    update();

    await sendAiMessage(text);

    isTyping = false;
    update();
  }

  void scrollToBottomWithDelay(Duration delay) async {
    await Future.delayed(delay);
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> sendAiMessage(String text) async {
    try {
      GroqResponse response = await groq.sendMessage(text);
      if (response.choices.isNotEmpty) {
        ChatMessage responseMessage = ChatMessage(
          text: response.choices.first.message.content,
          isUserMessage: false,
        );
        messages.add(responseMessage);
        update();
        scrollToBottomWithDelay(const Duration(milliseconds: 200));
      } else {
        sendAiMessage(txtController.text);
      }
    } on GroqException catch (error) {
      if (error.message == "Invalid API Key") {
        log("API key Issue :  ${error.message}");
        messages.add(ErrorMessage(text: AppString.somethingWentWrong));
      } else {
        log("Limit Reached :  ${error.message}");
        isErrorLimitReach = true;
        messages.add(ErrorMessage(text: AppString.youReachTheLimits));
      }
    } catch (e) {
      sendAiMessage(txtController.text);
    } finally {
      update();
      scrollToBottomWithDelay(const Duration(milliseconds: 300));
    }
  }
}
