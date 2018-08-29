//
//  MyCGShadingView.m
//  CoreGraphics
//
//  Created by le tong on 2018/8/29.
//  Copyright © 2018年 le tong. All rights reserved.
//

#import "MyCGShadingView.h"

@implementation MyCGShadingView

static void myCalculateShadingValues (void *info,
                                      const CGFloat *in,
                                      CGFloat *out)
{
    CGFloat v;
    size_t k, components;
    static const CGFloat c[] = {1, 0, .5, 0 };
    
    components = (size_t)info;
    
    v = *in;
    for (k = 0; k < components -1; k++)
        *out++ = c[k] * v;
    *out++ = 1;
}
static CGFunctionRef myGetFunction (CGColorSpaceRef colorspace)// 1
{
    size_t numComponents;
    static const CGFloat input_value_range [2] = { 0, 1 };
    static const CGFloat output_value_ranges [8] = { 0, 1, 0, 1, 0, 1, 0, 1 };
    static const CGFunctionCallbacks callbacks = { 0,// 2
        &myCalculateShadingValues,
        NULL };
    
    numComponents = 1 + CGColorSpaceGetNumberOfComponents (colorspace);// 3
    return CGFunctionCreate ((void *) numComponents, // 4
                             1, // 5
                             input_value_range, // 6
                             numComponents, // 7
                             output_value_ranges, // 8
                             &callbacks);// 9
}
void myPaintRadialShading (CGContextRef myContext,// 1
                           CGRect bounds)
{
    
    CGPoint startPoint,
    endPoint;
    CGFloat startRadius,
    endRadius;
    CGAffineTransform myTransform;
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    
    startPoint = CGPointMake(0.25,0.3); // 2
    startRadius = .1;  // 3
    endPoint = CGPointMake(.7,0.7); // 4
    endRadius = .25; // 5
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB(); // 6
    CGFunctionRef myShadingFunction = myGetFunction (colorspace); // 7
    
    CGShadingRef shading = CGShadingCreateRadial (colorspace, // 8
                                                  startPoint, startRadius,
                                                  endPoint, endRadius,
                                                  myShadingFunction,
                                                  false, false);
    
    myTransform = CGAffineTransformMakeScale (width, height); // 9
    CGContextConcatCTM (myContext, myTransform); // 10
    CGContextSaveGState (myContext); // 11
    
    CGContextClipToRect (myContext, CGRectMake(0, 0, 1, 1)); // 12
    CGContextSetRGBFillColor (myContext, 1, 1, 1, 1);
    CGContextFillRect (myContext, CGRectMake(0, 0, 1, 1));
    
    CGContextDrawShading (myContext, shading); // 13
    CGColorSpaceRelease (colorspace); // 14
    CGShadingRelease (shading);
    CGFunctionRelease (myShadingFunction);
    
    CGContextRestoreGState (myContext); // 15
}
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    myPaintRadialShading(myContext, rect);
}


@end
