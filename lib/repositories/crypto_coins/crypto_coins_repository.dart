// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
  });
  
  final Dio dio;
  

  @override
  Future<List<CryptoCoin>> getCoinstList() async {
    final response = await dio.get(
    'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,XRP,PEPE,SUI,DOGE,NOT,DOGS,USDC,TRX,ADA,AVAX,TON,LTC,NEAR,APT,POL,ARB,OP&tsyms=USD');
  
  final data = response.data as Map<String, dynamic>;
  final dataRaw = data['RAW'] as Map<String, dynamic>;
  final cryptoCoinsList = dataRaw.entries
  .map((e) {
    final usdData = (e.value as Map<String, dynamic>) ['USD'] as Map<String, dynamic>;
    final price = usdData['PRICE'];
    final imageUrl = usdData['IMAGEURL'];
    return CryptoCoin(
    name: e.key,
    priceInUSD: price,
    imageUrl: 'https://cryptocompare.com$imageUrl',
  );})
  .toList();
  return cryptoCoinsList;
  }
}
