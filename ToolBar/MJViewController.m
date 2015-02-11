//
//  MJViewController.m
//  ToolBar
//
//  Created by 朱正晶 on 15-2-11.
//  Copyright (c) 2015年 China. All rights reserved.
//

#import "MJViewController.h"

@interface MJViewController ()
- (IBAction)add:(UIBarButtonItem *)sender;
- (IBAction)remove:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trash;
@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (IBAction)add:(UIBarButtonItem *)sender
{
    UIView *lastObj;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    NSLog(@"view = %@", self.view.subviews);
    
    if (self.view.subviews.count == 3) {
        // UIToolbar + _UILayoutGuide + _UILayoutGuide
        lastObj = self.view.subviews[0];
    } else {
        lastObj = [self.view.subviews lastObject];
    }
    
    CGFloat posY = lastObj.frame.origin.y + lastObj.frame.size.height + 1;
    
    //CGRect tempF = view.frame;
    //tempF.origin.x = self.view.frame.size.width;
    //view.frame = tempF;
    view.frame = CGRectMake(self.view.frame.size.width, posY, self.view.frame.size.width, 50);
    view.alpha = 0;
    
    [UIView animateWithDuration:1.0 animations:^{
        view.frame = CGRectMake(0, posY, self.view.frame.size.width, 50);
        view.alpha = 1;
    } completion:^(BOOL finished) {
        NSLog(@"动画执行完毕");
    }];
    
    NSLog(@"函数执行完毕");
    [self.view addSubview:view];
    _trash.enabled = YES;
}

- (IBAction)remove:(UIBarButtonItem *)sender
{
    if (self.view.subviews.count == 3) {
        return;
    }
    UIView *lastObj = [self.view.subviews lastObject];
    [UIView animateWithDuration:1.0 animations:^{
        lastObj.frame = CGRectMake(self.view.frame.size.width, lastObj.frame.origin.y, self.view.frame.size.width, 50);
        lastObj.alpha = 0;
    } completion:^(BOOL finished) {
        NSLog(@"删除动画执行完毕");
        [lastObj removeFromSuperview];
        if (self.view.subviews.count == 3) {
            _trash.enabled = NO;
        }
    }];
}


@end
