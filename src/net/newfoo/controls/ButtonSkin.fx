package net.newfoo.controls;

import javafx.scene.control.Skin;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.fxd.UiStub;
import java.lang.System;
import javafx.scene.text.Text;

/**
 * @author jconnell
 */

public class ButtonSkin extends Skin {

    public-init var group : Group;

    public-read var pressedView : Node;

    public-read var hoveredView : Node;

    public-read var normalView : Node;

    public-read var disabledView : Node;

    public-read var activeAreaView : Node;

    public-init var text : String = bind (control as Button).text on replace {
        if (text != null and scene != null) {
            var xLoc : Number = 0;
            for (i in [1..4]) {
                var view : Group = ((scene as Group).content[i] as Group);
                for (n in view.content) {
                    if (n instanceof Text) {
                        var t = n as Text;
                        t.content = text;
                        t.strokeWidth = 3;
                        var pB = view.boundsInScene;
                        var tB = t.boundsInScene;
                        //println("{pB.width} {tB.width}");
                        t.x = (pB.width - tB.width) / 2;
                    }
                }

            }
        }
    };

    override var hover on replace {
        updateUI();
    }

    override var pressed on replace {
        updateUI();
    }


    override var scene = bind group on replace {;
        normalView = group.content[4];
        hoveredView = group.content[3];
        pressedView = group.content[2];
        disabledView = group.content[1];
        activeAreaView = group.content[0];
        scene.onMouseEntered = function (e) {
            hover = true;
            control.onMouseEntered(e);
        }
        scene.onMouseExited = function (e) {
            hover = false;
            control.onMouseExited(e);
        }
        scene.onMousePressed = function (e) {
            pressed = true;
            control.onMousePressed(e);
        }
        scene.onMouseReleased = function (e) {
            pressed = false;
            control.onMouseReleased(e);
        }
        scene.onMouseClicked = function(e) {
            focused = true;
            control.onMouseClicked(e);
        }
    }

    public function updateUI () {
        if (pressedView != null)
            pressedView.visible = pressed;
        if (hoveredView != null)
            hoveredView.visible = not pressed and hover;
        if (hoveredView != null)
            normalView.visible = not pressed and not hover;
    }
}
