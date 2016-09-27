//
//  CircleView.m
//  loading绘图
//
//  Created by qianfeng on 16/9/7.
//  Copyright © 2016年 com.xuwenjie. All rights reserved.
//

#import "CircleView.h"
#define kDefaultColor [UIColor orangeColor]


/**
 中间百分比数字的字体大小
 */
#define kPersentBumberFontSize 40

/**
 进度条宽带
 */
#define kProgressWidth 20

@interface CircleView ()

@property (nonatomic,weak) CAShapeLayer *bacgroundLayer;

@property (nonatomic,weak) CAShapeLayer *progeressLayer;

@property (nonatomic,weak) UILabel *persentLabel;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bacgroundLayer.frame = self.bounds;
    self.progeressLayer.frame = self.bounds;
    
    self.progeressLayer.strokeEnd = self.progressNumber;
}



- (void)initialize {

    CAShapeLayer *backLayer = [CAShapeLayer layer];
    
    [self.layer addSublayer:backLayer];
    
    //1.边框
//    backLayer.borderColor = [UIColor greenColor].CGColor;
//    backLayer.borderWidth = 5.0;
    
    //2.路径
    backLayer.lineWidth = kProgressWidth;
    
    backLayer.fillColor = [UIColor clearColor].CGColor;
    
    backLayer.strokeColor = [UIColor blackColor].CGColor;
    
    
    
    UIBezierPath *BezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(backLayer.lineWidth/2, backLayer.lineWidth/2, self.frame.size.width - backLayer.lineWidth, self.frame.size.height - backLayer.lineWidth)];
    
    backLayer.path = BezierPath.CGPath;
    
    _bacgroundLayer = backLayer;
    
    //中间的百分比数字
    UILabel *persentNum = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - self.bounds.size.width/4, self.bounds.size.height/2 - self.bounds.size.height/4, self.bounds.size.width/2, self.bounds.size.height/2)];
    
    persentNum.text = @"99%";
    persentNum.textAlignment = NSTextAlignmentCenter;
    persentNum.textColor = [UIColor whiteColor];
    persentNum.font = [UIFont systemFontOfSize:kPersentBumberFontSize];
    
    _persentLabel = persentNum;
    
    [self addSubview:persentNum];
}


- (CAShapeLayer *)progeressLayer {
    
    if (!_progeressLayer) {
        CAShapeLayer *progeressLayer = [CAShapeLayer layer];
        
        progeressLayer.lineWidth = kProgressWidth;
        progeressLayer.strokeColor = kDefaultColor.CGColor;
        progeressLayer.fillColor = [UIColor clearColor].CGColor;
        //两端圆头
        progeressLayer.lineCap = kCALineCapRound;
        
        //进度路径
         UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.width/2 -10 startAngle:- M_PI / 2 endAngle:M_PI * 3/2 clockwise:YES];
        
        progeressLayer.strokeStart = 0.0;
        progeressLayer.strokeEnd = self.progressNumber;
        
        progeressLayer.path = progressPath.CGPath;
        
        [self.layer addSublayer:progeressLayer];
        _progeressLayer = progeressLayer;
    }
    return _progeressLayer;
}
#pragma mark - 传值
- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    
    self.progeressLayer.strokeColor = progressColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    
    self.progeressLayer.lineWidth = lineWidth;
}

- (void)setProgressNumber:(CGFloat)progressNumber {
    _progressNumber = progressNumber;
    self.progeressLayer.strokeEnd = self.progressNumber;
    _persentLabel.text = [NSString stringWithFormat:@"%.f%%",progressNumber * 100];
    
    if (progressNumber >= 0.75) {
        
        self.progressColor = [UIColor greenColor];
        
    } else if (progressNumber <0.75 && progressNumber >= 0.5) {
        self.progressColor = [UIColor redColor];
    } else if (progressNumber <0.5 && progressNumber >= 0.25) {
        
        self.progressColor = [UIColor yellowColor];
    } else {
        self.progressColor = kDefaultColor;
    }
    
}

@end
