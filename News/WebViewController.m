//
//  WebViewController.m
//  检验项目
//
//  Created by dc007 on 15/11/2.
//  Copyright (c) 2015年 dc007. All rights reserved.
//

#import "WebViewController.h"
#import "JiaxingWebViewController.h"
@interface WebViewController ()
{
    NSArray *webTitle;
    NSArray *webUrl;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    webUrl = @[@"http://jx.wenming.cn/",
               @"http://www.zjwmw.com/",
               @"http://www.cnjxol.com/",
               @"http://www.zjol.com.cn/",
               @"https://www.taobao.com/",
               @"http://www.suning.com/",];
    
    webTitle = @[@"嘉兴文明网联盟",
                 @"浙江文明网",
                 @"嘉兴在线",
                 @"浙江在线",
                 @"淘宝网",
                 @"苏宁易购",];
}
- (IBAction)selectBtn:(UIButton *)sender {
    [self performSegueWithIdentifier:@"jumpNext" sender:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"jumpNext"]) {
        NSString *webT= [webTitle objectAtIndex:((UIButton *)sender).tag - 1];
        NSString *webU = [webUrl objectAtIndex:((UIButton *)sender).tag - 1];
        JiaxingWebViewController *webView = segue.destinationViewController;
        webView.hidesBottomBarWhenPushed = YES;
        webView.strTitle = webT;
        webView.strUrl = webU;
    }
    
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
