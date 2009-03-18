/*
 * ScoreControl.fx
 *
 * Created on Dec 24, 2008, 6:04:52 PM
 */

package net.newfoo.pig;

import javafx.scene.Group;
import javafx.scene.text.Text;
import javafx.animation.transition.ScaleTransition;
import javafx.animation.Interpolator;

/**
 * Represents a UI component that can display a integer number.
 * This control encapsulates the logic for updating the display
 * whenever a score changes.
 *
 * @author jconnell
 */

public class ScoreControl {
    /**
     * Represents a <code>javafx.scene.Group</code> that contains a
     * javafx.scene.text.Text as its second element.  To override this
     * behavior, use the public-init var text instead.
     */
    public-init var group : Group on replace {
        text = group.content[1] as Text;
    };

    /** Substitute for using the group attribute when the control is constructed */
    public-init var text : Text;

    /** Represents the value of this control instance. */
    public var value : Integer = -1 on replace {
        if (value != -1) {
            if (value < 10) {
                text.content = "00{value}";
            } else if (value < 100) {
                text.content = "0{value}";
            } else {
                text.content = "{value}";
            }
            // when the value is updated, create a small scaling animation
            var t = ScaleTransition {
                repeatCount: 2
                autoReverse: true
                node: text
                fromX: 1, toX: 1.3, byX: .05
                fromY: 1, toY: 1.3, byY: .05
                interpolate: Interpolator.EASEIN
                duration: 175ms
            }
            t.playFromStart();
        }
    }


}
