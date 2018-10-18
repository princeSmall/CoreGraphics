
//
//  MyShadowsView.m
//  CoreGraphics
//
//  Created by iOS on 2018/8/28.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "MyShadowsView.h"

@implementation MyShadowsView


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
    MyDrawWithShadows(myContext, rect.size.width, rect.size.height);
}

/**
 2. 声明并创建一个包含阴影偏移值的CGSize对象。这些值指定对象左侧15个单位和对象上方20个单位的阴影偏移。
 3. 声明一个颜色值数组。此示例使用RGBA，但这些值在将它们与颜色空间一起传递给Quartz之前不会具有任何意义，这是Quartz正确解释值所必需的。
 4. 声明存储颜色参考。
 5. 声明颜色空间参考的存储。
 6. 保存当前图形状态，以便以后可以恢复。
 7. 设置阴影以具有先前声明的偏移值和模糊值5，这表示软阴影边缘。阴影将显示为灰色，RGBA值为{0,0,0,1 / 3}。
 8. 接下来的两行代码绘制了图7-3右侧的矩形。您可以使用自己的绘图代码替换这些行。
 9. 创建设备RGB颜色空间。创建CGColor对象时需要提供颜色空间。
 10. 创建一个CGColor对象，提供设备RGB颜色空间和先前声明的RGBA值。此对象指定阴影颜色，在本例中为红色，alpha值为0.6。
 11. 设置颜色阴影，提供刚刚创建的红色。阴影使用先前创建的偏移量和模糊值5，表示软阴影边缘。
 12. 接下来的两行代码在图7-3的左侧绘制矩形。您可以使用自己的绘图代码替换这些行。
 13. 释放颜色对象，因为不再需要它。
 14. 释放颜色空间对象，因为不再需要它。
 15. 将图形状态恢复为设置阴影之前的状态。
 
 注：CGContextSetRGBFillColor颜色一定在CGContextFillRect绘图之前

 */
void MyDrawWithShadows (CGContextRef myContext,CGFloat wd, CGFloat ht)
{
    CGSize          myShadowOffset = CGSizeMake (-15,  20);// 2
    CGFloat         myColorValues[] = {1, 0, 0, .6};// 3
    CGColorRef      myColor;// 4
    CGColorSpaceRef myColorSpace;// 5
    
    CGContextSaveGState(myContext);// 6
    
    CGContextSetShadow (myContext, myShadowOffset, 5); // 7
    // Your drawing code here// 8
    CGContextSetRGBFillColor (myContext, 0, 1, 0, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3 + 75, ht/2 , wd/4, ht/4));
    
    myColorSpace = CGColorSpaceCreateDeviceRGB ();// 9
    myColor = CGColorCreate (myColorSpace, myColorValues);// 10
    CGContextSetShadowWithColor (myContext, myShadowOffset, 5, myColor);// 11
    // Your drawing code here// 12
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3-75,ht/2-100,wd/4,ht/4));
    
    CGColorRelease (myColor);// 13
    CGColorSpaceRelease (myColorSpace); // 14
    
    CGContextRestoreGState(myContext);// 15
}

@end
