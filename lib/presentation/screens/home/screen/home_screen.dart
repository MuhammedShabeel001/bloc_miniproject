import 'package:bloc_project/application/home_bloc/home_cubit.dart';
import 'package:bloc_project/application/home_bloc/home_state.dart';
import 'package:bloc_project/domain/api/api_calling/api_functions.dart';
import 'package:bloc_project/presentation/screens/add/screen/add_screen.dart';
import 'package:bloc_project/presentation/screens/detail/screen/detail_screen.dart';
import 'package:bloc_project/presentation/screens/edit/screen/edit_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loading_indicator/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit(),
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              backgroundColor: Colors.black,
              title: const Text(
                'All Data',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeProductsLoadingState) {
                  return const Center(
                    child: SizedBox(
                      height: 70,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballTrianglePathColoredFilled,
                        colors: [
                          Colors.black,
                          Colors.amberAccent,
                          Colors.deepOrangeAccent
                        ],
                      ),
                    ),
                  );
                } else if (state is HomeProductsLoadedState) {
                  return ListView.builder(
                      itemCount: state.allProducts.length,
                      itemBuilder: (context, index) {
                        final data = state.allProducts[index];
                        return GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => DetailScreen(
                                    title: data.title, body: data.body))));
                          },
                          child: Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(left: 10),
                              title: Text(
                                data.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                data.body,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 2,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    EditScreen(
                                                        id: data.id,
                                                        userId: data.userId,
                                                        title: data.title,
                                                        body: data.body))));
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () async {
                                        bool val = await deleteData(data.id);
                                        if (val) {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text("Deleted"),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.green));
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Something wnt wrong"),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor: Colors.red));
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Unknown Error Occured',
                      ),
                    ],
                  ));
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => AddScreen()));
              },
              child: const Icon(Icons.add),
            )));
  }
}
