//
//  ColorPickerButton.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "ColorPickerButton.h"
#import "ColorHolderView.h"

@implementation ColorPickerButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setDefaultAppearance];
}

- (void)setDefaultAppearance {
    ColorHolderView *colorHolder = [[ColorHolderView alloc] initWithFrame:CGRectMake(8, 8, 24, 24)];
    colorHolder.backgroundColor = _color;
    colorHolder.layer.cornerRadius = 6;
    
    self.appearingAsDefault = YES;
    [self removeAllSubviews];
    [self addSubview:colorHolder];
}

- (void)setSelectedAppearance {
    ColorHolderView *colorHolder = [[ColorHolderView alloc] initWithFrame:CGRectMake(2, 2, 36, 36)];
    colorHolder.backgroundColor = _color;
    colorHolder.layer.cornerRadius = 8;
    
    self.appearingAsDefault = NO;
    [self removeAllSubviews];
    [self addSubview:colorHolder];
}

- (void)toggleState {
    if (self.appearingAsDefault) {
        [self setSelectedAppearance];
    } else {
        [self setDefaultAppearance];
    }
}

- (void)removeAllSubviews {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
