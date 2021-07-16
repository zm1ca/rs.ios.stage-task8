//
//  DrawingsVC.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "DrawingsVC.h"
#import "RSButton.h"

@interface DrawingsVC ()

@property (strong, nonatomic) IBOutletCollection(RSButton) NSArray *patternButtons;

@end

@implementation DrawingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_patternButtons.firstObject setPickedTint];
}



@end
