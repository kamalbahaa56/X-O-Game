import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Border State
  final List<String> board = List.filled(9, "");
  // Current Player (X or O)
  String currentPlayer = "X";
  // Variable to store the winner
  String winner = "";
  // Flag to indicate a tie
  bool isTie = false;
  // function to handel a player's move
  player(int index) {
    if (winner != '' || board[index] != '') {
      return; // If the game is already won or the cell in not empty do nothing
    }
    setState(() {
      board[index] =
          currentPlayer; // set the current cell to the curnt player's symbol
      currentPlayer = currentPlayer == "X"
          ? "O"
          : "X"; // switch to the one to a another player
      checkForWinner();
    });
  }

  // function for check the winner ot a tie
  checkForWinner() {
    List<List<int>> lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    // chech each winning combaination
    for (List<int> line in lines) {
      String player1 = board[line[0]];
      String player2 = board[line[1]];
      String player3 = board[line[2]];
      if (player1 == "" || player2 == "" || player3 == "") {
        continue; // If any cell in the combination is empty , Skip this combinatnion
      }
      if (player1 == player2 && player2 == player3) {
        setState(() {
          winner =
              player1; // If all cell in the combintation are the same , set the winner
        });
        return;
      }
    }
    // chcek for the tie
    if (!board.contains("")) {
      setState(() {
        isTie = true; // if not cells are empty and there's no winner it's a tie
      });
    }
  }

  // Function to reset the game state and play the new Game .
  resetGame() {
    setState(() {
      board.fillRange(0, 9, ''); // clean the board
      currentPlayer = "X";
      winner = ""; // clean the winner
      isTie = false; // clean the flag
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Dispaly the Players
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Desgin Bot X
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: currentPlayer == "X"
                            ? Colors.amber
                            : Colors.transparent),
                    boxShadow: const [
                      BoxShadow(color: Colors.black38, blurRadius: 3),
                    ]),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 55,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Player 1 Desighn
                      Text(
                        "BOT 1",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),

                      // Player 2 Desighn
                      Text(
                        "X",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: size.width * 0.08,
              ),
              // Desgin Bot O
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: currentPlayer == "O"
                            ? Colors.amber
                            : Colors.transparent),
                    boxShadow: const [
                      BoxShadow(color: Colors.black38, blurRadius: 3),
                    ]),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 55,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Player 1 Desighn
                      Text(
                        "BOT 2",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),

                      // Player 2 Desighn
                      Text(
                        "O",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.04,
          ),

          // Display the winner messge
          if (winner != '')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  winner,
                  style: const TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  " WON!",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),

          // Dispaly tie messagme
          if (isTie)
            const Text(
              "it's a Tie!",
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          // For The Game board
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: 9,
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    player(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: const TextStyle(fontSize: 50, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Reset button
          if (winner != '' || isTie)
            ElevatedButton(onPressed: resetGame, 
            child: const Text('Play Again')
            ), 
        ],
      ),
    );
  }
}
