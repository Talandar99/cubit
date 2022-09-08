import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ColumnCubit(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: BlocBuilder<ColumnCubit, List<Card>>(
            builder: (context, blocState) => Center(
              child: ListView.builder(
                itemCount: blocState.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.lightBlue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            context.read<ColumnCubit>().moveMeUp(index);
                          });
                        },
                        child: Text(
                          style: TextStyle(color: Colors.white),
                          blocState[index].cardIndex.toString(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ColumnCubit extends Cubit<List<Card>> {
  ColumnCubit()
      : super(
          [
            Card(cardIndex: 22),
            Card(cardIndex: 13),
            Card(cardIndex: 70),
            Card(cardIndex: 333333333),
          ],
        );

  moveMeUp(int actualindex) {
    print(actualindex);
    print(state[actualindex].cardIndex);
    Card tempCard = state[actualindex];
    List<Card> newState = state;
    if (actualindex == 0) {
      newState[actualindex] = newState[state.length - 1];
      newState[state.length - 1] = tempCard;
      emit(newState);
    } else {
      newState[actualindex] = newState[actualindex - 1];
      newState[actualindex - 1] = tempCard;
      emit(newState);
    }
  }
}

class Card {
  int cardIndex;

  Card({
    required this.cardIndex,
  });
}
