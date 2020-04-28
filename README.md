# ZDRecordButton
仿微信长钮录制视频和点击拍照的按钮控件。
此控件只提供控件UI，控件的操作状态都有代理回调返回，关于编辑视频和照片后续会出。


![image](https://github.com/leozhuo/ZDRecordButton/blob/master/gifs/0reud-ezcn92.gif)

# 可以自定义修改进度条、外圆内圆的颜色
![image](https://github.com/leozhuo/ZDRecordButton/blob/master/gifs/itc66-ry7ak2.gif)
# 集成
```
第一种：直接把工程的ZDRecord文件夹拖进项目中
第二种：通过pod集成：pod 'ZDRecordButton', '~> 0.0.2'
```

# 使用
```
#import "ZDRecordButton.h"
@interface ViewController ()<ZDOperationActionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
```

# 结束
```
开发那么久都没有发布过作品，干脆写一个简单的控件发布一下。
第一次发布开源作品，有写的不好的地方或者有什么建议的，欢迎指出，谢谢。
```
