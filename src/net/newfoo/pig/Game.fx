/*
 * Game.fx
 *
 * Created on Dec 22, 2008, 11:28:39 PM
 */

package net.newfoo.pig;

import java.lang.Math;

public class Game {
    public-read var player1Score : Integer;
    public-read var player2Score : Integer;
    public-read var turnScore : Integer;

    public-read var isPlayerOne = true;

    public-init var gameOver : function( isPlayerOne : Boolean ) : Void;
    public-init var afterRoll : function( lastRoll : Integer ) : Void;

    public function roll() : Boolean {
        var r = ((Math.random() * 6) as Integer) + 1;
        if (r == 1) {
            turnScore = 0;
        } else {
            turnScore += r;
        }
        afterRoll(r);
        if (isPlayerOne and turnScore + player1Score >= 100) {
            player1Score = turnScore + player1Score;
            gameOver(true);
            return false;
        } else if (not isPlayerOne and turnScore + player2Score >= 100) {
            player2Score = turnScore + player2Score;
            gameOver(false);
            return false;
        } else {
            return r != 1;
        }
    }

    public function switchPlayer() {
        if (isPlayerOne) {
            player1Score += turnScore;
        } else {
            player2Score += turnScore;
        }
        turnScore = 0;
        isPlayerOne = not isPlayerOne;
    }

    public function reset() {
        turnScore = player1Score = player2Score = 0;
    }
}
