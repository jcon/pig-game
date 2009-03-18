/*
 * PlayerMarker.fx
 *
 * Created on Dec 27, 2008, 1:41:04 PM
 */

package net.newfoo.pig;

import javafx.animation.transition.*;
import javafx.scene.transform.Scale;
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
     * [player1Spot, player2Spot].
     *
     * The player1 and player2 Spots tell the
     * marker control where the marker should be placed.
     *
     * If your UI asset is not in the form expected by group, you can
     * use the player1Spot, player2Spot and marker init vars below.
     */
    public-init var group: Group on replace {
        player1Spot = group.content[0];
        player2Spot = group.content[1];
    }

    /** Used to place the marker when the current turn is player1's turn */
    public-init var player1Spot: Node;

    public-init var player1Label: Node;

    /** Used to place the marker when the current turn is player2's turn */
    public-init var player2Spot: Node;

    public-init var player2Label: Node;


    var transform = Scale {
        x: .8,
        y: .8
    }


    /** True if the current player is player1, false otherwise. */
    public var isPlayerOne: Boolean on replace {
        if (isPlayerOne) {
            player1Spot.visible = true;
            player2Spot.visible = false;
            swap(player1Label, player2Label);
        } else {
            player1Spot.visible = false;
            player2Spot.visible = true;
            swap(player2Label, player1Label);
        }
}

    /** Swap the tabs to show the next player. */
    function swap( node1:Node, node2:Node ) {
        delete transform from node1.transforms;
        var bounds = node2.boundsInParent;
        transform.pivotX = bounds.minX + bounds.width / 2;
        transform.pivotY = bounds.minY + bounds.height / 2;
        insert transform into node2.transforms;
        node1.opacity = 1;
        node2.opacity = .6;
    }

}
