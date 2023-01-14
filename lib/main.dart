import 'package:cubit_example/cubit.dart';
import 'package:cubit_example/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [BlocProvider(create: (context) => CounterCubit(),)], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<CounterCubit,CounterState>(

        builder: (BuildContext context, state) {
          if (state is CounterInit) {
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${context.watch<CounterCubit>().counter}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            );
          }else if (state is CounterLoading) {
            return Text("");
          }else {
            return Text("ERROR");
          }
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){

          context.read<CounterCubit>().inc();
         //   BlocProvider.of<CounterCubit>(context).counter++;
         //   context.read<CounterCubit>().emit(CounterInit());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
