//
//  JRTableCellStyleOne.m
//  今日头条
//
//  Created by dc009 on 15/10/30.
//  Copyright (c) 2015年 dc009. All rights reserved.
//

#import "JRTableCellStyleOne.h"

@implementation JRTableCellStyleOne

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initNewsCell{
    return [[NSBundle mainBundle] loadNibNamed:@"JRTableCellStyleOne" owner:nil options:nil][0];
}
+(instancetype)NewsCell{
    return [[JRTableCellStyleOne alloc] initNewsCell];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
