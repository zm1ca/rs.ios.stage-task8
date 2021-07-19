//
//  BRControlButton.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 19.07.21.
//

#import "BRControlButton.h"

@implementation BRControlButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        [self setHighlightedTint];
    } else {
        if (self.isEnabled) {
            [self setDefaultTint];
        } else {
            [self setDisabledTint];
        }
    }
}

@end
