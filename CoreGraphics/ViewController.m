//
//  ViewController.m
//  CoreGraphics
//
//  Created by iOS on 2018/8/27.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "ViewController.h"
#import "NewViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *CGTableView;
@property (nonatomic ,strong)NSArray *dataArray;

@end

static NSString *const cellIndentifier = @"cellIndentifier";
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.CGTableView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (UITableView *)CGTableView{
    if (!_CGTableView) {
        _CGTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _CGTableView.delegate = self;
        _CGTableView.dataSource = self;
        _CGTableView.tableFooterView = [UIView new];
        [_CGTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIndentifier];
    }
    return _CGTableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewViewController *newVC = [[NewViewController alloc]init];
    newVC.type = indexPath.row;
    [self.navigationController pushViewController:newVC animated:YES];
}
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"graphicsContexts",@"paths", @"MyTransformsView",@"MyPatternsView",@"MyShadowsView",@"MyGradientsView",@"MyCGShadingView",@"MyTransparencyView",nil];
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
