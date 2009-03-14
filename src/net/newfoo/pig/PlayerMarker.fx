/*
 * PlayerMarker.fx
 *
 * Created on Dec 27, 2008, 1:41:04 PM
 */

package net.newfoo.pig;

import javafx.scene.Group;
import javafx.scene.Node;

/**
 * Represents a control that displays the current
 * player.  The current player can be toggled by
 * negating the current isPlayerOne value.
 *
 * @author jconnell
 */
public class PlayerMarker {
    /**
    * Construct the UI of this play maker by
    * accepting a <code>javafx.scene.Group</code>
    * with an array of the following elements (all
    * type <code>javafx.scene.Node</code>:
    * [player1Spot, player2Spot, marker].
    *
    * The player1 and player2 Spots tell the
    * marker control where the marker should be placed.
    *
    * If your UI asset is not in the form expected by group, you can
    * use the player1Spot, player2Spot and marker init vars below.
    */
    public-init var group : Group on replace {
        player1Spot = group.content[0];
        player2Spot = group.content[1];
        marker = group.content[2];

        var s1 = player1Spot.boundsInParent;
        var s2 = player2Spot.boundsInParent;

        distance = s2.minY - s1.minY;
        player1Spot.visible = false;
        player2Spot.visible = false;
    }

    /** Used to place the marker when the current turn is player1's turn */
    public-init var player1Spot : Node;

    /** Used to place the marker when the current turn is player2's turn */
    public-init var player2Spot : Node;

    /** The asset representing the marker. */
    public-init var marker : Node;

    /** holds the distance between the player1 and player2 spots */
    var distance : Number;

    /** True if the current player is player1, false otherwise. */
    public var isPlayerOne : Boolean on replace {
        move(isPlayerOne);
    }

    function move( spot1 : Boolean ) {
        var spot : Node = if (spot1) player1Spot else player2Spot;
        println("is spot1 {spot1}");
        var m = marker.boundsInScene;
        var s = spot.boundsInScene;
        marker.translateX = (s.minX + s.width / 2) - (m.minX + m.width / 2);
        marker.translateY = (if (spot1) -1 else 1/2) * distance;
    }
}
