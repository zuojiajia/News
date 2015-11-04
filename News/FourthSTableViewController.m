//
//  FourthSTableViewController.m
//  News
//
//  Created by dc009 on 15/11/3.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import "FourthSTableViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "TableViewCell.h"
#import "NewsViewController.h"
#import "SocietyNews.h"

#define API_KEY @"7b4cbd154b51c15ccaf5bc5eec543fdb"
#define API_HTTP @"http://apis.baidu.com/txapi/world/world"

@interface FourthSTableViewController ()
{
    AFHTTPRequestOperationManager *AFManager;
    NSMutableArray *newsArray;
    SocietyNews *societyNews;
}

@property (nonatomic, strong) NewsViewController *newsViewController;


@end

@implementation FourthSTableViewController
static int page = 1;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    AFManager = [AFHTTPRequestOperationManager manager];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    [self loadNewsDataWithPage:1];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewsDataWithPage:++page];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadNewsDataWithPage:++page];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) loadNewsDataWithPage:(NSInteger)page{
    
    [AFManager.requestSerializer setValue:API_KEY forHTTPHeaderField:@"apikey"];
    
    NSDictionary *dict = @{
                           @"num":@5,
                           @"page":@(page)
                           };
    [AFManager GET:API_HTTP parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        NSMutableDictionary *dic= [NSMutableDictionary dictionaryWithCapacity:10];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:10];
        for (int i = 0; i < 4; i++) {
            dic = [responseObject valueForKey:[NSString stringWithFormat:@"%d",i]];
            [array addObject:dic];
        }
        if (!newsArray) {
            newsArray = [SocietyNews objectArrayWithKeyValuesArray:array];
        }else{
            [newsArray addObjectsFromArray:[SocietyNews objectArrayWithKeyValuesArray:array]];
        }
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return newsArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    TableViewCell *tabcell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    societyNews = newsArray[indexPath.row];
    [tabcell.imgView setImageWithURL:[NSURL URLWithString:societyNews.picUrl] placeholderImage:[UIImage imageNamed:@"icon-user"]];
    tabcell.time.text = societyNews.time;
    tabcell.title.text = societyNews.title;
    return tabcell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



#pragma mark 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[newsArray[indexPath.row] valueForKey:@"url"] forKey:@"Url"];
    [userDefaults synchronize];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (self.newsViewController == nil) {
        self.newsViewController = [storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    }
    self.newsViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: self.newsViewController animated:YES];
    
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
