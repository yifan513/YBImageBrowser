//
//  MainController.m
//  YBImageBrowserDemo
//
//  Created by 波儿菜 on 2019/7/15.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "MainController.h"
#import "TestAController.h"
#import "TestBController.h"
#import "TestCController.h"
#import "TestDController.h"
#import "TestEController.h"
#import "TestFController.h"
#import "YBImageBrowser.h"
#import "BaseListCell.h"

@interface MainController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MainController {
    NSArray<Class> *_controllers;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"YBImageBrowser";
    _controllers = @[TestAController.self, TestBController.self, TestCController.self, TestDController.self, TestFController.self, TestEController.self];
    [self.view addSubview:self.tableView];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self
//               action:@selector(aMethod:)
//     forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"Show View" forState:UIControlStateNormal];
//    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
//    [self.view addSubview:button];

    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _controllers.count + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const kCellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    if (indexPath.row < _controllers.count)
        cell.textLabel.text = [_controllers[indexPath.row] yb_title];
    else
        cell.textLabel.text = [@"TEST direct(No new class files) " stringByAppendingFormat:@"%d", indexPath.row - _controllers.count];
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _controllers.count) {
        BaseListController *vc = [_controllers[indexPath.row] new];
        vc.title = [vc.class yb_title];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == _controllers.count){
        NSString *obj = @"https://u.mycurrentmessenger.com/uploaded_files/2021/11/11/ttl7daynTF_9e9a94cc1c2098d7abb16f3d18c73386aab3e97ff08dfac8b397d938e69937a2.png";
        NSMutableArray *datas = [NSMutableArray array];
        YBIBImageData *data = [YBIBImageData new];
        data.imageURL = [NSURL URLWithString:obj];
        data.projectiveView =  nil;
        [datas addObject:data];
        
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.dataSourceArray = datas;
        browser.currentPage = 0;
        browser.delegate = self;
        browser.toolViewHandlers = @[];
        [browser show];
    }
    else {
        BaseListController *vc = [BaseListController new];
        vc.startFirstPage = false;
        vc.title = @"testssss";
        
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:@
         [@"https://u.mycurrentmessenger.com/uploaded_files/2021/11/11/ttl7daynTF_9e9a94cc1c2098d7abb16f3d18c73386aab3e97ff08dfac8b397d938e69937a2.png",
          @"localVideo0.mp4",
          @"localImage1.gif",
          @"localImage0.jpg",
          @"localBigImage0.jpeg",
          @"localLongImage0.jpeg",
          @"https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200ff00000bdkpfpdd2r6fb5kf6m50&line=0.mp4",
          @"https://imgs.wantubizhi.com/upload/i_2/T1huMFdJZ3Y2V3VzVloxUEtCaExYZz09/3633407012x2153011765_26_0.jpg"]];
        [vc setDataArray:array];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 34, 0);
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
