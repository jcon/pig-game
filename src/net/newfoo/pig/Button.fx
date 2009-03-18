/*
 * Button.fx
 *
 * Created on Dec 23, 2008, 1:54:09 AM
 */
package net.newfoo.pig;

import javafx.scene.Node;
import javafx.scene.Group;

/**
 * Represents a generic button control that supports 4 states: normal, hovered,
 * pressed and disabled.  This control is meant to manipulate existing nodes
 * in a group that contains each of the different views of the button in the
 * this order from top to bottom: normal, hovered, pressed, diabled, active area
 * (active area can be an unstyled node -- it's meant to capture events).
 * 
 * @author jconnell
 */
public class Button {

    /**
    * The ideal method for constructing a button is to pass a group
     * with the appropriate elements in the correct order:
     * (normal, hovered, pressed, diabled, active area)
     */
    public-init var group: Group on replace {
        normal = group.content[4];
        hovered = group.content[3];
        pressed = group.content[2];
        disabled = group.content[1];
        activeArea = group.content[0];
    }

    public-init var pressed: Node;

    public-init var hovered: Node;

    public-init var normal: Node;

    public-init var disabled: Node;

    public-init var activeArea: Node;

    public var action: function ():Void;

    public var disable = false on replace {
        activeArea.disable = disable;
        if (disable) {
            //            disabled.visible = true;
            normal.visible = 
            hovered.visible =
            pressed.visible = false;
        } else {
            normal.visible = 
            hovered.visible =
            pressed.visible = true;
        }
    }

    var isPressed: Boolean on replace {
        updateUI ();
    }
    var isHovered: Boolean on replace {
        updateUI ();
    }

    /**
     * The init method setups up all the mouse event handlers on the node.
     */
    init {
        if (activeArea != null) {
            activeArea.onMouseEntered = function (e) {
                isHovered = true;
            }
            activeArea.onMouseExited = function (e) {
                isHovered = false;
            }
            activeArea.onMousePressed = function (e) {
                isPressed = true;
            }
            activeArea.onMouseReleased = function (e) {
                isPressed = false;
                action();
            }
        }
        isPressed = false;
        isHovered = false;
        updateUI ();
    }

    function updateUI () {
        //        println("text: {((normal as Group).content[1] as Text).content} pressed: {isPressed} hovered: {isHovered}");
        if (pressed != null)
            pressed.visible = isPressed;
        if (hovered != null)
            hovered.visible = not isPressed  and  isHovered;
        if (hovered != null)
            normal.visible = not isPressed  and  not isHovered;
    }
}
