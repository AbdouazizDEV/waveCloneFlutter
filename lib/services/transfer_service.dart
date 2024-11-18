// lib/services/transfer_service.dart


import 'http/dio_client.dart';
import '../models/transfer_request.dart';
class TransferService {
  final DioClient _client;

  TransferService(this._client);

 Future<Map<String, dynamic>> simpleTransfer(TransferRequest request) async {
    try {
      final response = await _client.post('/transfer', request.toJson());
      return response.data;
    } catch (e) {
      throw Exception('Échec du transfert: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> multipleTransfer(MultipleTransferRequest request) async {
    try {
      final response = await _client.post('/transfer/multiple', request.toJson());
      return response.data;
    } catch (e) {
      throw Exception('Échec du transfert multiple: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> scheduleTransfer(ScheduledTransferRequest request) async {
    try {
      final response = await _client.post('/transfer/schedule', request.toJson());
      return response.data;
    } catch (e) {
      throw Exception('Échec de la planification: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> cancelTransfer(int transferId) async {
    try {
      final response = await _client.post('/transfer/cancel', {'transfer_id': transferId});
      return response.data;
    } catch (e) {
      throw Exception('Échec de l\'annulation: ${e.toString()}');
    }
  }
}