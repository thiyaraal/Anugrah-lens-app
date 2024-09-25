import 'package:anugrah_lens/style/base_url.dart';
import 'package:dio/dio.dart';

class CustomerService {
  final Dio _dio = Dio();

  Future<String> addCustomer({
    required String name,
    required String phone,
    required String address,
    required String frame,
    required String lensType,
    required String left,
    required String right,
    required int price,
    required int deposit,
    required String orderDate,
    required String deliveryDate,
    required String paymentMethod,
  }) async {
    try {
      final response = await _dio.post(
        '$baseUrl/add-customer',
        data: {
          'name': name,
          'phone': phone,
          'address': address,
          'frame': frame,
          'lensType': lensType,
          'left': left,
          'right': right,
          'price': price,
          'deposit': deposit,
          'orderDate': orderDate,
          'deliveryDate': deliveryDate,
          'paymentMethod': paymentMethod,
        },
      );

      if (response.statusCode == 200) {
        return response.data['message'] ?? 'Customer added successfully';
      } else {
        // Throw error if status code is not 200
        throw Exception(response.data['message'] ?? 'An error occurred');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Get the error message from the server
        final errorMessage = e.response?.data['message'] ?? 'An error occurred';
        throw Exception(errorMessage);
      } else {
        // If no response from server, show a connection error message
        throw Exception('Failed to connect to the server: ${e.message}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
