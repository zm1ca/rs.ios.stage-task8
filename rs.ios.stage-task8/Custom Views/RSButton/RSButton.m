//
//  RSButton.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "RSButton.h"

@implementation RSButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setTitleColor:[UIColor colorNamed:@"Turquoise"] forState:UIControlStateNormal];
    [self setDefaultTint];
    
    self.backgroundColor     = [UIColor whiteColor];
    self.layer.cornerRadius  = 10.0f;
    self.layer.shadowOffset  = CGSizeZero;
    self.layer.masksToBounds = NO;
    self.titleLabel.font     = [UIFont fontWithName:@"Montserrat-Medium" size:18];
}

- (void)setDefaultTint {
    self.layer.shadowRadius  = 2.0f;
    self.layer.shadowColor   = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = .25f;
}

- (void)setPickedTint {
    self.layer.shadowRadius = 4.0f;
    self.layer.shadowColor = [[UIColor colorNamed:@"Turquoise"] CGColor];
    self.layer.shadowOpacity = 1.0f;
}

@end
