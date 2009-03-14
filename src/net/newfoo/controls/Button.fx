/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Jim Connell wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Jim Connell
 * ----------------------------------------------------------------------------
 */
package net.newfoo.controls;

import javafx.scene.CustomNode;
import javafx.scene.input.MouseEvent;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.text.Text;
import javafx.scene.control.Control;

/**
 * Represents a generic button control.  This class will bind to a group
 * that contains the 4 different states a button can display and an
 * active area that can be used for capturing mouse events. Users of
 * the class should pass the group with the 5 elements to
 * the button on construction.
 *
 * NOTES: a more robust button might even allow for construction of a
 * button in an arbitrary way.  The more robust button for instance
 * would allow for the states to be located and placed in designer arbitrary
 * locations.
 *
 * @author jconnell
 */

public class Button extends Control {

    /** This function will be called whenever the button is clicked.
     * This variable is useful for binding functionality to button clicks
     * outside of the button
     */
    public var action : function ():Void;

    public var text : String = "Click!";

    override var onMousePressed = function( e : MouseEvent ) {
        action();
    }

    init {
        skin = ButtonSkin{ };
    }



}
