//
//  JRTableCellStyleTwo.h
//  今日头条
//
//  Created by dc009 on 15/10/30.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRTableCellStyleTwo : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsTime;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage1;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage2;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage3;
@property (weak, nonatomic) IBOutlet UILabel *newsLooks;

- (instancetype) initImageNewsCell;
+ (instancetype) ImageNewsCell;

@end
