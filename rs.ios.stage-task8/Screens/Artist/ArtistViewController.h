//
//  ViewController.h
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import <UIKit/UIKit.h>
#import "Palette.h"
#import "rs_ios_stage_task8-Swift.h"

@interface ArtistViewController : UIViewController <UIViewControllerTransitioningDelegate, PaletteDelegate, TimerDelegate>

@property(nonatomic, copy) NSOrderedSet<UIColor *>* pickedColors;
@property float timerValue;

@end

