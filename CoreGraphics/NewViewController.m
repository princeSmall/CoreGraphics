//
//  NewViewController.m
//  CoreGraphics
//
//  Created by le tong on 2018/8/27.
//  Copyright © 2018年 le tong. All rights reserved.
//

#import "NewViewController.h"
#import "MyQuartzView.h"
#import "MyClipPathView.h"
#import "MyTransformsView.h"
#import "MyPatternsView.h"

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
