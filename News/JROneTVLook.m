//
//  JROneTVLook.m
//  News
//
//  Created by dc009 on 15/11/3.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import "JROneTVLook.h"
#import "News.h"
#import "JROneTotal.h"
@interface JROneTVLook ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)back:(UIBarButtonItem *)sender;

@end

@implementation JROneTVLook

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:[defaults valueForKey:@"newsUrl"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request ];
    //[_webView reload];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //滑动手势操作
    UIPanGestureRecognizer *panGenture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)];
    [self.view addGestureRecognizer:panGenture];
}
- (void)pan{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回上一页");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 返回按钮
- (IBAction)back:(UIBarButtonItem *)sender {
    CATransition *transition = [CATransition animation];
    transition.duration = 2.0f;
    transition.type = @"rippleEffect";
    transition.subtype = kCATransitionFromRight;
    [self.view.layer addAnimation:transition forKey:@"viewtransition"];

    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回上一页");
    }];
}
@end
