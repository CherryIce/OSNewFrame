//
//  OSDisplayListsCell.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSDisplayListsCell : UITableViewCell

/** 传模型或者字典就可以了 */
@property (nonatomic,copy) NSString * msg;

@property (weak, nonatomic) IBOutlet UILabel *showMsgLab;

@end
