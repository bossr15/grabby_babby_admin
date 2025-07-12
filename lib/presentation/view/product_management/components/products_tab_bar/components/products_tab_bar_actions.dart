import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../logic/product_management/product_cubit.dart';
import '../../../../../logic/product_management/product_state.dart';

class ProductsTabBarActions extends StatelessWidget {
  const ProductsTabBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final cubit = context.read<ProductCubit>();
        return Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: SizedBox(
                width: 200,
                height: 45,
                child: TextFormField(
                  onChanged: (value) => cubit.searchProducts(value),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                    ),
                    suffixIcon: Icon(
                      Icons.filter_list,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
