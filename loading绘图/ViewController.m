//
//  ViewController.m
//  loading绘图
//
//  Created by qianfeng on 16/9/7.
//  Copyright © 2016年 com.xuwenjie. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
@interface ViewController ()

@property (nonatomic, weak) CircleView *circleView;
@property (nonatomic,assign) CGFloat progressNum;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self createQuan];
    
}

- (void)createQuan {
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    slider.center = self.view.center;
    [self.view addSubview:slider];
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    CircleView *circleView = [[CircleView alloc] initWithFrame:CGRectMake(100, 50, 200, 200)];
    _circleView = circleView;

    [self.view addSubview:circleView];
    circleView.progressNumber = _progressNum;
    circleView.progressColor = [UIColor redColor];
    
    
    //计时器自动轮转
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(downLoading) userInfo:nil repeats:YES];
    
}

- (void)downLoading {
    _progressNum += 0.01;
    
    if (_progressNum >=1) {
        _progressNum = 0;
    }
    
    self.circleView.progressNumber = _progressNum;
}

- (void)sliderValueChanged:(UISlider *)sender {
    
    self.circleView.progressNumber = sender.value;
    
}

@end
