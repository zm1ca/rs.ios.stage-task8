//
//  ColorHolderView.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "ColorHolderView.h"

@implementation ColorHolderView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    return view == self ? nil : view;
}

@end
