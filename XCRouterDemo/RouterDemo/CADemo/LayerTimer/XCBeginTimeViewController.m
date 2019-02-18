//
//  XCBeginTimeViewController.m
//  CADemo
//
//  Created by Alexcai on 2019/2/15.
//  Copyright © 2019 dongjiu. All rights reserved.
//

#import "XCBeginTimeViewController.h"

@interface XCBeginTimeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeOffsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@property (nonatomic, weak) CALayer *animationLayer;
@property (nonatomic, strong)UIBezierPath *animationPath;
@end

@implementation XCBeginTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

/** Core Animation Time 相对时间 : begin time , time off , speed , */
/** begin time : 动画开始时间,用作延时, 默认是0,也就是动画添加到可视layer后,立刻开始动画效果
 time offset: 动画偏移时间,相当于快进效果,也就是动画从duration的哪个时间开始执行;
 */
#pragma mark - Setup UI
- (void)setupUI{
    self.animationPath = [UIBezierPath bezierPath];
    [self.animationPath moveToPoint:(CGPoint){16,200}];
    [self.animationPath addCurveToPoint:(CGPoint){366,200} controlPoint1:(CGPoint){116,50} controlPoint2:(CGPoint){266,350}];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.strokeColor = UIColor.redColor.CGColor;
    layer.lineWidth = 3.0f;
    layer.path = self.animationPath.CGPath;
    [self.view.layer addSublayer:layer];
    
    CAShapeLayer *animLayer = [CAShapeLayer layer];
    [self.view.layer addSublayer:animLayer];
    self.animationLayer = animLayer;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){16,200,20,20}];
    animLayer.path = path.CGPath;
    animLayer.fillColor = UIColor.yellowColor.CGColor;
    
}

#pragma mark - IBAction
- (IBAction)timeOffsetSliderChanged:(UISlider *)sender {
    self.timeOffsetLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
}
- (IBAction)speedSliderChanged:(UISlider *)sender {
    self.speedLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
}

- (IBAction)playButtonClicked:(UIButton *)sender {
}

@end
