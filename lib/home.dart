
import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> _board;
  late bool _isPlayer1Turn;
  late bool _isGameOver;
  late String _winner;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }
  
  void _restartGame() {
    setState(() {
      _initializeBoard();
    });
  }

  void _initializeBoard() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ''));
    _isPlayer1Turn = true;
    _isGameOver = false;
    _winner = '';
  }

  void _onTileTap(int row, int col) {
    if (!_isGameOver && _board[row][col].isEmpty) {
      setState(() {
        _board[row][col] = _isPlayer1Turn ? 'X' : 'O';
        _isPlayer1Turn = !_isPlayer1Turn;
        _checkWinner();
      });
    }
  }

  Widget _buildTile(int row, int col) {
    Color tileColor = Colors.white;
    if (_board[row][col] == 'X') {
      tileColor = Colors.amber;
    } else if (_board[row][col] == 'O') {
      tileColor = Colors.blueAccent;
    }

    return GestureDetector(
      onTap: () => _onTileTap(row, col),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: tileColor,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            _board[row][col],
            style: TextStyle(fontSize: 36, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _restartGame , icon: Icon(Icons.restart_alt,color: Colors.redAccent,))
        ],
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildTile(0, 0),
                    _buildTile(0, 1),
                    _buildTile(0, 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildTile(1, 0),
                    _buildTile(1, 1),
                    _buildTile(1, 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildTile(2, 0),
                    _buildTile(2, 1),
                    _buildTile(2, 2),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            _isGameOver
                ? Text(
                    _winner.isNotEmpty ? 'Player $_winner wins!' : 'It\'s a draw!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                  )
                : SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _board[i][1] && _board[i][0] == _board[i][2] && _board[i][0].isNotEmpty) {
        _setGameOver(_board[i][0]);
        return;
      }
      if (_board[0][i] == _board[1][i] && _board[0][i] == _board[2][i] && _board[0][i].isNotEmpty) {
        _setGameOver(_board[0][i]);
        return;
      }
    }

    if (_board[0][0] == _board[1][1] && _board[0][0] == _board[2][2] && _board[0][0].isNotEmpty) {
      _setGameOver(_board[0][0]);
      return;
    }

    if (_board[0][2] == _board[1][1] && _board[0][2] == _board[2][0] && _board[0][2].isNotEmpty) {
      _setGameOver(_board[0][2]);
      return;
    }

    bool isBoardFull = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j].isEmpty) {
          isBoardFull = false;
          break;
        }
      }
    }
    if (isBoardFull) {
      _setGameOver('');
    }
  }

  void _setGameOver(String winner) {
    setState(() {
      _isGameOver = true;
      _winner = winner;
    });
  }
}
