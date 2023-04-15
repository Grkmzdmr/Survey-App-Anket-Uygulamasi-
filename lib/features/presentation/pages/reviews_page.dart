import 'package:cubit_mvvm_clean/core/constants/palette.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/main_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/review_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/reviews_cubit/reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  Map<int, TextEditingController> controllers = {};
  List<int> groupValue = [];

  @override
  void initState() {
    super.initState();
    //context.read<ReviewsCubit>().getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewsCubit()..getReviews(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: SafeArea(
          child: BlocBuilder<ReviewsCubit, ReviewsState>(
            builder: (context, state) {
              if (state is ReviewsFinished) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "Anketler",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: state.reviewResponseData.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Palette.primary,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    onTap: () {
                                      groupValue = [];
                                      controllers = {};
                                      for (int i = 0;
                                          i <
                                              state.reviewResponseData
                                                  .data![index].questionCount!;
                                          i++) {
                                        groupValue.add(i);
                                        controllers[i] =
                                            TextEditingController();
                                      }

                                      Navigator.pushNamed(context, "/review",
                                          arguments: ReviewsToReviews(
                                              state.reviewResponseData
                                                  .data![index].id!,
                                              controllers,
                                              groupValue));
                                    },
                                    trailing: const Icon(Icons.arrow_forward),
                                    title: Text(state
                                        .reviewResponseData.data![index].name!),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 12, right: 12),
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 0.5,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
