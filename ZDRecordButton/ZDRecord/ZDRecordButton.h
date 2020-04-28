//
//  ZDRecordButton.h
//  videoDealDemo
//
//  Created by 文昊诚 on 2020/4/21.
//  Copyright © 2020 文昊诚. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZDOperationActionState){
    ZDOperationStateBegan = 0,       // 开始
    ZDOperationStateLongPress = 1,   // 长按
    ZDOperationStateMoving = 2,      // 移动中
    ZDOperationStateWillCancel = 3,  // 拖到范围外
    ZDOperationStateDone = 4,        // 长按之后松手
    ZDOperationStateCancel = 5,      // 拖到外面松手取消
    ZDOperationStateClick = 6        // 仅仅点一下，没有其他操作
};
NS_ASSUME_NONNULL_BEGIN
@protocol ZDOperationActionDelegate <NSObject>

-(void)didOperationStateChange:(ZDOperationActionState)state;

@end
@interface ZDRecordButton : UIView
/*
*
* 按钮操作状态的回调
*/
@property (nonatomic, weak)id <ZDOperationActionDelegate>delegate;
/*
*
* 进度条颜色,默认绿色
*/
@property (nonatomic, strong)UIColor *progressColor;
/*
*
* 外面圆形颜色,默认浅灰色
*/
@property (nonatomic, strong)UIColor *outCircleColor;
/*
*
* 中间圆形颜色,默认白色
*/
@property (nonatomic, strong)UIColor *centerCircleColor;
/*
*
* 倒计时时间,默认15秒
*/
@property (nonatomic, assign)float timeInterval;
@end

NS_ASSUME_NONNULL_END
