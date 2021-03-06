//
//  ViewController.m
//  YBCircleTransitionDemo
//
//  Created by 王迎博 on 16/9/13.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "ViewController.h"
#import "YBCircleSpreadTransition.h"
#import "YBSecondVC.h"


@interface ViewController ()<UINavigationControllerDelegate>

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (IBAction)click:(UIButton *)sender
{
    YBSecondVC *vc = [[YBSecondVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - UINavigation Delegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    NSLog(@"...........测试哈哈哈");
    
    if (fromVC == self) {
        return [YBCircleSpreadTransition transitionWithTransitionType:YBCircleSpreadTransitionTypePush];
    }
    
    if (toVC == self) {
        return [YBCircleSpreadTransition transitionWithTransitionType:YBCircleSpreadTransitionTypePop];
    }
    return nil;
}



@end
