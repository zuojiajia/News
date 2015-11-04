//
//  ViewController.m
//  News
//
//  Created by dc009 on 15/11/3.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import "ViewController.h"
#import "AMTumblrHud.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()
{
    NSTimer *_timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(jump) userInfo:nil repeats:NO];
    
}
int timeCount = 5;
- (void)jump{
   // self.view.backgroundColor = UIColorFromRGB(0x34465C);
    timeCount--;
    AMTumblrHud *tumblrHUD = [[AMTumblrHud alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5),
    (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20)];
    //tumblrHUD.hudColor = UIColorFromRGB(0xF1F2F3);//[UIColor magentaColor];
    [self.view addSubview:tumblrHUD];
    [tumblrHUD showAnimated:YES];
    sleep(1);
    [tumblrHUD hide];
    if (timeCount == 0) {
        [_timer invalidate];
        _timer = nil;
    }
    
    [self performSegueWithIdentifier:@"viewController" sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_timer invalidate];
    _timer = nil;
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
