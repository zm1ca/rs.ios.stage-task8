//
//  ViewController.h
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import <UIKit/UIKit.h>
#import "PaletteVC.h"
#import "rs_ios_stage_task8-Swift.h"

@interface ArtistVC : UIViewController <UIViewControllerTransitioningDelegate, PaletteDelegate, TimerDelegate, DrawingsDelegate>

@property(nonatomic, copy) NSOrderedSet<UIColor *>* pickedColors;
@property                  float timerValue;
@property(nonatomic, copy) NSString *drawing;
@property(nonatomic, copy) NSTimer  *redrawTimer;

@end

