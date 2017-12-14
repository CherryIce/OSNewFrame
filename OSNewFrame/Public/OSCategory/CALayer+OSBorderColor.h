//
//  CALayer+OSBorderColor.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (OSBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color;

// 动画类型
typedef NS_ENUM(NSInteger, TransitionAnimType){
    
    TransitionAnimTypeRippleEffect=0,
    
    TransitionAnimTypeSuckEffect,
    
    TransitionAnimTypePageCurl,
    
    TransitionAnimTypeOglFlip,
    
    TransitionAnimTypeCube,
    
    TransitionAnimTypeReveal,
    
    TransitionAnimTypePageUnCurl,
    
    TransitionAnimTypeRamdom,
};
// 方向
typedef NS_ENUM(NSInteger, TransitionSubType){
    
    TransitionSubtypesFromTop=0,
    
    TransitionSubtypesFromLeft,
    
    TransitionSubtypesFromBotoom,
    
    TransitionSubtypesFromRight,
    
    TransitionSubtypesFromRamdom,
};


// 动画曲线
typedef NS_ENUM(NSInteger, TransitionCurve) {
    
    TransitionCurveDefault,
    
    TransitionCurveEaseIn,
    
    TransitionCurveEaseOut,
    
    TransitionCurveEaseInEaseOut,
    
    TransitionCurveLinear,
    
    TransitionCurveRamdom,
};

/**
 *  转场动画
 *
 *  @param animType 转场动画类型
 *  @param subType  转动动画方向
 *  @param curve    转动动画曲线
 *  @param duration 转动动画时长
 *
 *  @return 转场动画实例
 */
- (CATransition *)transitionWithAnimType:(TransitionAnimType)animType subType:(TransitionSubType)subType curve:(TransitionCurve)curve duration:(CGFloat)duration;

/**
 *  把某个sublayer移动到当前所有sublayers的最后面
 *  @param  sublayer    要被移动的layer
 *  @warning 要被移动的sublayer必须已经添加到当前layer上
 */
- (void)FS_sendSublayerToBack:(CALayer *)sublayer;

/**
 *  把某个sublayer移动到当前所有sublayers的最前面
 *  @param  sublayer    要被移动的layer
 *  @warning 要被移动的sublayer必须已经添加到当前layer上
 */
- (void)FS_bringSublayerToFront:(CALayer *)sublayer;

/**
 * 移除 CALayer（包括 CAShapeLayer 和 CAGradientLayer）所有支持动画的属性的默认动画，方便需要一个不带动画的 layer 时使用。
 */
- (void)FS_removeDefaultAnimations;

@end
