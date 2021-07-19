//
//  PaletteVC.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "PaletteVC.h"
#import "BRColorButton.h"

@interface PaletteVC ()

- (IBAction)colorButtonTapped:(BRColorButton *)sender;
- (IBAction)saveButtonTapped:(UIButton *)sender;

@property (strong, nonatomic) IBOutletCollection(BRColorButton) NSArray<BRColorButton*> *colorButtons;

@end

@implementation PaletteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickedColors = [[NSMutableOrderedSet<UIColor *> alloc] initWithOrderedSet:_pickedColors];
    [self setButtonsForPickedColorsToSelectedState];
}

- (void)setButtonsForPickedColorsToSelectedState {
    for (int i = 0; i < _pickedColors.count; i++) {
        for (int index = 0; index < _colorButtons.count; index++) {
            if ([_colorButtons[index].color isEqual:_pickedColors[i]]) {
                [_colorButtons[index] setSelectedAppearance];
            }
        }
    }
}

- (IBAction)saveButtonTapped:(UIButton *)sender {
    [_delegate paletteDidPick:_pickedColors];
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    } completion:^(BOOL finished) {
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    
}

- (IBAction)colorButtonTapped:(BRColorButton *)sender {
    
    //Select or deselect color
    [sender toggleState];
    if ([_pickedColors containsObject:sender.color]) {
        [_pickedColors removeObject:sender.color];
        return;
    } else {
        [self select:sender.color];
    }

    //Animate adjusting background color
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = sender.color;
    }];
    
    [_bgTimer invalidate];
    _bgTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.backgroundColor = [UIColor whiteColor];
        }];
    }];
}

- (void)select:(UIColor*)color {
    [_pickedColors addObject:color];
     if (_pickedColors.count > 3) {
        for (int index = 0; index < _colorButtons.count; index++) {
            if ([_colorButtons[index].color isEqual:_pickedColors[0]]) {
                [_colorButtons[index] setDefaultAppearance];
            }
        }
        [_pickedColors removeObjectAtIndex:0];
    }
}

@end
