import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ns_test/component/d_button.dart';
import 'package:flutter_ns_test/extension/size_extension.dart';

//https://pub.dev/packages/flutter_bloc
//flutter_bloc 插件初识
class BlocTestPage extends StatefulWidget {
  @override
  State<BlocTestPage> createState() => _BlocTestPageState();
}

class _BlocTestPageState extends State<BlocTestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BlocTestPage')),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, count) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(child: Text('$count')),
              DButton(
                padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dw),
                color: Theme.of(context).accentColor,
                child: Text(
                  "减",
                  style:
                      TextStyle(fontSize: 16.dsp, fontWeight: FontWeight.w400, color: Colors.white),
                ),
                onPressed: () {
                  context.read<CounterCubit>().decrement();
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => context.read<CounterCubit>().increment(),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 5.0),
          //   child: FloatingActionButton(
          //     child: const Icon(Icons.remove),
          //     onPressed: () => context.read<CounterCubit>().decrement(),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}
