//
//  JRTableCellStyleTwo.m
//  今日头条
//
//  Created by dc009 on 15/10/30.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import "JRTableCellStyleTwo.h"

@implementation JRTableCellStyleTwo

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initImageNewsCell{
    return [[NSBundle mainBundle]loadNibNamed:@"JRTableCellStyleTwo" owner:nil options:nil][0];
}
+(instancetype)ImageNewsCell{
    return [[JRTableCellStyleTwo alloc] initImageNewsCell];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
