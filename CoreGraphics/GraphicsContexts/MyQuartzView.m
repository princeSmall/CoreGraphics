//
//  MyQuartzView.m
//  CoreGraphics
//
//  Created by iOS on 2018/8/27.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "MyQuartzView.h"

@implementation MyQuartzView

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/***
 获取视图的图形上下文。
 填充一个矩形，其原点为（0,0），宽度为200和高度为100。有关绘制矩形的信息，请参阅路径。
 设置部分透明的蓝色填充颜色。
 填充一个矩形，其原点为（0,0），宽度为100和高度为200。
 ****/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(myContext, 1.0, 0, 0, 1.0);
    CGContextFillRect(myContext, CGRectMake(0, 64, 200, 100));
    
    CGContextSetRGBFillColor(myContext, 0, 0, 1.0, 0.5);
    CGContextFillRect(myContext, CGRectMake(0, 64, 100, 200));

}


@end
