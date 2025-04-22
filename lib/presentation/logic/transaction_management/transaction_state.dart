import '../../../data/models/transactions_model/transaction_comparision_model.dart';
import '../../../data/models/transactions_model/transaction_management_model.dart';

class TransactionState {
  bool isLoading;
  bool isComparisionLoading;
  TransactionManagementModel transactions;
  TransactionComparisionModel transactionComparision;
  String transactionType;

  TransactionState({
    this.isLoading = false,
    this.isComparisionLoading = false,
    this.transactionType = "monthly",
    required this.transactions,
    required this.transactionComparision,
  });

  factory TransactionState.empty() => TransactionState(
      transactionComparision: TransactionComparisionModel(
        currentPeriod: [],
        previousPeriod: [],
      ),
      transactions: TransactionManagementModel(
        totalBalance: 0.0,
        allTransactions: [],
        buyerTransactions: [],
        sellerTransactions: [],
        adminTransactions: [],
        incomingOrdersProducts: [],
        stats: [],
      ));

  copyWith(
          {bool? isLoading,
          String? transactionType,
          TransactionManagementModel? transactions,
          bool? isComparisionLoading,
          TransactionComparisionModel? transactionComparision}) =>
      TransactionState(
        transactionType: transactionType ?? this.transactionType,
        transactionComparision:
            transactionComparision ?? this.transactionComparision,
        isComparisionLoading: isComparisionLoading ?? this.isComparisionLoading,
        isLoading: isLoading ?? this.isLoading,
        transactions: transactions ?? this.transactions,
      );
}
