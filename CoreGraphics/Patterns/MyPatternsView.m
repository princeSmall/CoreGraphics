//
//  MyPatternsView.m
//  CoreGraphics
//
//  Created by iOS on 2018/8/28.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "MyPatternsView.h"

#define H_PATTERN_SIZE 16
#define V_PATTERN_SIZE 18
/**
 info，指向与模式关联的私有数据的通用指针。此参数是可选的; 你可以通过NULL。传递给回调的数据与您稍后在创建模式时提供的数据相同。
 context，用于绘制图案单元格的图形上下文。

 */
typedef void (*CGPatternDrawPatternCallback) (
                            void *info,
                            CGContextRef context
   );


/**
 声明了模式大小。在编写绘图代码时，需要牢记图案尺寸。这里，大小被声明为全局。除评论外，绘图功能不具体指代大小。稍后，您将图案大小指定为Quartz 2D
 绘图函数遵循CGPatternDrawPatternCallback回调类型定义定义的原型。
 在代码中执行的绘图设置颜色，这使其成为彩色图案
 */
void MyDrawColoredPattern (void *info, CGContextRef myContext)
{
    CGFloat subunit = 5; // the pattern cell itself is 16 by 18
    
    CGRect  myRect1 = {{0,0}, {subunit, subunit}},
    myRect2 = {{subunit, subunit}, {subunit, subunit}},
    myRect3 = {{0,subunit}, {subunit, subunit}},
    myRect4 = {{subunit,0}, {subunit, subunit}};
    
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 0.5);
    CGContextFillRect (myContext, myRect1);
    CGContextSetRGBFillColor (myContext, 1, 0, 0, 0.5);
    CGContextFillRect (myContext, myRect2);
    CGContextSetRGBFillColor (myContext, 0, 1, 0, 0.5);
    CGContextFillRect (myContext, myRect3);
    CGContextSetRGBFillColor (myContext, .5, 0, .5, 0.5);
    CGContextFillRect (myContext, myRect4);
}

#define PSIZE 16    // size of the pattern cell

static void MyDrawStencilStar (void *info, CGContextRef myContext)
{
    int k;
    double r, theta;
    
    r = 0.8 * PSIZE / 2;
    theta = 2 * M_PI * (2.0 / 5.0); // 144 degrees
    
    CGContextTranslateCTM (myContext, PSIZE/2, PSIZE/2);
    
    CGContextMoveToPoint(myContext, 0, r);
    for (k = 1; k < 5; k++) {
        CGContextAddLineToPoint (myContext,
                                 r * sin(k * theta),
                                 r * cos(k * theta));
    }
    CGContextClosePath(myContext);
    CGContextFillPath(myContext);
}

@implementation MyPatternsView

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
    rect.size.width = rect.size.width / 4.0;
    rect.size.height = rect.size.height / 4.0;
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    MyColoredPatternPainting(myContext, rect);

    MyStencilPatternPainting(myContext,(const Rect *)&rect);
}


/**
 1. 声明稍后创建的CGPattern对象的存储。
 2. 声明稍后创建的模式颜色空间的存储。
 3. 声明alpha的变量并将其设置为1，它将模式的不透明度指定为完全不透明。
 4. 声明变量以保持窗口的高度和宽度。在此示例中，图案绘制在窗口区域上。
 5. 声明并填充回调结构，0作为版本传递和指向绘图回调函数的指针。此示例未提供发布信息回调，因此该字段设置为NULL。
 6. 创建图案颜色空间对象，将图案的基色空间设置为NULL。绘制彩色图案时，图案在绘图回调中提供自己的颜色，这就是您将颜色空间设置为的原因NULL。
 7. 将填充颜色空间设置为刚刚创建的图案颜色空间对象。
 8. 释放图案颜色空间对象。
 9. 传递NULL因为模式不需要传递给绘图回调的任何附加信息。
 10. 传递一个CGRect对象，该对象指定模式单元格的边界。
 11. 传递CGAffineTransform矩阵，该矩阵指定如何将模式空间转换为使用模式的上下文的默认用户空间。此示例传递单位矩阵。
 12. 将水平图案大小作为每个单元格开头之间的水平位移。在此示例中，一个单元格与下一个单元格相邻。
 13. 将垂直图案大小作为每个单元格开始之间的垂直位移。
 14. 传递常量kCGPatternTilingConstantSpacing以指定Quartz应如何呈现模式。有关更多信息，请参阅平铺。
 15. 通行证true为isColored参数，指定该模式是一个彩色图案。
 16. 传递指向包含版本信息的回调结构的指针，以及指向绘图回调函数的指针。
 17. 设置填充模式，传递上下文，刚刚创建的CGPattern对象，以及指向Alpha值的指针，该值指定Quartz应用于模式的不透明度。
 18. 释放CGPattern对象。
 19. 填充一个矩形，该矩形是传递给MyColoredPatternPainting例程的窗口的大小。Quartz使用您刚刚设置的模式填充矩形。

 */
