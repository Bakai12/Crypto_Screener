import 'dart:async';

import 'package:crypto_coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';



class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

 

  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>(),
  );
  
  
  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
          if(state is CryptoListLoaded){
          return ListView.separated(
          padding: const EdgeInsets.only(top:16),
          itemCount: state.coinsList.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, i) {
            final coin = state.coinsList[i];  
            return CryptoCoinTile(coin: coin);
        },
        );
            }
            if (state is CryptoListLoadingFailure) {
        return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'No network connection',
            style: TextStyle(fontSize: 26),
          ),
          const Opacity(
            opacity: 0.5,
            child: Text(
              'Check your internet',
              style: TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () {
              _cryptoListBloc.add(LoadCryptoList());
            },
            child: const Text('Try again'),
          ),
        ],
          ),
        );
      }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

