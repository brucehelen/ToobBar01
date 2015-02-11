//
//  MJViewController.m
//  ToolBar
//
//  Created by 朱正晶 on 15-2-11.
//  Copyright (c) 2015年 China. All rights reserved.
//

#import "MJViewController.h"

#define kDuration    0.5
#define kRowH        50


@interface MJViewController ()
- (IBAction)add:(UIBarButtonItem *)sender;
- (IBAction)remove:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trash;
@property NSArray *name;
@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _name = @[@"西门庆", @"东门庆", @"南门庆", @"北门庆", @"中门庆"];
}


- (IBAction)add:(UIBarButtonItem *)sender
{
    UIView *lastObj;
    
    UIView *view = [self createView];
    NSLog(@"view = %@", self.view.subviews);
    
    if (self.view.subviews.count == 3) {
        // UIToolbar + _UILayoutGuide + _UILayoutGuide
        lastObj = self.view.subviews[0];
    } else {
        lastObj = [self.view.subviews lastObject];
    }

    CGFloat posY = lastObj.frame.origin.y + lastObj.frame.size.height + 1;

    view.frame = CGRectMake(self.view.frame.size.width, posY, self.view.frame.size.width, kRowH);
    view.alpha = 0;
    
    [UIView animateWithDuration:kDuration animations:^{
        view.frame = CGRectMake(0, posY, self.view.frame.size.width, kRowH);
        view.alpha = 1;
    } completion:^(BOOL finished) {
        NSLog(@"动画执行完毕");
    }];

    [self.view addSubview:view];
    _trash.enabled = YES;
}


- (UIView*)createView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    
    // 创建标签
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, self.view.frame.size.width, kRowH);
    label.backgroundColor = [UIColor clearColor];
    NSString *name = _name[arc4random_uniform(_name.count)];
    label.text = name;
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    
    // 创建按钮
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(0, 0, kRowH, kRowH);
    int imageIndex = arc4random_uniform(9);
    UIImage *image = [UIImage imageNamed: [NSString stringWithFormat:@"01%d.png", imageIndex]];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [view addSubview:button];
    
    
    return view;
}


- (IBAction)remove:(UIBarButtonItem *)sender
{
    if (self.view.subviews.count == 3) {
        return;
    }
    UIView *lastObj = [self.view.subviews lastObject];
    [UIView animateWithDuration:kDuration animations:^{
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
