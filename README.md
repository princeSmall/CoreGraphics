## CoreGraphics
### MyQuartzView
<pre>
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
</pre>

### MyClipPathView
<pre>/****
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
   
    
}</pre>

### MyTransformsView
<pre>
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
    
}</pre>

### MyPatternsView
<pre>
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

</pre>

### MyShadowsView
<pre>
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
</pre>

### MyGradientsView
<pre>
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
}</pre>

### MyCGShadingView
<pre>
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
</pre>