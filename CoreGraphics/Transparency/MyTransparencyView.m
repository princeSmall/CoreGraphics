//
//  MyTransparencyView.m
//  CoreGraphics
//
//  Created by le tong on 2018/8/29.
//  Copyright © 2018年 le tong. All rights reserved.
//

#import "MyTransparencyView.h"

@implementation MyTransparencyView

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
    MyDrawTransparencyLayer(myContext, rect.size.width, rect.size.height);
}

void MyDrawTransparencyLayer (CGContextRef myContext,
                              CGFloat wd,
                              CGFloat ht)
{
    CGSize          myShadowOffset = CGSizeMake (10, -20);
    
    CGContextSetShadow (myContext, myShadowOffset, 10);
//    注：主要这句代码
    CGContextBeginTransparencyLayer (myContext, NULL);
    // Your drawing code here
    CGContextSetRGBFillColor (myContext, 0, 1, 0, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3+ 50,ht/2 ,wd/4,ht/4));
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3-50,ht/2-100,wd/4,ht/4));
    CGContextSetRGBFillColor (myContext, 1, 0, 0, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3,ht/2-50,wd/4,ht/4));
//    注：主要这句代码
    CGContextEndTransparencyLayer (myContext);
}
@end
