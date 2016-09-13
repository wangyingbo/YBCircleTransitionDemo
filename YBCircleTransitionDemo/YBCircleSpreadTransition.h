//
//  YBCircleSpreadTransition.h
//  YBCircleTransitionDemo
//
//  Created by 王迎博 on 16/9/13.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YBCircleSpreadTransitionType)
{
    YBCircleSpreadTransitionTypePush = 0,
    YBCircleSpreadTransitionTypePop
};

@interface YBCircleSpreadTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) YBCircleSpreadTransitionType type;
+ (instancetype)transitionWithTransitionType:(YBCircleSpreadTransitionType)type;
- (instancetype)initWithTransitionType:(YBCircleSpreadTransitionType)type;

@end
