import 'package:anugrah_lens/style/base_url.dart';
import 'package:dio/dio.dart';

class CustomersService {
  final Dio _dio = Dio();

  Future<void> updateCustomer({
    required String idCustomer,
    required String glassId,
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
    required String paymentStatus,
  }) async {
    try {
      final response = await _dio.put(
        "$baseUrl/edit-customer/$idCustomer/$glassId",
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
          'paymentStatus': paymentStatus,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['error'] == false) {
          print('Customer and glass details updated successfully');
        } else {
          print('Server response error: ${data['message']}');
          throw Exception('Failed to update: ${data['message']}');
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        throw Exception(
            'Failed to update customer with status code ${response.statusCode}');
      }
    } on DioError catch (dioError) {
      // Handling DioError (HTTP error)
      if (dioError.response != null) {
        print('DioError response data: ${dioError.response?.data}');
        print('DioError status code: ${dioError.response?.statusCode}');
        print('DioError headers: ${dioError.response?.headers}');
      } else {
        // Something happened during request setting
        print('Error during request setup: $dioError');
      }
      throw Exception('Error updating customer: $dioError');
    } catch (error) {
      // Handling any other type of error
      print('General error: $error');
      throw Exception('Error updating customer');
    }
  }
}
