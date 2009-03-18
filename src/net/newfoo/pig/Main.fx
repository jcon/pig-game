/*
 * NewMain.fx
 *
 * Created on Mar 17, 2009, 4:20:48 PM
 */

package net.newfoo.pig;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.Group;
import javafx.scene.text.Text;
import javafx.scene.text.Font;

class Controller {
    var ui = DesignerBoardAdapter{
    }
    var game: Game = Game{
        afterRoll: rolled

        gameOver: function( player1Wins:Boolean ) {
            println("Game over Player {if (player1Wins) 1 else 2}");
            ui.pigWinsScore.content = "{game.player1Score} vs. {game.player2Score}";
            var name = if (player1Wins) ui.player1NameText.content else ui.player2NameText.content;
            ui.pigWinsText.content = "{name} Wins!";
            rollButton.disable = true;
            holdButton.disable = true;
            ui.gameOverDialog.visible = true;
            ui.boardGroup.opacity = .4;
        }
    }
    var player1Score : ScoreControl;
    var player2Score : ScoreControl;
    //    var turnScore : ScoreControl;
    var rollButton: Button;
    var holdButton: Button;
    var yesButton : Button;
    var playerMarker : PlayerMarker;

    init {
        hideSides();

         ui.gameOverDialog.visible = false;
         player1Score = ScoreControl {
            text: ui.player1ScoreText;
         }
         player1Score.value = 0;

         player2Score = ScoreControl {
            text: ui.player2ScoreText;
         }
         player2Score.value = 0;
/*
         turnScore = ScoreControl {
         group: ui.turnScore
         } */

        rollButton = Button {
            group: ui.rollButton
            action: function() {
                println("roll pressed!");
                holdButton.disable = false;
                if (not game.roll()) {
                    switch();
                }
            }
        };

        holdButton = Button {
            group: ui.holdButton
            action: function() : Void {
                println("hold pressed!");
                switch();
            }
        };

        yesButton = Button {
            group: ui.yesButton
            action: function() : Void {
                game.reset();
                updateScores();
                ui.boardGroup.opacity = 1;
                ui.gameOverDialog.visible = false;
            }
        };

        playerMarker = PlayerMarker {
            group: ui.playerMarker
            player1: ui.player1Name
            player2: ui.player2Name
            isPlayerOne: bind game.isPlayerOne
        }
    }

    function hideSides() {
        for (side in ui.sides.content) {
           side.visible = false;
        }
    }

    function updateScores() {
//       turnScore.value = 0;
        player1Score.value = game.player1Score;
        player2Score.value = game.player2Score;
    }

    function switch() {
        game.switchPlayer();
        updateScores();
        holdButton.disable = false;
    }

    function rolled( lastRoll:Integer ) : Void {
        println("rolled a {lastRoll} turn score is {game.turnScore}");
        hideSides();
        var side = ui.sides.content[lastRoll - 1];
        side.visible = true;
        ui.rollDice(side);
        if (game.isPlayerOne) {
            player1Score.value = player1Score.value + lastRoll;
        } else {
            player2Score.value  = player2Score.value  + lastRoll;
        }

        print("turn score is: {game.turnScore}");
//        turnScore.value = game.turnScore;
    }
}

var controller = Controller{ }


Stage {
    title: "Pig the Dice Game"
    width: 640
    height: 500
    scene: Scene {
        content: controller.ui
    }
}