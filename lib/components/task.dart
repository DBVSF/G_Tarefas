import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/difficulty.dart';

class Task extends StatefulWidget {
  final String name;
  final String image;
  final int difficultyLevel;

  Task(this.name, this.image, this.difficultyLevel, {super.key});

  int level = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.image.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              //color: Colors.blue,

              color: ((widget.level / widget.difficultyLevel) / 10 <=
                      widget.difficultyLevel)
                  ? Colors.green
                  : Colors.blue,
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[100],
                      ),
                      width: 70,
                      height: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: assetOrNetwork()
                              ? Image.asset(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 200,
                              child: Text(widget.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis))),
                          Difficulty(widget: widget),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.level++;
                            });
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_circle_up_outlined),
                              Text("UP")
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        value: (widget.difficultyLevel > 0)
                            ? (widget.level / widget.difficultyLevel) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nível: ${widget.level}',
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
