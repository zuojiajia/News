//
//  JiaxingWebViewController.h
//  检验项目
//
//  Created by dc007 on 15/11/2.
//  Copyright (c) 2015年 dc007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiaxingWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webContent;
@property (strong, nonatomic) NSString *strTitle;
@property (strong, nonatomic) NSString *strUrl;
@end
