//
//  CanvasView.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "CanvasView.h"

@implementation CanvasView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 8.0f;
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowOffset = CGSizeZero;
    self.layer.masksToBounds = NO;
    self.layer.shadowRadius = 8.0f;
    self.layer.shadowColor = [[UIColor colorNamed:@"ShadowColor"] CGColor];
    self.layer.shadowOpacity = .25f;
}

@end
