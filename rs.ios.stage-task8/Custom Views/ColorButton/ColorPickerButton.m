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
    
    ColorHolderView *smallColorHolder = [[ColorHolderView alloc] initWithFrame:CGRectMake(8, 8, 24, 24)];
    smallColorHolder.backgroundColor = _color;
    smallColorHolder.layer.cornerRadius = 6;
    
    _colorHolder = smallColorHolder;
    self.appearingAsDefault = YES;
    [self addSubview:_colorHolder];
    
    [self setDefaultAppearance];
}

- (void)setDefaultAppearance {
    [UIView animateWithDuration:0.25 animations:^{
        _colorHolder.frame = CGRectMake(8, 8, 24, 24);
        _colorHolder.layer.cornerRadius = 6;
    }];

    self.appearingAsDefault = YES;
}

- (void)setSelectedAppearance {
    [UIView animateWithDuration:0.25 animations:^{
        _colorHolder.frame = CGRectMake(2, 2, 36, 36);
        _colorHolder.layer.cornerRadius = 8;
    }];

    self.appearingAsDefault = NO;
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
