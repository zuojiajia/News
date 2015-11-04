//
//  JRBlogView.m
//  今日头条
//
//  Created by dc009 on 15/10/31.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import "JRBlogView.h"

@interface JRBlogView ()

@end

@implementation JRBlogView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:@"http://m.weibo.cn/u/2852517300"];
    
    [self.blogView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (IBAction)back:(UIButton *)sender {
    [_blogView goBack];
}

- (IBAction)forword:(UIButton *)sender {
    [_blogView goForward];
}

- (IBAction)refresh:(UIButton *)sender {
    [_blogView reload];
}

- (IBAction)first:(UIButton *)sender {
     NSURL *url = [NSURL URLWithString:@"http://m.weibo.cn/u/2852517300"];
    [self.blogView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.blogView];
}
@end
