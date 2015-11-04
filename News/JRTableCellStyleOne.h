//
//  JRTableCellStyleOne.h
//  今日头条
//
//  Created by dc009 on 15/10/30.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import <UIKit/UIKit.h>

//界面
@interface JRTableCellStyleOne : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsSource;
@property (weak, nonatomic) IBOutlet UILabel *newsPubDate;
@property (weak, nonatomic) IBOutlet UILabel *newsLooks;
- (instancetype) initNewsCell;
+ (instancetype) NewsCell;
@end
