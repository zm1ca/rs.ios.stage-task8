//
//  UIView+AsImage.m
//  rs.ios.stage-task8
//
//  Created by Źmicier Fiedčanka on 16.07.21.
//

#import "UIView+AsImage.h"

@implementation UIView (AsImage)

- (UIImage *)asImage {
    UIGraphicsImageRenderer* renderer = [[UIGraphicsImageRenderer alloc] initWithBounds:self.bounds];
    return [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [self.layer renderInContext:[rendererContext CGContext]];
    }];
}

@end
