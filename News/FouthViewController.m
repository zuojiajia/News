//
//  FouthViewController.m
//  检验项目
//
//  Created by dc007 on 15/10/29.
//  Copyright (c) 2015年 dc007. All rights reserved.
//

#import "FouthViewController.h"

@interface FouthViewController ()

@end


@implementation FouthViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scroView.delegate = self;
    self.scroView.contentSize = CGSizeMake(375*4, 510);

}
- (IBAction)selecctBtn:(UIButton *)sender {
    
    [self.scroView setContentOffset:CGPointMake(self.view.frame.size.width*(sender.tag-1), 0) animated:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.redLabel.frame = CGRectMake(94*(sender.tag-1)+19, 41, 60, 3);
    [UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int i = self.scroView.contentOffset.x/self.view.frame.size.width;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.redLabel.frame = CGRectMake(94*i+19, 41, 60, 3);
    [UIView commitAnimations];
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
