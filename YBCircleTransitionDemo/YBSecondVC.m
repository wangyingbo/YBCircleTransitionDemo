//
//  YBSecondVC.m
//  YBCircleTransitionDemo
//
//  Created by 王迎博 on 16/9/13.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "YBSecondVC.h"
#import "YBCircleSpreadTransition.h"


@interface YBSecondVC ()

@end

@implementation YBSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - UINavigation Delegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    if (fromVC == self) {
        return [YBCircleSpreadTransition transitionWithTransitionType:YBCircleSpreadTransitionTypePush];
    }
    if (toVC == self) {
        return [YBCircleSpreadTransition transitionWithTransitionType:YBCircleSpreadTransitionTypePop];
    }
    return nil;
}


@end
