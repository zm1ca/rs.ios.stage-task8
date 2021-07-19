//
//  ArtistVC.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 15.07.21.
//

#import "ArtistVC.h"
#import "PaletteVC.h"
#import "BRButton.h"
#import "CanvasView.h"
#import "CanvasView+Planet.h"
#import "CanvasView+Landscape.h"
#import "CanvasView+Tree.h"
#import "CanvasView+Head.h"
#import "NSMutableArray+Shuffle.h"
#import "UIView+AsImage.h"
#import "rs_ios_stage_task8-Swift.h"

@interface ArtistVC ()

@property (weak, nonatomic) IBOutlet BRButton *openPaletteButton;
@property (weak, nonatomic) IBOutlet BRButton *drawButton;
@property (weak, nonatomic) IBOutlet BRButton *openTimerButton;
@property (weak, nonatomic) IBOutlet BRButton *shareButton;
@property (weak, nonatomic) IBOutlet CanvasView *canvas;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *drawingsBarButton;

- (IBAction)drawTapped:       (UIButton *)sender;
- (IBAction)openPaletteTapped:(UIButton *)sender;
- (IBAction)openTimerTapped:  (UIButton *)sender;
- (IBAction)shareButtonTapped:(UIButton *)sender;

@end

@implementation ArtistVC

//MARK: Lifecycle and customization
- (void)viewDidLoad {
    [super viewDidLoad];
    _pickedColors = [[NSOrderedSet<UIColor *> alloc] init];
    _timerValue   = 1;
    _drawing      = @"Head";
    [self setIdleState];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self generateColorsForLines];
    [self crutchForBarButtonFont];
}

-(void)crutchForBarButtonFont {
    NSDictionary *fontDict = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Montserrat-Regular" size:17.0], NSFontAttributeName, nil];
    [self.drawingsBarButton setTitleTextAttributes: fontDict forState:UIControlStateNormal];
    [self.drawingsBarButton setTitleTextAttributes: fontDict forState:UIControlStateHighlighted];
}


//MARK: - Managing state
- (void)setIdleState {
    [_openPaletteButton setDefaultTint];
    [_openTimerButton   setDefaultTint];
    [_drawButton        setDefaultTint];
    
    [_shareButton       setDisabledTint];
}

- (void)setDrawState {
    [_openPaletteButton setDisabledTint];
    [_openTimerButton   setDisabledTint];
    [_drawButton        setDisabledTint];
    [_shareButton       setDisabledTint];
}

- (void)setDoneState {
    [_openPaletteButton setDisabledTint];
    [_openTimerButton   setDisabledTint];
    
    [_drawButton        setDefaultTint];
    [_shareButton       setDefaultTint];
}


//MARK: - Drawing
- (IBAction)drawTapped:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Draw"]) {
        [self setDrawState];
        
        if ([_drawing isEqualToString:@"Planet"]) {
            [_canvas drawPlanetWithColors:[self generateColorsForLines]];
        } else if ([_drawing isEqualToString:@"Head"]) {
            [_canvas drawHeadWithColors:[self generateColorsForLines]];
        } else if ([_drawing isEqualToString:@"Tree"]) {
            [_canvas drawTreeWithColors:[self generateColorsForLines]];
        } else {
            [_canvas drawLandscapeWithColors:[self generateColorsForLines]];
        }
            
        [_redrawTimer invalidate];
        [self setLayersStrokeEndTo:0];
        __block float stroke = 0;
        _redrawTimer = [NSTimer scheduledTimerWithTimeInterval:0.01667 repeats:YES block:^(NSTimer * _Nonnull timer) {
            stroke += (0.01667 / self->_timerValue);
            [self setLayersStrokeEndTo:stroke];
            if (stroke >= 1)  {
                [timer invalidate];
                sender.titleLabel.text = @"Reset";
                [sender setTitle:@"Reset" forState:UIControlStateNormal];
                [self setDoneState];
            }
        }];
    } else {
        [self setIdleState];
        [sender setTitle:@"Draw" forState:UIControlStateNormal];
        [self setLayersStrokeEndTo:0];
    }
}

- (NSMutableArray<UIColor *>*)generateColorsForLines {
    NSMutableArray<UIColor *>* lineColors = [[NSMutableArray alloc] initWithArray:[_pickedColors array]];
    while (lineColors.count < 3) {
        [lineColors addObject:[UIColor blackColor]];
    }
    [lineColors shuffle];
    return lineColors;
}

- (void)setLayersStrokeEndTo:(float)strokeEnd {
    _canvas.shape1Layer.strokeEnd = strokeEnd;
    _canvas.shape2Layer.strokeEnd = strokeEnd;
    _canvas.shape3Layer.strokeEnd = strokeEnd;
}


//MARK: - Communicating with Child VC's Timer and Palette
- (void)configureAsRoundedAndHalfSize:(UIViewController *)childVC {
    childVC.view.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        childVC.view.frame = CGRectMake(0, self.view.bounds.size.height / 2, self.view.bounds.size.width, self.view.bounds.size.height);
    }];
    
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
    PaletteVC *palette = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Palette"];
    palette.pickedColors = [_pickedColors mutableCopy];
    palette.delegate = self;
    [self configureAsRoundedAndHalfSize:palette];
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
    TimerVC *timer = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Timer"];
    timer.timerValue = [[NSNumber alloc] initWithFloat:_timerValue];
    timer.delegate = self;
    [self configureAsRoundedAndHalfSize:timer];
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
- (IBAction)shareButtonTapped:(UIButton *)sender {
    UIGraphicsBeginImageContext(_canvas.frame.size);
    [_canvas.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *canvasImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *pngData = UIImagePNGRepresentation(canvasImage);
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[pngData] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}


@end
