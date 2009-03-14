/*
 * Main.fx
 *
 * Created on Dec 22, 2008, 10:45:13 PM
 */

package net.newfoo.pig;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.*;
import javafx.scene.Node;
import javafx.scene.input.MouseEvent;
import javafx.scene.Group;
import javafx.animation.transition.Transition;
import javafx.animation.transition.PauseTransition;
import javafx.animation.Timeline;

class Controller {
    var ui = BoardUI{ }
    var game : Game = Game{
        afterRoll: rolled

        gameOver: function( player1Wins:Boolean ) {
            println("Game over Player {if (player1Wins) 1 else 2}");
            rollButton.disable = true;
            holdButton.disable = true;
            ui.gameOverDialog.visible = true;
        }
    }
    var player1Score : ScoreControl;
    var player2Score : ScoreControl;
    var turnScore : ScoreControl;
    var rollButton : Button;
    var holdButton : Button;
    var yesButton : Button;
    var playerMarker : PlayerMarker;

    init {
        hideSides();
        ui.gameOverDialog.visible = false;
        player1Score = ScoreControl {
            group: ui.player1Score
        }
        player2Score = ScoreControl {
            group: ui.player2Score
        }
        turnScore = ScoreControl {
            group: ui.turnScore
        }

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
                ui.gameOverDialog.visible = false;
            }
        };

        playerMarker = PlayerMarker {
            group: ui.playerMarker
            isPlayerOne: bind game.isPlayerOne
        }
    }

    function hideSides() {
        for (side in ui.sides.content) {
           side.visible = false;
        }
    }

    function updateScores() {
        turnScore.value = 0;
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
        turnScore.value = game.turnScore;
    }
}

var controller = Controller{ }
var bounds = controller.ui.boundsInScene;
Stage {
    title: "Pig"
    width: bounds.width
    height: bounds.height + 13
    scene: Scene {
        content: controller.ui
    }
}