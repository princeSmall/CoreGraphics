//
//  MyGradientsView.m
//  CoreGraphics
//
//  Created by iOS on 2018/8/28.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "MyGradientsView.h"

static void quartzGradients(CGRect rect){
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    CGGradientRef myGradient;
    CGColorSpaceRef myColorSpace;
    size_t num_locations = 2;
    CGFloat locations[2] = {0.0,1.0};
    CGFloat components[8] = { 1.0, 0.5, 0.4, 1.0,
        0.8, 0.8, 0.3, 1.0
    };
    myColorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    myGradient = CGGradientCreateWithColorComponents(myColorSpace, components, locations, num_locations);
    
    CGContextSaveGState(myContext);
    CGContextMoveToPoint(myContext, 20, 90);
    CGContextAddLineToPoint(myContext, 160, 90);
    CGContextAddLineToPoint(myContext, 160, 310);
    CGContextAddLineToPoint(myContext, 20, 310);
    CGContextClip(myContext);
    
    
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 20.0;
    myStartPoint.y = 90.0;
    myEndPoint.x = 160.0;
    myEndPoint.y = 310.0;
    CGContextDrawLinearGradient (myContext, myGradient, myStartPoint, myEndPoint, kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(myGradient);
    CGColorSpaceRetain(myColorSpace);
    CGContextRestoreGState(myContext);
}

static void sevenGradients(CGRect rect){
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    CGGradientRef myGradient;
    CGColorSpaceRef myColorSpace;
    size_t num_locations = 7;
    CGFloat locations[] = {0.0,0.3,0.4,0.5,0.6,0.7,1.0};
    CGFloat components[] = {
        1.0, 0.0, 0.0, 1.0,
        1.0, 1.0, 0.0, 1.0,
        0.0, 1.0, 0.0, 1.0,
        0.0, 0.0, 1.0, 1.0,
        0.0, 1.0, 1.0, 1.0,
        1.0, 0.5, 0.0, 1.0,
        0.5, 0.0, 0.5, 1.0,
    };

    myColorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    myGradient = CGGradientCreateWithColorComponents(myColorSpace, components, locations, num_locations);
    
    CGContextSaveGState(myContext);
    CGContextMoveToPoint(myContext, 180, 90);
    CGContextAddLineToPoint(myContext, 340, 90);
    CGContextAddLineToPoint(myContext, 340, 310);
    CGContextAddLineToPoint(myContext, 180, 310);
    CGContextClip(myContext);
    
    
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 180.0;
    myStartPoint.y = 90.0;
    myEndPoint.x = 340.0;
    myEndPoint.y = 310.0;
    CGContextDrawLinearGradient (myContext, myGradient, myStartPoint, myEndPoint, kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(myGradient);
    CGColorSpaceRetain(myColorSpace);
    CGContextRestoreGState(myContext);
}




@implementation MyGradientsView

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
    quartzGradients(rect);
    sevenGradients(rect);
   
}



@end
