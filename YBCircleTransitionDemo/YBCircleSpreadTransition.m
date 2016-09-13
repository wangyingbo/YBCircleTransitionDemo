//
//  YBCircleSpreadTransition.m
//  YBCircleTransitionDemo
//
//  Created by 王迎博 on 16/9/13.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "YBCircleSpreadTransition.h"

@implementation YBCircleSpreadTransition
+ (instancetype)transitionWithTransitionType:(YBCircleSpreadTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}


- (instancetype)initWithTransitionType:(YBCircleSpreadTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case YBCircleSpreadTransitionTypePush:
            [self presentAnimation:transitionContext];
            break;
            
        case YBCircleSpreadTransitionTypePop:
            [self dismissAnimation:transitionContext];
            break;
    }
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view atIndex:0];
    //画两个圆路径
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.mapBtnFrame];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 0, 0)];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    //画两个圆路径
    //    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:fromVC.mapBtnFrame];
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 0, 0)];
    CGFloat x = MAX(100, containerView.frame.size.width - 100);
    CGFloat y = MAX(100, containerView.frame.size.height - 100);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.View的遮盖
    toVC.view.layer.mask = maskLayer;
    
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (_type) {
        case YBCircleSpreadTransitionTypePush:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
            UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
            toView.layer.mask = nil;
            UIViewController *vc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            vc.view.layer.mask = nil;
        }
            break;
        case YBCircleSpreadTransitionTypePop:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
            UIViewController *vc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            vc.view.layer.mask = nil;
        }
            break;
    }
}

@end
