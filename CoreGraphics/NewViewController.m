//
//  NewViewController.m
//  CoreGraphics
//
//  Created by iOS on 2018/8/27.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "NewViewController.h"
#import "MyQuartzView.h"
#import "MyClipPathView.h"
#import "MyTransformsView.h"
#import "MyPatternsView.h"
#import "MyShadowsView.h"
#import "MyGradientsView.h"
#import "MyCGShadingView.h"
#import "MyTransparencyView.h"
@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}
- (void)setupUI{
    switch (self.type) {
        case graphicsContexts:{
            MyQuartzView * quartzV = [[MyQuartzView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:quartzV];
        }break;
        case paths:{
            MyClipPathView *clipPathV = [[MyClipPathView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:clipPathV];
        }break;
        case transforms:{
            MyTransformsView  *transformsV = [[MyTransformsView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:transformsV];
        }break;
        case patterns:{
            MyPatternsView *patternsV = [[MyPatternsView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:patternsV];
        }break;
        case shadows:{
            MyShadowsView *shadowsV = [[MyShadowsView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:shadowsV];
        }break;
        case gradients:{
            MyGradientsView *gradientsV = [[MyGradientsView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:gradientsV];
        }break;
        case shading:{
            MyCGShadingView *shadingV = [[MyCGShadingView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:shadingV];
        }break;
        case transparency:{
            MyTransparencyView *transparencyV = [[MyTransparencyView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:transparencyV];
        }break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
