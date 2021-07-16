//
//  ViewController.h
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import <UIKit/UIKit.h>
#import "Palette.h"

@interface ArtistViewController : UIViewController <UIViewControllerTransitioningDelegate, PaletteDelegate>

@property(nonatomic, copy) NSOrderedSet<UIColor *>* pickedColors;

@end

