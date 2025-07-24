import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:inexture/model/policies_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../common_widget/api_url.dart';
import '../services/api_function.dart';
import '../utils/utility.dart';

class PoliciesController extends GetxController {
  RxBool isLoading = false.obs;
  RxMap<int, bool> isFileDownloadingOrOpening = <int, bool>{}.obs;
  RxMap<int, bool> isFileAlreadyDownloaded = <int, bool>{}.obs;
  PoliciesModel? policiesModel;
  RxMap<int, double> downloadedBytes = <int, double>{}.obs;
  RxMap<int, double> totalBytes = <int, double>{}.obs;

  CancelToken? _cancelToken;

  @override
  void onInit() {
    _cancelToken = CancelToken();
    getPolicies();
    super.onInit();
  }

  @override
  void onClose() {
    _cancelToken?.cancel();
    super.onClose();
  }

  Future<void> getPolicies() async {
    isLoading.value = true;
    update();

    ApiFunction.apiRequest(
      url: '${ApiUrl.policies}?page_size=50',
      method: 'GET',
      onSuccess: (value) async {
        log(value.statusCode.toString());
        log(value.statusMessage.toString());
        log('policies API Response : ${value.data.toString()}');
        policiesModel = PoliciesModel.fromJson(value.data);
        for (int i = 0; i < (policiesModel?.results?.length ?? 0); i++) {
          final fileName = _getFileNameFromUrl(policiesModel!.results![i].file ?? '');
          final filePath = await getTemporaryFilePath(fileName);
          isFileAlreadyDownloaded[i] = File(filePath).existsSync();
        }
        isLoading.value = false;
        update();
      },
      onUnauthorized: (p0) {
        ApiFunction.refreshTokenApi().then(
          (value) => getPolicies(),
        );
      },
      onError: (value) {
        print('policies API Response : ${value.data.toString()}');
        Utility.showFlushBar(text: value.data['error']['message']);
        isLoading.value = false;
        update();
      },
    );
  }

  Future<void> openOtherAppFile(
      {required String url, required int index}) async {
    isFileDownloadingOrOpening[index] = true;
    try {
      final fileName = _getFileNameFromUrl(url);
      final filePath = await getTemporaryFilePath(fileName);

      if (File(filePath).existsSync()) {
        await openFile(filePath);
      } else {
        final downloadedFilePath = await downloadFile(
          url: url,
          fileName: fileName,
          savePath: filePath,
          index: index,
        );
        await openFile(downloadedFilePath);
        isFileAlreadyDownloaded[index] = true;
      }
    } catch (e) {
      log("Error opening file: $e");
    } finally {
      isFileDownloadingOrOpening[index] = false;
    }
  }

  String _getFileNameFromUrl(String url) {
    Uri uri = Uri.parse(url);
    return uri.pathSegments.last.isNotEmpty
        ? uri.pathSegments.last
        : 'sample.pdf';
  }

  Future<void> openFile(String filePath) async {
    if (_cancelToken?.isCancelled == true) return;
    await OpenFile.open(filePath);
  }

  Future<String> getTemporaryFilePath(String fileName) async {
    final directory = await getTemporaryDirectory();
    return '${directory.path}/$fileName';
  }

  Future<String> downloadFile({
    required String url,
    required String fileName,
    required String savePath,
    required int index,
  }) async {
    final dio = Dio();
    downloadedBytes[index] = 0;
    totalBytes[index] = 1;

    try {
      await dio.download(
        url,
        savePath,
        cancelToken: _cancelToken,
        onReceiveProgress: (received, total) {
          downloadedBytes[index] = received.toDouble();
          totalBytes[index] = total.toDouble();
        },
      );
    } catch (e) {
      log('Download failed: $e');
    }

    return savePath;
  }
}
