//
//  OSSearchHistoryCell.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSSearchHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (nonatomic,copy) void(^recentSearchDelteCallBack)(void);

@end
