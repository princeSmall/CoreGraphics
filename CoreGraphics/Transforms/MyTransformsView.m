//
//  MyTransformsView.m
//  CoreGraphics
//
//  Created by iOS on 2018/8/27.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "MyTransformsView.h"
#include <math.h>

@implementation MyTransformsView

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
static inline double radians(double degress){
    return degress *M_PI / 180;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    UIImage *image = [UIImage imageNamed:@"snow.jpg"];
    CGImageRef imageRef = image.CGImage;
    CGContextSaveGState(myContext);
//    旋转一周
//    CGContextTranslateCTM(myContext, 400, 600);
//    CGContextRotateCTM(myContext, M_PI);
//    旋转半周
    CGContextTranslateCTM(myContext, 500, 100);
    CGContextRotateCTM(myContext, radians(90));
//    缩放
//    CGContextScaleCTM(myContext, 0.5, 0.8);
//    平移
//    CGContextTranslateCTM(myContext, 100, 100);
    CGContextDrawImage(myContext, CGRectMake(100, 200, 200, 200), imageRef);
    CGContextRestoreGState(myContext);
    
}




@end
