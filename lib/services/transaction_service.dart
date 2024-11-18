// lib/services/transaction_service.dart

import 'package:dio/dio.dart';
import '../models/transaction.dart';
import 'http/dio_client.dart';
import './http/api_endpoints.dart';
import '../models/transfer_request.dart';
import '../models/transfer_response.dart';
class TransactionService {
  final DioClient _client;

  TransactionService(this._client);

  Future<Map<String, dynamic>> getTransactionHistory() async {
    try {
      final response = await _client.get('/transactions/history');
      final data = response.data['data'];

      return {
        'transactions': (data['transactions'] as List)
            .map((json) => Transaction.fromJson(json))
            .toList(),
        'stats': TransactionStats.fromJson(data['stats']),
        'pagination': data['pagination'],
      };
    } catch (e) {
      throw Exception('Échec de récupération de l\'historique: ${e.toString()}');
    }
  }
  Future<TransferResponse> simpleTransfer(TransferRequest request) async {
    try {
      final response = await _client.post('/transfer', request.toJson());
      return TransferResponse.fromJson(response.data);
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