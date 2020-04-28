//
//  ZDRecordButton.m
//  videoDealDemo
//
//  Created by 文昊诚 on 2020/4/21.
//  Copyright © 2020 文昊诚. All rights reserved.
//

#import "ZDRecordButton.h"
//#define ZDAngle(angle) (angle / 180.0f * M_PI)

@interface ZDRecordButton (){
    float tempInterval;
    float progress;      // 进度
    BOOL  isCancel;      //判断是取消还是完成
    BOOL  isProgress;    //判断是否正在长按
    BOOL  isTimeout;     //判断倒计时是否走完
}
@property (nonatomic, strong)CADisplayLink *link;
@property (nonatomic, strong)CAShapeLayer  *progressLayer;     // 进度条
@property (nonatomic, strong)UIBezierPath  *progressBezierPath;
@property (nonatomic, strong)CAShapeLayer  *outCircleLayer;    // 外圆
@property (nonatomic, strong)CAShapeLayer  *centerCircleLayer; // 内圆
@end

@implementation ZDRecordButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.layer addSublayer:self.outCircleLayer];
    [self.layer addSublayer:self.centerCircleLayer];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPress];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    [self addGestureRecognizer:tap];
    
    tempInterval = 0.0;
    progress = 0.0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.progressLayer.frame = self.bounds;
    
    self.outCircleLayer.fillColor = self.outCircleColor.CGColor;
    self.centerCircleLayer.fillColor = self.centerCircleColor.CGColor;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat width = self.bounds.size.width;
    CGFloat mainWidth = width / 2;
    CGRect mainFrame = CGRectMake(mainWidth / 2.0, mainWidth / 2.0, mainWidth, mainWidth);
    
    CGRect outCircleFrame = CGRectInset(mainFrame, -0.2 * mainWidth / 2.0, -0.2 * mainWidth / 2.0);
    if (isProgress) {
        //向外变大一点
        outCircleFrame = CGRectInset(mainFrame, -0.4 * mainWidth / 2.0, -0.4 * mainWidth / 2.0);
        //中间的圈向里面缩小一点
        mainWidth *= 0.8;
        mainFrame = CGRectMake((width - mainWidth)/2.0, (width - mainWidth)/2.0, mainWidth, mainWidth);
    }
    UIBezierPath *outCirclePath = [UIBezierPath bezierPathWithRoundedRect:outCircleFrame cornerRadius:width / 2.0];
    self.outCircleLayer.path = outCirclePath.CGPath;
    
    UIBezierPath *centerPath = [UIBezierPath bezierPathWithRoundedRect:mainFrame cornerRadius:mainWidth / 2];
    self.centerCircleLayer.path = centerPath.CGPath;
    
    if (isProgress) {
        CGRect progressFrame = CGRectInset(outCircleFrame, 1.0, 2.0);
        self.progressBezierPath = [UIBezierPath bezierPathWithRoundedRect:progressFrame cornerRadius:width / 2.0];
        self.progressLayer.path = self.progressBezierPath.CGPath;
        self.progressLayer.strokeEnd = progress;
    }
}

#pragma method

