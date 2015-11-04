//
//  News.h
//  今日头条
//
//  Created by dc009 on 15/10/30.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic,strong) NSString *channelld;//新闻频道
@property (nonatomic,strong) NSString *title;//新闻标题
@property (nonatomic,strong) NSString *channelName;//新闻类型
@property (nonatomic,strong) NSString *pubDate;//日期
@property (nonatomic,strong) NSString *source;//出处
@property (nonatomic,strong) NSArray *imageurls;//附加图片
@property (nonatomic,strong) NSString *link;//网页链接

@end
