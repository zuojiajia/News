//
//  TableViewCell.h
//  检验项目
//
//  Created by dc007 on 15/11/3.
//  Copyright (c) 2015年 dc007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
