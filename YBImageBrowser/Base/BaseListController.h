//
//  BaseListController.h
//  YBImageBrowserDemo
//
//  Created by 波儿菜 on 2019/7/15.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseListController : UIViewController

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic) bool startFirstPage;
@property (nonatomic, strong) NSMutableArray *datas;


- (id)viewAtIndex:(NSInteger)index;

#pragma - override

+ (NSString *)yb_title;

- (void)selectedIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
