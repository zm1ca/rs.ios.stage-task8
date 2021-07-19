//
//  CanvasView.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "CanvasView.h"

@implementation CanvasView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.shape1Layer = [[CAShapeLayer alloc] init];
        self.shape2Layer = [[CAShapeLayer alloc] init];
        self.shape3Layer = [[CAShapeLayer alloc] init];
        [self configureLayer];
    }
    return self;
}

- (void)configureLayer {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 8.0f;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.masksToBounds = NO;
    self.layer.shadowRadius = 8.0f;
    self.layer.shadowColor = [[UIColor colorNamed:@"ShadowColor"] CGColor];
    self.layer.shadowOpacity = .25f;
}

@end
