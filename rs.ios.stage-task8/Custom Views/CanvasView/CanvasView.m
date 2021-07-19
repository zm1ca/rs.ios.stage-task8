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
    
    self.shape1Layer = [[CAShapeLayer alloc] init];
    self.shape2Layer = [[CAShapeLayer alloc] init];
    self.shape3Layer = [[CAShapeLayer alloc] init];

    [self.layer addSublayer:self.shape1Layer];
    [self.layer addSublayer:self.shape2Layer];
    [self.layer addSublayer:self.shape3Layer];
}

@end
