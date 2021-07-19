//
//  ColorPickerButton.h
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import <UIKit/UIKit.h>
#import "RSButton.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface ColorPickerButton : RSButton

@property(nonatomic, copy) UIView *colorHolder;
@property(nonatomic, copy) IBInspectable UIColor* color;

@property BOOL appearingAsDefault;

- (void)setDefaultAppearance;
- (void)setSelectedAppearance;
- (void)toggleState;

@end

NS_ASSUME_NONNULL_END
