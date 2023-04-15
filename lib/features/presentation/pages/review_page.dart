import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:cubit_mvvm_clean/core/constants/palette.dart';
import 'package:cubit_mvvm_clean/features/data/models/review_model.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/main_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/home_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/review_cubit/review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<int> groupValue = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ReviewsToReviews;
    groupValue = args.groupValues;

    return BlocProvider(
      create: (context) => ReviewCubit()..getQuestions(args.id),
      child: Scaffold(
          backgroundColor: Colors.grey.shade800,
          body: SafeArea(
            child: BlocConsumer<ReviewCubit, ReviewState>(
              builder: (context, state) {
                if (state is ReviewFinished) {
                  print(groupValue);
                  return SingleChildScrollView(
                      child: Column(
                    children: [
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: state.questionsResponseData.data!.length,
                        itemBuilder: (context, index) {
                          //Soru tipi 1 olanlardan text değerlerini almak için dynamic olarak texteditingcontroller oluşturuyoruz.

                          return state.questionsResponseData.data![index]
                                      .questionType ==
                                  1
                              ? listQuestion(
                                  state
                                      .questionsResponseData.data![index].text!,
                                  args.textControllers[index]!)
                              : listQuestionWithOption(
                                  index,
                                  state
                                      .questionsResponseData.data![index].text!,
                                  state.questionsResponseData.data![index]
                                      .choices!.length,
                                  state.questionsResponseData.data![index]
                                      .choices!,
                                  state.questionsResponseData.data![index]
                                      .choices!.length);
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      BlocBuilder<ReviewCubit, ReviewState>(
                        builder: (context, secondState) {
                          if (secondState is AnswerSendingLoading) {
                            return const CircularProgressIndicator();
                          } else {
                            return TextButton(
                                onPressed: () {
                                  List<String> sendingText = [];
                                  List<int> choices = [];
                                  for (int i = 0;
                                      i < args.textControllers.length;
                                      i++) {
                                    sendingText.add(
                                        args.textControllers[i]?.text ?? "");
                                    choices.add(groupValue[i]);
                                  }
                                  context.read<ReviewCubit>().sendAnswer(
                                      state.questionsResponseData.data!,
                                      sendingText,
                                      choices);
                                },
                                child: Text(
                                  "Gönder",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Palette.primary,
                                    fixedSize: Size(40.w, 6.h),
                                    textStyle:
                                        const TextStyle(color: Colors.white)));
                          }
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              listener: (context, state) {
                if (state is AnswerSendCompletely) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Anket başarıyla kaydedildi !"),
                  ));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
            ),
          )),
    );
  }

  Container listQuestion(String title, TextEditingController controller) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 6.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 5.w,
              ),
              Expanded(child: Text(title)),
              SizedBox(
                width: 5.w,
              )
            ],
          ),
          SizedBox(
              width: 80.w,
              child: TextField(
                controller: controller,
              ))
        ],
      ),
    );
  }

  Container listQuestionWithOption(int id, String title, int optionCount,
      List<ChoiceResponse> choices, int countChoice) {
    if (countChoice < 2) {
      return Container();
    } else {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 6.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 5.w,
                ),
                Expanded(child: Text(title)),
                SizedBox(
                  width: 5.w,
                )
              ],
            ),
            SizedBox(
                width: 80.w,
                child: LayoutBuilder(
                  builder: (p0, p1) {
                    if (optionCount == 2) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: choices[0].id,
                                  title: Text(choices[0].text!),
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[1].text!),
                                  value: choices[1].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    if (optionCount == 3) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: choices[0].id!,
                                  title: Text(choices[0].text!),
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[1].text!),
                                  value: choices[1].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: choices[2].id!,
                                  title: Text(choices[2].text!),
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    if (optionCount == 4) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: choices[0].id!,
                                  title: Text(choices[0].text!),
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[1].text!),
                                  value: choices[1].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: choices[2].id!,
                                  title: Text(choices[2].text!),
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[3].text!),
                                  value: choices[3].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    if (optionCount == 5) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: choices[0].id!,
                                  title: Text(choices[0].text!),
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[1].text!),
                                  value: choices[1].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: choices[2].id!,
                                  title: Text(choices[2].text!),
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[3].text!),
                                  value: choices[3].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[4].text!),
                                  value: choices[4].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    if (optionCount == 6) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: choices[0].id!,
                                  title: Text(choices[0].text!),
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[1].text!),
                                  value: choices[1].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: choices[2].id!,
                                  title: Text(choices[2].text!),
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[3].text!),
                                  value: choices[3].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[4].text!),
                                  value: choices[4].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text(choices[5].text!),
                                  value: choices[5].id!,
                                  groupValue: groupValue[id],
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue[id] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ))
          ],
        ),
      );
    }
  }
}

class RadioListBuilder extends StatefulWidget {
  final int? num;

  const RadioListBuilder({Key? key, this.num}) : super(key: key);

  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<RadioListBuilder> {
  int? value;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return RadioListTile(
          value: index,
          groupValue: value,
          onChanged: (ind) => setState(() => value = ind),
          title: Text("Number $index"),
        );
      },
      itemCount: widget.num,
    );
  }
}
