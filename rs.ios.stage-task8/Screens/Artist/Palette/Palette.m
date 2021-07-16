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

@property (strong, nonatomic) IBOutletCollection(ColorPickerButton) NSArray<ColorPickerButton*> *colorButtons;


@end

@implementation Palette

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickedColors = [[NSMutableOrderedSet<UIColor *> alloc] init];
}

- (IBAction)colorButtonTapped:(ColorPickerButton *)sender {
    [sender toggleState];
    
    if ([_pickedColors containsObject:sender.color]) {
        [_pickedColors removeObject:sender.color];
        return;
    }
    
    [_pickedColors addObject:sender.color];
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
