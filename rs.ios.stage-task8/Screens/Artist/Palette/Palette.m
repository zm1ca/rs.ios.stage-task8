//
//  Palette.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "Palette.h"
#import "ColorPickerButton.h"

@interface Palette ()

- (IBAction)colorButtonTapped:(ColorPickerButton *)sender;
- (IBAction)saveButtonTapped:(UIButton *)sender;

@property (strong, nonatomic) IBOutletCollection(ColorPickerButton) NSArray<ColorPickerButton*> *colorButtons;

@end

@implementation Palette

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

- (IBAction)colorButtonTapped:(ColorPickerButton *)sender {
    [sender toggleState];
    
    //Deselect color
    if ([_pickedColors containsObject:sender.color]) {
        [_pickedColors removeObject:sender.color];
        return;
    }

    [self selectNewColor:sender.color];
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

- (void)selectNewColor:(UIColor*)color {
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