- (void)longPress:(UILongPressGestureRecognizer *)ges {
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:{
            [self.link setPaused:NO];
            isProgress = YES;
            isTimeout = NO;
            [self.layer addSublayer:self.progressLayer];
            if ([self.delegate respondsToSelector:@selector(didOperationStateChange:)]) {
                [self.delegate didOperationStateChange:ZDOperationStateBegan];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint point = [ges locationInView:self];
            if ([self pointInside:point withEvent:nil]) {
                isCancel = NO;
                if ([self.delegate respondsToSelector:@selector(didOperationStateChange:)]) {
                    [self.delegate didOperationStateChange:ZDOperationStateMoving];
                }
            } else {
                isCancel = YES;
                if ([self.delegate respondsToSelector:@selector(didOperationStateChange:)]) {
                    [self.delegate didOperationStateChange:ZDOperationStateWillCancel];
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{
            [self stop];
            if (isCancel) {
                if ([self.delegate respondsToSelector:@selector(didOperationStateChange:)]) {
                    [self.delegate didOperationStateChange:ZDOperationStateCancel];
                }
            } else if (!isTimeout) {
                // 如果是倒计时时间到了，就不用执行代理回调
                if ([self.delegate respondsToSelector:@selector(didOperationStateChange:)]) {
                    [self.delegate didOperationStateChange:ZDOperationStateDone];
                }
            }
        }
            break;
        default:
            [self stop];
            isCancel = YES;
            if ([self.delegate respondsToSelector:@selector(didOperationStateChange:)]) {
                [self.delegate didOperationStateChange:ZDOperationStateCancel];
            }
            break;
    }
    [self setNeedsDisplay];
}

-(void)tapGes:(UITapGestureRecognizer *)ges {
    if ([self.delegate respondsToSelector:@selector(didOperationStateChange:)]) {
        [self.delegate didOperationStateChange:ZDOperationStateClick];
    }
}


- (void)runlink {
    tempInterval += 1 / 60.0;
    progress = tempInterval / self.timeInterval;
    
    if (tempInterval >= self.timeInterval) {
        [self stop];
        // 倒计时时间到了自动完成操作
        if ([self.delegate respondsToSelector:@selector(didOperationStateChange:)]) {
            [self.delegate didOperationStateChange:ZDOperationStateDone];
        }
    }
    
    [self setNeedsDisplay];
}

- (void)stop {
    tempInterval = 0.0;
    progress = 0.0;
    
    isProgress = NO;
    isTimeout = YES;;
    self.progressLayer.strokeEnd = 0;
    [self.progressLayer removeFromSuperlayer];
    [self.link setPaused:YES];
    [self setNeedsDisplay];
}

-(void)dealloc {
    NSLog(@"dealloc");
    [self.link invalidate];
}

#pragma lazy
/**
*
*  @return CADisplayLink
*/
-(CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(runlink)];
        if (@available(iOS 10.0, *)) {
            _link.preferredFramesPerSecond = 60;
        } else {
            // Fallback on earlier versions
        }//每秒执行60次
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [_link setPaused:YES];
    }
    return _link;
}

/**
*
*  @return 进度条layer
*/
-(CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = nil;
        _progressLayer.strokeColor = self.progressColor.CGColor;
        _progressLayer.lineWidth = 2.0;
    }
    return _progressLayer;
}

/**
*
*  @return 最外面的圆形layer
*/
-(CAShapeLayer *)outCircleLayer {
    if (!_outCircleLayer) {
        _outCircleLayer = [CAShapeLayer layer];
        _outCircleLayer.frame = self.bounds;
    }
    return _outCircleLayer;
}

/**
*
*  @return 中间的圆形layer
*/
-(CAShapeLayer *)centerCircleLayer {
    if (!_centerCircleLayer) {
        _centerCircleLayer = [CAShapeLayer layer];
        _centerCircleLayer.frame = self.bounds;
    }
    return _centerCircleLayer;
}

/**
*
*  @return 倒计时时间
*/
-(float)timeInterval {
    if (!_timeInterval) {
        return 15.0;
    } else {
        return _timeInterval;
    }
}

/**
*
*  @return 进度条颜色
*/
-(UIColor *)progressColor {
    if (!_progressColor) {
        return [UIColor greenColor];
    } else {
        return _progressColor;
    }
}

/**
*
*  @return 外面圆形颜色
*/
-(UIColor *)outCircleColor {
    if (!_outCircleColor) {
        return [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
    } else {
        return _outCircleColor;
    }
}

/**
*
*  @return 中间圆形颜色
*/
-(UIColor *)centerCircleColor {
    if (!_centerCircleColor) {
        return [UIColor whiteColor];
    } else {
        return _centerCircleColor;
    }
}


@end
