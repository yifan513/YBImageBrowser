//
//  TestAController.m
//  YBImageBrowserDemo
//
//  Created by 波儿菜 on 2019/7/15.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "TestAController.h"
#import "YBImageBrowser.h"
#import "YBIBVideoData.h"
#import "BaseFileManager.h"

@interface TestAController ()

@end

@implementation TestAController

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:[BaseFileManager imageURLs]];
        [array addObjectsFromArray:[BaseFileManager imageNames]];
        [array addObjectsFromArray:[BaseFileManager videos]];
        
        [array addObjectsFromArray:@[@"https://u.mycurrentmessenger.com/uploaded_files/2021/11/11/ttl7daynTF_9e9a94cc1c2098d7abb16f3d18c73386aab3e97ff08dfac8b397d938e69937a2.png"]];
        self.dataArray = array;
    }
    return self;
}

+ (NSString *)yb_title {
    return @"展示图片+视频";
}

#pragma mark - override

- (void)selectedIndex:(NSInteger)index {
    
    NSMutableArray *datas = [NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasSuffix:@".mp4"] && [obj hasPrefix:@"http"]) {
            
            // 网络视频
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL URLWithString:obj];
            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
         
        } else if ([obj hasSuffix:@".mp4"]) {
            
            // 本地视频
            NSString *path = [[NSBundle mainBundle] pathForResource:obj.stringByDeletingPathExtension ofType:obj.pathExtension];
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL fileURLWithPath:path];
            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
            
        } else if ([obj hasPrefix:@"http"]) {
            
            // 网络图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:obj];
            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
            
        } else {
            
            // 本地图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageName = obj;
            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
            
        }
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = index;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    [browser show];
}

@end
