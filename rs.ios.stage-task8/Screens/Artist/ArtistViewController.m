//
//  ArtistViewController.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "ArtistViewController.h"
#import "Palette.h"
#import "NSMutableArray+Shuffle.h"

@interface ArtistViewController ()

- (IBAction)openPaletteTapped:(UIButton *)sender;
- (IBAction)openTimerTapped:(UIButton *)sender;

@end

@implementation ArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickedColors = [[NSOrderedSet<UIColor *> alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self generateColorsForLines];
}

- (IBAction)openTimerTapped:(UIButton *)sender {
//    Timer *timer = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Timer"];
//    [self configureVCAsChild:timer];
//    [self addChildViewController:timer];
//    [self.view addSubview:timer.view];
//    [timer didMoveToParentViewController:self];
}

- (IBAction)openPaletteTapped:(UIButton *)sender {
    Palette *palette = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Palette"];
    palette.pickedColors = [_pickedColors mutableCopy];
    palette.delegate = self;
    [self configureVCAsChild:palette];
    [self addChildViewController:palette];
    [self.view addSubview:palette.view];
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


- (void)paletteDidPick:(nonnull NSMutableOrderedSet<UIColor *> *)colors {
    _pickedColors = colors;
}

- (NSOrderedSet<UIColor *>*)generateColorsForLines {
    
    NSMutableArray<UIColor *>* lineColors = [[NSMutableArray alloc] initWithArray:[_pickedColors array]];
    int i = 0;
    while (_pickedColors.count + i < 3) {
        [lineColors addObject:[UIColor blackColor]];
        ++i;
    }
    [lineColors shuffle];
    return [[NSOrderedSet alloc] initWithArray:lineColors];
}

@end
