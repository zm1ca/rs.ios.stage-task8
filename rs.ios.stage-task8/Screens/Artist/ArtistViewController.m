//
//  ArtistViewController.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "ArtistViewController.h"
#import "Palette.h"
#import "RSButton.h"
#import "CanvasView.h"
#import "CanvasView+Head.h"
#import "NSMutableArray+Shuffle.h"
#import "UIView+AsImage.h"
#import "rs_ios_stage_task8-Swift.h"

@interface ArtistViewController ()

@property (weak, nonatomic) IBOutlet RSButton *openPaletteButton;
@property (weak, nonatomic) IBOutlet RSButton *drawButton;
@property (weak, nonatomic) IBOutlet RSButton *openTimerButton;
@property (weak, nonatomic) IBOutlet RSButton *shareButton;

@property (weak, nonatomic) IBOutlet CanvasView *canvas;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *drawingsBarButton;

- (IBAction)drawTapped:(id)sender;
- (IBAction)openPaletteTapped:(UIButton *)sender;
- (IBAction)openTimerTapped:(UIButton *)sender;
- (IBAction)shareButtonTapped:(id)sender;

@end

@implementation ArtistViewController

//MARK: Lifecycle and customization
- (void)viewDidLoad {
    [super viewDidLoad];
    _pickedColors = [[NSOrderedSet<UIColor *> alloc] init];
    _timerValue   = 1;
    _drawing      = @"Head";
//    [_shareButton setDisabled];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self generateColorsForLines];
    [self crutchForBarButtonFont];
}

-(void)crutchForBarButtonFont {
    [self.drawingsBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
        [UIFont fontWithName:@"Montserrat-Regular" size:17.0], NSFontAttributeName,
                                                    nil]
                                          forState:UIControlStateNormal];
    [self.drawingsBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
        [UIFont fontWithName:@"Montserrat-Regular" size:17.0], NSFontAttributeName,
                                                    nil]
                                          forState:UIControlStateHighlighted];
}


//MARK: - Drawing
- (IBAction)drawTapped:(id)sender {
    NSArray<UIColor *>* colors = [self generateColorsForLines];
    [_canvas drawHeadWithColor1:colors[0] color2:colors[1] color3:colors[2]];
}

- (NSMutableArray<UIColor *>*)generateColorsForLines {
    NSMutableArray<UIColor *>* lineColors = [[NSMutableArray alloc] initWithArray:[_pickedColors array]];
    while (lineColors.count < 3) {
        [lineColors addObject:[UIColor blackColor]];
    }
    [lineColors shuffle];
    return lineColors;
}

- (void)adjustLayersStrokeEndTo:(float)strokeEnd {
    _canvas.shape1Layer.strokeEnd = strokeEnd;
    _canvas.shape2Layer.strokeEnd = strokeEnd;
    _canvas.shape3Layer.strokeEnd = strokeEnd;
}


//MARK: - Communicating with Child VC's Timer and Palette
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

//MARK: Palette
- (IBAction)openPaletteTapped:(UIButton *)sender {
    Palette *palette = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Palette"];
    palette.pickedColors = [_pickedColors mutableCopy];
    palette.delegate = self;
    [self configureVCAsChild:palette];
    [self addChildViewController:palette];
    [self.view addSubview:palette.view];
    [palette didMoveToParentViewController:self];
}

- (void)paletteDidPick:(nonnull NSMutableOrderedSet<UIColor *> *)colors {
    _pickedColors = colors;
}

//MARK: Timer
- (void)timerDidPickWithValue:(float)value {
    _timerValue = value;
}

- (IBAction)openTimerTapped:(UIButton *)sender {
    Timer *timer = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Timer"];
    timer.timerValue = [[NSNumber alloc] initWithFloat:_timerValue];
    timer.delegate = self;
    [self configureVCAsChild:timer];
    [self addChildViewController:timer];
    [self.view addSubview:timer.view];
    [timer didMoveToParentViewController:self];
}


//MARK: - Communicating with Drawings
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Drawings *destVC = (Drawings *)segue.destinationViewController;
    destVC.delegate = self;
    destVC.selectedDrawing = _drawing;
}

- (void)updateDrawingWithDrawing:(NSString * _Nonnull)drawing {
    _drawing = drawing;
}


//MARK: - Sharing
- (IBAction)shareButtonTapped:(id)sender {
    UIGraphicsBeginImageContext(_canvas.frame.size);
    [_canvas.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *canvasImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *pngData = UIImagePNGRepresentation(canvasImage);
    //UIImage *pngImage = [[UIImage alloc] initWithData:pngData];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[pngData] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}


@end
