//
//  JROneTVController.m
//  今日头条
//
//  Created by dc009 on 15/10/31.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import "JROneTVController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MBProgressHUD.h"

#import "JRTableCellStyleOne.h"
//#import "JRTableCellStyleTwo.h"
#import "News.h"
#import "JROneTVLook.h"

#define HTTP_URL @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news"
#define API_KEY @"8f4a2225e79da406a266890044e3461d"
@interface JROneTVController ()<UIScrollViewDelegate>
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) JROneTVLook *jrOneTVLook;
@property (nonatomic, strong) MBProgressHUD *HUD;
@end

@implementation JROneTVController
static const int width = 375;
int page = 1;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSArray *newsTypeArray = [NSArray arrayWithObjects:@"5572a109b3cdc86cf39001db",@"5572a109b3cdc86cf39001de",@"5572a109b3cdc86cf39001e3",@"5572a109b3cdc86cf39001e0",@"5572a109b3cdc86cf39001e6",@"5572a109b3cdc86cf39001e5",@"5572a10ab3cdc86cf39001ee",@"5572a108b3cdc86cf39001d4",nil];
    _manager = [AFHTTPRequestOperationManager manager];
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [_HUD setDimBackground:YES];
    [self.view addSubview:_HUD];
   
    //初始化tableView头部视图
    [self initTableViewHeaderView];
    
    //注册tableViewCell
    UINib *nib = [UINib nibWithNibName:@"JRTableCellStyleOne" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"styleOne"];
    
    //加载新闻内容数据
    [self loadNewsDtaWithChannelID:@"5572a109b3cdc86cf39001db" andPage:1];

    //下拉刷新页面
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 20, width, 30)];
    [self.refreshControl  addTarget:self action:@selector(downPullToRefreshPage) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    //上拉加载更多
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //加载更多数据方法
        [self loadNewsDtaWithChannelID:_channelID andPage:++page];   
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 加载数据部分
- (void) loadNewsDtaWithChannelID:(NSString *)channelId andPage:(NSInteger)page{
    _channelID = channelId;
    [_HUD show:YES];
    //组合参数
    NSDictionary *dict = @{@"channelId":channelId,@"page":@(page)};
    //NSLog(@"%@",channelId);
    //请求头
    [_manager.requestSerializer setValue:API_KEY forHTTPHeaderField:@"apikey"];
    
    [_manager GET:HTTP_URL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //获取数据
        NSDictionary *body = [responseObject valueForKey:@"showapi_res_body"];
        NSDictionary *pageBean = [body valueForKey:@"pagebean"];
        NSArray *list = [pageBean valueForKey:@"contentlist"];
        //将News对象存入数组
        _dataArray = [News objectArrayWithKeyValuesArray:list];
        if (!_dataArray) {
             _dataArray = [News objectArrayWithKeyValuesArray:list];
        }else{
            [_dataArray addObjectsFromArray:[News objectArrayWithKeyValuesArray:list]];
        }
        //关闭下拉刷新
        [self.refreshControl endRefreshing];
        //关闭上拉加载更多
        [self.tableView.footer endRefreshing];
        
        [self.tableView reloadData];
        [_HUD hide:YES afterDelay:0.5];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - Table view data source
#pragma mark Return the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark Return the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
#pragma  mark 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark 表视图显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JRTableCellStyleOne *cell = [tableView dequeueReusableCellWithIdentifier:@"styleOne" forIndexPath:indexPath];
    //拿到对象模型
    News *news = _dataArray[indexPath.row];
    //新闻附带图片
    NSArray *images = [news valueForKey:@"imageurls"];
    NSURL *imageUrl;
    if (images.count > 0) {
        NSDictionary *dict = images[0];
         imageUrl = [NSURL URLWithString:[dict valueForKey:@"url"]];
    }
    [cell.newsImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"listbg"]];
    //新闻发表日期
    cell.newsPubDate.text = news.pubDate;
    //新闻标题
    cell.newsTitle.text = news.title;
    //评论数
    int lookRandom = 500 + arc4random()%100;
    cell.newsLooks.text = [NSString stringWithFormat:@"%d",lookRandom];
    //新闻频道
   // NSLog(@"%@",news.channelName);
    cell.textLabel.textColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//该表格选中后没有颜色
    return cell;
}
#pragma mark tableView点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    News *news = _dataArray[indexPath.row];
    NSString *newsUrl = news.link;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:newsUrl forKey:@"newsUrl"];
    
    //拉线过去的
    //[self performSegueWithIdentifier:@"lookWeb" sender:self];
   
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (self.jrOneTVLook == nil) {
        self.jrOneTVLook = [sb instantiateViewControllerWithIdentifier:@"jrOne"];
    }
    //模态过去
    //模态跳转页面
    
    [self presentViewController:self.jrOneTVLook  animated:YES completion:^{
        NSLog(@"去查看详细信息");
    }];
    
    //导航过去
    //[self.navigationController pushViewController:[[JROneTVLook alloc] init] animated:YES];
}
#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float x = scrollView.contentOffset.x;
    int page = x/scrollView.frame.size.width;
    _pageControl.currentPage = page;
}
#pragma mark - refresh target
- (void)downPullToRefreshPage{
    //刷新数据
    [self loadNewsDtaWithChannelID:_channelID andPage:1];
}


#pragma mark tableView 头部视图
- (void)initTableViewHeaderView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, 180)];
    scrollView.contentSize = CGSizeMake(width*6, 180);//滚动范围的大小
    scrollView.pagingEnabled = YES;//控制控件是否整页翻动
    scrollView.alwaysBounceHorizontal = YES;//控制水平方向遇到边框是否反弹
    scrollView.alwaysBounceVertical = YES;//控制垂直方向遇到边框是否反弹
    scrollView.showsHorizontalScrollIndicator = NO;//控制是否显示水平方向的滚动条
    scrollView.showsVerticalScrollIndicator = NO;//控制是否显示垂直方向的滚动条
    scrollView.delegate = self;//给代理
    scrollView.bounces = YES;//控制控件遇到边框是否反弹
    
    self.tableView.tableHeaderView = scrollView;
    for (int i = 0; i < 6; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(375*i, 0, width, 180)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        [scrollView addSubview:imageView];
    }
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 180-20, width, 20)];
    _pageControl.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    _pageControl.numberOfPages = 6;
    _pageControl.enabled = NO;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [self.view addSubview:_pageControl];
}

@end
