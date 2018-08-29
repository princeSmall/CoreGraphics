//
//  NewViewController.h
//  CoreGraphics
//
//  Created by le tong on 2018/8/27.
//  Copyright © 2018年 le tong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,viewType) {
    graphicsContexts = 0,
    paths,
    transforms,
    patterns,
    shadows,
    gradients,
    shading,
    transparency
};

@interface NewViewController : UIViewController
@property (nonatomic ,assign)viewType type;

@end
