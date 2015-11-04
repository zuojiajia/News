//
//  JROneTotal.m
//  今日头条
//
//  Created by dc009 on 15/10/29.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import "JROneTotal.h"
#import "JROneTVController.h"

@interface JROneTotal ()
{
    JROneTVController *index1;
    JROneTVController *index2;
    JROneTVController *index3;
    JROneTVController *index4;
    JROneTVController *index5;
    
    NSArray *newsTypeArray;
    
    int currentPage;
}
@end
static const int width = 375;
@implementation JROneTotal

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    newsTypeArray = [NSArray arrayWithObjects:@"5572a109b3cdc86cf39001db",@"5572a109b3cdc86cf39001de",@"5572a109b3cdc86cf39001e3",@"5572a109b3cdc86cf39001e0",@"5572a109b3cdc86cf39001e6",@"5572a109b3cdc86cf39001e5",@"5572a10ab3cdc86cf39001ee",@"5572a108b3cdc86cf39001d4",nil];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.btnScrollView setContentSize:CGSizeMake(380, 38)];
    [self.btnScrollView setTag:9999];
    [self.contentScrollView setContentSize:CGSizeMake(width*5, 548)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0) {
        //取消scroll的自动留白
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    index1 = [self loadJROneTVController:index1 andView:self.view1];
    index2 = [self loadJROneTVController:index2 andView:self.view2];
    index3 = [self loadJROneTVController:index3 andView:self.view3];
    index4 = [self loadJROneTVController:index4 andView:self.view4];
    index5 = [self loadJROneTVController:index5 andView:self.view5];
    
    _labelBg.layer.cornerRadius = _labelBg.frame.size.height/2;
    _labelBg.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

int tag = 0;
#pragma mark 创建JROneTVController视图
- (JROneTVController *)loadJROneTVController:(JROneTVController *)JRView andView:(UIView *)view{
    JRView = [self.storyboard instantiateViewControllerWithIdentifier:@"tableView"];
    JRView.view.frame = view.bounds;
    JRView.view.tag = 10+tag++;
    [self addChildViewController:JRView];
    [view addSubview:JRView.view];
    return JRView;

}

#pragma mark  点击按钮切换下面的视图
- (IBAction)btnTitleAction:(UIButton *)sender{
    //设置按钮的状态为不可选中的状态
    [self.contentScrollView setContentOffset:CGPointMake(self.contentScrollView.frame.size.width * (sender.tag-1), 0) animated:YES];
    currentPage = (int)sender.tag - 1;
    //刷新页码数据
    if (currentPage == 1) {
        [index1 loadNewsDtaWithChannelID:newsTypeArray[currentPage] andPage:1];
    }else if (currentPage == 2) {
        [index2 loadNewsDtaWithChannelID:newsTypeArray[currentPage] andPage:1];
    }else if (currentPage == 3) {
        [index3 loadNewsDtaWithChannelID:newsTypeArray[currentPage] andPage:1];
    }else if (currentPage == 4) {
        [index4 loadNewsDtaWithChannelID:newsTypeArray[currentPage] andPage:1];
    }else {
        [index5 loadNewsDtaWithChannelID:newsTypeArray[currentPage] andPage:1];
    }
}
#pragma mark - scrollView delegate
#pragma mark 当scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //改变背景颜色
    CGRect rect = self.labelBg.frame;
    rect.origin.x = 70*currentPage + 24;
    self.labelBg.frame = rect;
    
}

#pragma mark 滑动scrollView视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

#pragma mark 滑动scrollView视图，并且手指离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用，该方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0)
{
    
    float width = self.contentScrollView.frame.size.width;
    float x = targetContentOffset->x;
   // NSLog(@"页码= %d,%@",currentPage,NSStringFromCGPoint(*targetContentOffset));
    currentPage = x/width;
    if(scrollView.tag == 9999){
        if(currentPage < 1){
            [self.btnScrollView setContentOffset:CGPointMake(70*currentPage, 0) animated:YES];
        }
    }
    //刷新页码数据
    if (currentPage == 0) {
        [index1 loadNewsDtaWithChannelID:newsTypeArray[currentPage] andPage:1];
    }else if (currentPage == 1) {
        [index2 loadNewsDtaWithChannelID:newsTypeArray[currentPage] andPage:1];
    }else if (currentPage == 2) {
        [index3 loadNewsDtaWithChannelID:newsTypeArray[currentPage] andPage:1];
    }else if (currentPage == 3) {
        [index4 loadNewsDtaWithChannelID:newsTypeArray[currentPage] andPage:1];
    }else {
        [index5 loadNewsDtaWithChannelID:newsTypeArray[currentPage] andPage:1];
    }
    
}

@end
