//
//  MyClipPathView.m
//  CoreGraphics
//
//  Created by iOS on 2018/8/27.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "MyClipPathView.h"

@implementation MyClipPathView

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/****
 首先，您创建一个路径
 你可以选择描边路径，填充路径，或两者笔触和填充的路径
 CGPathDrawingMode
 {
 kCGPathFill,   非零绕组数规则
 kCGPathEOFill, 奇偶规则
 kCGPathStroke,
 kCGPathFillStroke,   填充当前路径
 kCGPathEOFillStroke  填充当前路径
 }
 *****/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef lineContext = UIGraphicsGetCurrentContext();
    CGContextBeginPath (lineContext);
//    画线
    CGContextSetLineWidth(lineContext, 1.0);
    CGContextSetLineCap(lineContext, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(lineContext, [UIColor redColor].CGColor);
    CGContextMoveToPoint(lineContext, 50, 200);
    for (int i = 0; i < 10; i++) {
        if (i % 2 == 1) {
            CGContextAddLineToPoint(lineContext, 50 + 50 *i, 100 + 200);
        }else{
            CGContextAddLineToPoint(lineContext, 50 + 50 *i, 200);
        }
        
    }
//
    CGContextStrokePath(lineContext);
//    画三角形
    CGContextRef triangleContext = UIGraphicsGetCurrentContext();
    CGContextBeginPath(triangleContext);
    CGContextSetRGBFillColor(triangleContext, 0, 1.0, 0, 1.0);
    CGContextMoveToPoint(triangleContext, 100, 320);
    CGContextAddLineToPoint(triangleContext, 0, 420);
    CGContextAddLineToPoint(triangleContext, 200, 420);
    CGContextAddLineToPoint(triangleContext, 100, 320);
    CGContextDrawPath(triangleContext,kCGPathFill);
//    画圆
    CGContextRef roundContext =UIGraphicsGetCurrentContext();
    CGContextBeginPath(roundContext);
    CGContextSetRGBFillColor(roundContext, 0, 1.0, 0, 1.0);
    CGContextAddArc(roundContext, 100, 150, 50, 0, 2*M_PI, YES);
    CGContextDrawPath(roundContext,kCGPathFillStroke);
//    画扇形
    CGContextRef fanContext =UIGraphicsGetCurrentContext();
    CGContextBeginPath(fanContext);
    CGContextSetRGBFillColor(fanContext, 0, 1.0, 0, 1.0);
    CGContextMoveToPoint(fanContext, 300, 150);
    CGContextAddArc(fanContext, 300, 150, 50, 0, M_PI_2, YES);
    CGContextClosePath(fanContext);
    CGContextDrawPath(fanContext,kCGPathEOFillStroke);
//    画椭圆
    CGContextRef ellipseContext = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ellipseContext);
    CGContextSetRGBFillColor(ellipseContext, 0, 1.0, 0, 1.0);
    CGContextAddEllipseInRect(ellipseContext, CGRectMake(250, 320, 80, 120));
    CGContextDrawPath(ellipseContext,kCGPathStroke);
    
//    贝塞尔曲线
    CGContextRef curveContext = UIGraphicsGetCurrentContext();
    CGContextBeginPath(curveContext);
    CGContextMoveToPoint(fanContext, 50, 600);
    CGContextAddCurveToPoint(curveContext, 100, 500, 150, 700, 250, 600);
    CGContextStrokePath(curveContext);
   
    
}


@end
