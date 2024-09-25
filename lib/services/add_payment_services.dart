import 'package:anugrah_lens/style/base_url.dart';
import 'package:dio/dio.dart';

class PaymentService {
  final Dio _dio = Dio();
 

  Future<Map<String, dynamic>> addPaymentDataAmount(
      int bayar, String glassId, String paidDate) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/add-installment/$glassId',
        data: {
          'amount': bayar,
          'paidDate': paidDate,
        },
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['message'], // Pesan sukses dari server
        };
      } else if (response.statusCode == 400) {
        // Jika status code 400, berarti ada kesalahan input (bad request)
        return {
          'success': false,
          'message': response.data['message'] ?? 'Bad request',
        };
      } else {
        // Jika status code lainnya
        throw Exception('Failed to fetch payment data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: $e');
      throw Exception('Failed to fetch payment data: ${e.message}');
    } catch (e) {
      print('General error: $e');
      throw Exception('Failed to fetch payment data');
    }
  }

  Future<Map<String, dynamic>> editInstallment(
      String installmentId, int amount, String paidDate) async {
    try {
      final response = await _dio.put(
        '$baseUrl/edit-installment/$installmentId',
        data: {
          'amount': amount,
          'paidDate': paidDate,
        },
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['message'] ??
              'Installment updated successfully', // Pesan sukses dari server
        };
      } else if (response.statusCode == 400) {
        // Jika status code 400, berarti ada kesalahan input (bad request)
        return {
          'success': false,
          'message': response.data['message'] ?? 'Bad request',
        };
      } else {
        throw Exception('Failed to update installment: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: $e');
      throw Exception('Failed to update installment: ${e.message}');
    } catch (e) {
      print('General error: $e');
      throw Exception('Failed to update installment');
    }
  }

  // Add any additional methods here if needed
}
