//
//  OSSearchNavBar.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSSearchNavBar : UIView<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UITextField *searchTf;

@property (nonatomic,copy) void(^OSSearchCancelCallBack)(void);

@property (nonatomic,copy) void(^OSSearchSelectCityCallBack)(void);

@property (nonatomic,copy) void(^searchKeyWordCall)(NSString * keyword);

@end
