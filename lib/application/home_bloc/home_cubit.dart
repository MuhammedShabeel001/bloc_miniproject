import 'package:bloc_project/application/home_bloc/home_state.dart';
import 'package:bloc_project/domain/api/api_calling/api_functions.dart';
import 'package:bloc_project/domain/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState()) {
    emit(HomeProductsLoadingState());
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      // print(await fetchAllProducts());
      List<UserModel> allProducts = await fetchAllData();
      emit(HomeProductsLoadedState(allProducts: allProducts));
    } catch (e) {
      emit(HomeProductsLoadingFailedState(errorMessage: e.toString()));
    }
  }
}
