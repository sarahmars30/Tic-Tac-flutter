import 'package:flutter/material.dart';

class GamePage  extends StatefulWidget {
  const GamePage({super.key});


  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // ignore: constant_identifier_names
  static const String PLAYER_X="X";
  // ignore: constant_identifier_names
  static const String PLAYER_Y="O";

  late String currentPlayer;
  late bool gameEnd;
  late List<String>occupied;


  @override
  void initState() {
    intializeGame();
    super.initState();
  } 
   void intializeGame(){
    currentPlayer=PLAYER_X;
    gameEnd=false;
    occupied=["","","","","","","","","" ]; //9empty places
    


   }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _headerText(),
          _gameContainer(),
          _restartButton(),

        ],


      ),

      ),
    );
  }
 
  Widget _headerText(){
    return Column(
      children: [
        const Text("Tic Tac Toe",style: TextStyle(
          color: Colors.green,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),),
        Text("$currentPlayer turn",style:const TextStyle(
          color: Colors.black87,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        ),
      ],
    );
  }
  Widget _gameContainer(){
    return Container(
      height: MediaQuery.of(context).size.height/2,
      width: MediaQuery.of(context).size.height/2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3),
      itemCount: 9,
       itemBuilder: (context,int index){
        return _box(index);
       }),
    );
  }
  Widget _box(int index){
    return InkWell(
      onTap: (){
        //on click of box
        if(gameEnd || occupied[index].isNotEmpty){
          //Return if game already ended or box already clicked
          return;
        }
        setState(() {
          occupied[index]=currentPlayer;
          changeTurn();
          checkForWinner();
          checkForDraw();
        });
        
      },
      child: Container(
        color: occupied[index].isEmpty
        ?Colors.black26
        :occupied[index]==PLAYER_X
        ?Colors.blue
        :Colors.orange,
        margin: const EdgeInsets.all(8),
      child:Center(
        child: Text(
        occupied[index],
        style: const TextStyle(fontSize: 50),
      
      ),
      ),
      ),
    );
  }

   _restartButton(){
    return ElevatedButton(
      onPressed: (){
        setState(() {
          intializeGame();
        });


    }
    
    
    , child:  const Text("Restart Game")) ;
  }

  changeTurn(){
    if(currentPlayer==PLAYER_X){
      currentPlayer=PLAYER_Y;
    }else{
      currentPlayer=PLAYER_X;
    }
  }
  checkForWinner(){
    //Defult winner position 
    Set<List<int>> winningList={
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    };

    for(var winninpos in winningList){
      String playerposition0= occupied[winninpos[0]];
      String playerposition1= occupied[winninpos[1]];
      String playerposition2= occupied[winninpos[2]];
        if(playerposition0.isNotEmpty){
      if(playerposition0 == playerposition1 && playerposition0 == playerposition2){
        //all equal means player won
        showGameOverMessage("player $playerposition0 won");
        gameEnd=true;
        return;
      }

        }
    
    }
  }
  checkForDraw(){
    if(gameEnd){
      return;

    }
    bool draw=true;
    for(var occupiedplayer in occupied){
      if(occupiedplayer.isEmpty){
        //at least one is empty not all are filled
        draw=false;
      }
    }
    if(draw){
      showGameOverMessage("Draw");
      gameEnd=true;
    }
  }
  showGameOverMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text("Game over \n $message",
        textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
      )
      )),
    );
  }
    }
  

