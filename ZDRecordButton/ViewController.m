//
//  ViewController.m
//  ZDRecordButton
//
//  Created by LEO on 2020/4/28.
//  Copyright © 2020 LEO. All rights reserved.
//

#import "ViewController.h"
#import "ZDRecordButton.h"
@interface ViewController ()<ZDOperationActionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:240 / 255.0 alpha:1];
    
    ZDRecordButton *rManager = [[ZDRecordButton alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 80) / 2, [UIScreen mainScreen].bounds.size.height - 120, 80, 80)];
    rManager.delegate = self;
    //进度条颜色
    rManager.progressColor = [UIColor blueColor];
    [self.view addSubview:rManager];
}

#pragma ZDOperationActionDelegate
- (void)didOperationStateChange:(ZDOperationActionState)state {
    switch (state) {
        case ZDOperationStateClick: {
            NSLog(@"点击");
        }
            break;
        case ZDOperationStateBegan: {
            NSLog(@"开始");
        }
            break;
        case ZDOperationStateLongPress: {
            NSLog(@"长按");
        }
            break;
        case ZDOperationStateMoving: {
            NSLog(@"移动中");
        }
            break;
        case ZDOperationStateWillCancel: {
            NSLog(@"松手就取消");
        }
            break;
        // 完成
        case ZDOperationStateDone: {
            NSLog(@"完成");
        }
            break;
        case ZDOperationStateCancel: {
            NSLog(@"取消");
        }
            break;
        default:
            break;
    }
}



@end
