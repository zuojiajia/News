//
//  JRFouthView.m
//  News
//
//  Created by dc009 on 15/11/3.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import "JRFouthView.h"
#import "SayGift_3DBanner_View.h"
@interface JRFouthView ()<ClickImgDelegate>
{
    UIImageView *_imageView;
    int _currentIndex;
}
@end

@implementation JRFouthView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SayGift_3DBanner_View *bannerView = [[SayGift_3DBanner_View alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 180)];
    bannerView.delegate = self;
    [bannerView show3DBannerView];
    [self.view addSubview:bannerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 3DBanner
#pragma mark - sayGift_3DBanner_View delegate
-(void)ClickImg:(int)index{
    NSLog(@"点击了第%d张",index);
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
