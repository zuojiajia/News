//
//  JROneTVController.h
//  今日头条
//
//  Created by dc009 on 15/10/31.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JROneTVController : UITableViewController
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,assign) int currentIndex;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *channelID;
@property (nonatomic, strong) NSMutableArray *imageUrls;
//根据分类和页码加载数据
- (void)loadNewsDtaWithChannelID:(NSString *)channelId andPage:(NSInteger)page;
@end