void MyColoredPatternPainting (CGContextRef myContext,
                               CGRect rect)
{
    CGPatternRef    pattern;// 1
    CGColorSpaceRef patternSpace;// 2
    CGFloat         alpha = 1;// 3

    static const    CGPatternCallbacks callbacks = {0, // 5
        &MyDrawColoredPattern,
        NULL};
    
    CGContextSaveGState (myContext);
    patternSpace = CGColorSpaceCreatePattern (NULL);// 6
    CGContextSetFillColorSpace (myContext, patternSpace);// 7
    CGColorSpaceRelease (patternSpace);// 8
    
    pattern = CGPatternCreate (NULL, // 9
                               CGRectMake (0, 0, H_PATTERN_SIZE, V_PATTERN_SIZE),// 10
                               CGAffineTransformMake (1, 0, 0, 1, 0, 0),// 11
                               H_PATTERN_SIZE, // 12
                               V_PATTERN_SIZE, // 13
                               kCGPatternTilingConstantSpacing,// 14
                               true, // 15
                               &callbacks);// 16
    
    CGContextSetFillPattern (myContext, pattern, &alpha);// 17
    CGPatternRelease (pattern);// 18
    CGContextFillRect (myContext, rect);// 19
    CGContextRestoreGState (myContext);
}

/**
 1. 声明一个数组以保存颜色值并将值（将在RGB颜色空间中）设置为不透明绿色。
 2. 声明并填充回调结构，0作为版本传递和指向绘图回调函数的指针。此示例未提供发布信息回调，因此该字段设置为NULL。
 3. 创建RGB设备颜色空间。如果将图案绘制到显示器，则需要提供此类型的色彩空间。
 4. 从RGB设备颜色空间创建图案颜色空间对象。
 5. 将填充颜色空间设置为刚刚创建的图案颜色空间对象。
 6. 创建一个模式对象。请注意，倒数第二个参数 - isColored参数 - 是false。模板图案不提供颜色，因此您必须传递false此参数。所有其他参数类似于为彩色图案示例传递的参数。请参阅完整彩色图案绘画功能。
 7. 设置填充图案，传递先前声明的颜色数组。
 8. 释放CGPattern对象。
 9. 填充矩形。Quartz使用您刚刚设置的模式填充矩形。
 */
void MyStencilPatternPainting (CGContextRef myContext,
                               const Rect *windowRect)
{
    CGPatternRef pattern;
    CGColorSpaceRef baseSpace;
    CGColorSpaceRef patternSpace;
    static const CGFloat color[4] = { 0, 1, 0, 1 };// 1
    static const CGPatternCallbacks callbacks = {0, &MyDrawStencilStar, NULL};// 2
    
    baseSpace = CGColorSpaceCreateDeviceRGB ();// 3
    patternSpace = CGColorSpaceCreatePattern (baseSpace);// 4
    CGContextSetFillColorSpace (myContext, patternSpace);// 5
    CGColorSpaceRelease (patternSpace);
    CGColorSpaceRelease (baseSpace);
    pattern = CGPatternCreate(NULL, CGRectMake(0, 0, PSIZE, PSIZE),// 6
                              CGAffineTransformIdentity, PSIZE, PSIZE,
                              kCGPatternTilingConstantSpacing,
                              false, &callbacks);
    CGContextSetFillPattern (myContext, pattern, color);// 7
    CGPatternRelease (pattern);// 8
    CGContextFillRect (myContext,CGRectMake (100,100,PSIZE*20,PSIZE*20));// 9
}

@end
