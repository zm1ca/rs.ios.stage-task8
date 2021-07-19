//
//  BRColorButton.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "BRColorButton.h"
#import "BRColorView.h"

@implementation BRColorButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    BRColorView *smallColorHolder = [[BRColorView alloc] initWithFrame:CGRectMake(8, 8, 24, 24)];
    smallColorHolder.backgroundColor = _color;
    smallColorHolder.layer.cornerRadius = 6;
    
    _colorHolder = smallColorHolder;
    self.appearingAsDefault = YES;
    [self addSubview:_colorHolder];
    
    [self setDefaultAppearance];
}

- (void)setDefaultAppearance {
    [UIView animateWithDuration:0.25 animations:^{
        self->_colorHolder.frame = CGRectMake(8, 8, 24, 24);
        self->_colorHolder.layer.cornerRadius = 6;
    }];

    self.appearingAsDefault = YES;
}

- (void)setSelectedAppearance {
    [UIView animateWithDuration:0.25 animations:^{
        self->_colorHolder.frame = CGRectMake(2, 2, 36, 36);
        self->_colorHolder.layer.cornerRadius = 8;
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
