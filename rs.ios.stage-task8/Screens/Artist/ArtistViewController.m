//
//  ArtistViewController.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "ArtistViewController.h"
#import "Palette.h"

@interface ArtistViewController ()

- (IBAction)openPaletteTapped:(UIButton *)sender;

@end

@implementation ArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)openPaletteTapped:(UIButton *)sender {
    Palette *palette = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Palette"];
    [self addChildViewController:palette];
    [self.view addSubview:palette.view];
    [self configureVCAsChild:palette];
    [palette didMoveToParentViewController:self];
    
}

- (void)configureVCAsChild:(UIViewController *)childVC {
    childVC.view.frame = CGRectMake(0, self.view.bounds.size.height / 2, self.view.bounds.size.width, self.view.bounds.size.height);
    childVC.view.backgroundColor     = [UIColor whiteColor];
    childVC.view.layer.cornerRadius  = 40;
    childVC.view.layer.shadowOffset  = CGSizeZero;
    childVC.view.layer.masksToBounds = NO;
    childVC.view.layer.shadowRadius  = 8.0f;
    childVC.view.layer.shadowColor   = [[UIColor blackColor] CGColor];
    childVC.view.layer.shadowOpacity = .25f;
}
@end
