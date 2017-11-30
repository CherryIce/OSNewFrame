//
//  OSDisplayListsCell.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSDisplayListsCell.h"

@implementation OSDisplayListsCell

- (void)setMsg:(NSString *)msg
{
    _msg = msg;
    CGSize size = [OSUtilityHelper fitSizeWithLabel:_msg size:CGSizeMake(kScreenWidth - 110, 2000) font:systemOfFont(13)];
    [_showMsgLab setFrame:CGRectMake(_showMsgLab.left, _showMsgLab.top, _showMsgLab.width, size.height)];
    _showMsgLab.text  = msg;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
