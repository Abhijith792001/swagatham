import 'package:get/get.dart';
import 'package:swagatham/Pages/InstructionPage/model/instruction_model.dart';
import 'package:swagatham/service/api_service.dart';

class InstructionController extends GetxController {
  final ApiService apiService = Get.find();

  final Rx<InstructionModel?> instructionData = Rx<InstructionModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInstruction();
  }

  Future<void> fetchInstruction() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final payload = {
        // "login_name": "shyamdassd@am.amrita.edu",
        // "password": "test@123",
      };

      final response = await apiService.postApi('instruction',  {});

      if (response.statusCode == 200) {
        final responseData = response.data;
        print('Response Type: ${responseData.runtimeType}');

        if (responseData is Map && responseData['success'] == true) {
          instructionData.value = InstructionModel.fromJson(responseData  as dynamic);
        } else {
          errorMessage.value = 'Failed to load instructions: ${responseData['message'] ?? 'Unknown error'}';
        }
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
      }
    } catch (e, stackTrace) {
      errorMessage.value = 'Error loading instructions. Please try again.';
      Get.log('Error in fetchInstruction: $e\n$stackTrace', isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}