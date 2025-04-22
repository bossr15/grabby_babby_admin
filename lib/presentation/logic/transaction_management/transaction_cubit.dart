import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/data/repositories/transaction_repository/transaction_repository.dart';
import 'package:grabby_babby_admin/presentation/logic/transaction_management/transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final transactionRepository = TransactionRepository();

  TransactionCubit() : super(TransactionState.empty()) {
    fetchTransactions();
    fetchTransactionComparision();
  }

  void fetchTransactions() {
    emit(state.copyWith(isLoading: true));
    transactionRepository.getTransactionDetail().then(
          (response) => response.fold((error) {
            emit(state.copyWith(isLoading: false));
          }, (data) {
            emit(state.copyWith(isLoading: false, transactions: data));
          }),
        );
  }

  void fetchTransactionComparision() {
    emit(state.copyWith(isComparisionLoading: true));
    transactionRepository
        .getTransactionComparision(type: state.transactionType.toLowerCase())
        .then(
          (response) => response.fold((error) {
            emit(state.copyWith(isComparisionLoading: false));
          }, (data) {
            emit(state.copyWith(
                isComparisionLoading: false, transactionComparision: data));
          }),
        );
  }

  void setTransactionFilterType(String filter) async {
    emit(state.copyWith(transactionType: filter));
    fetchTransactionComparision();
  }
}
