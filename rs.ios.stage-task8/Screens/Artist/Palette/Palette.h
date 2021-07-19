//
//  Palette.h
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PaletteDelegate <NSObject>
- (void)paletteDidPick:(NSMutableOrderedSet<UIColor *>*)colors;
@end

@interface Palette : UIViewController

@property NSMutableOrderedSet<UIColor *>* pickedColors;
@property NSTimer* bgTimer;
@property(weak) id<PaletteDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
