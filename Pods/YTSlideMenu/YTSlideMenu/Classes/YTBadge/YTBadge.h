//
//  YTBadge.h
//  YTSlideMenuDemo
//
//  Created by linkunzhu on 16/11/22.
//  Copyright © 2016年 linkunzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author linkunzhu, 16-11-24 10:11:59
 *
 *  本类用不到这个枚举，使用方可以用它来组织各种情形下该如何调用各种show方法
 */
typedef NS_ENUM(NSUInteger, YTBadgeType) {
    YTBadgeTypeNone = 1,
    YTBadgeTypeDot,
    YTBadgeTypeText,
    YTBadgeTypeMore,
    YTBadgeTypeCustom
};

/**
 *  @author linkunzhu, 16-11-24 09:11:09
 *
    基本使用步骤：
    （1）先用initWithParentView：初始化。
    （2）在通过属性做各种定制。
    （3）再调用各种show方法展示。如果已经初始化过了，或者已经设置过了，就直接随意组合，随意次数地调用各种show方法即可。
 
 
 *  支持的类型：
    1.showWithNone，不显示badge。
    2.showWithDot，显示远点badge。
    3.showWithMore，显示更多...的badge。
    4.showWithText:，显示数字，文字的badge。
    5.showWithCustomImage，显示自定义图片的badge。
 
    一些比较典型的配置：
    1. 调节位置。默认badge的origin位置为parentView的右上角，通过设置adjustPosition的值，改变相对位置。可以利用badgeSize来做调节参考。先运行一次，得到badgeSize的值，再用这个值做计算，不要直接引用badgeSize这个变量放到adjustPosition的计算公式里面。
    2. 调节大小。
    2.1 圆点类型：通过dotWidth改变大小。
    2.2 more类型。
    2.2.1 通过moreSize改变大小。
    2.2.2 通过textFont改变里面...的大小。
    2.3 文字类型。
    2.3.1 文字类型的badge的默认size是通过其内容和textFont结合起来计算的文字块的size。所以调节textFont可以调节其大小。
    2.3.2 字体的大小通过textFont来调节。
    2.3.3 如果只通过textFont调节的size不满意，那么可以用textAdjustSize对badge的size进行x，y轴方向的增、减操作。这也是调节文字边距的方法。
    2.4 自定义图片类型：图片多大badge就多大。
    3. 调节文字边距。
    3.1 more类型。设置完textFont后，观察边距是否符合需求，如果不符合再设置moreAdjustSize调整。
    3.2 文字类型。
    3.2.1 设置完textFont后，观察边距是否符合需求，如果不符合再设置textAdjustSize调整。
    3.2.2 如果想要上下左右边距不同，通过设置textInsets来调整。
    4. 调节文字类型何时是圆形何时是其他比如椭圆形。步骤：
        （1）首先，设置一个数字（正整数），小于它时就是圆形，比如100。
        （2）其次，观察处在100以内的数，是否都能在园内正常显示，比如有时候11可以正常显示，99却显示不全。
        （3）再次，如果有显示不全的，就说明要增加宽度，通过textAdjustSize给x方向的size添加一个正数值。知道能让所有100以内的正整数都正常显示。
        （4）最后，由于为了保证第（3）点，而会导致文字上，下边距的增大，可能我们感觉不美观，这时调节textAdjustSize的y方向的size，添加一个负数值，来裁剪掉上下边距多余的控件（只针对不是圆形显示的时候）。这样就能既满足圆形时的对文字的完整显示，又能在非圆形时保持叫好看的上下文字边距。当然这样做的话，圆形时的高度是会大于非圆形时的高度的。
        （5）如果（4）的做法也不能满足需求，那就针对圆形时用textCircleAdjustSize调节，非圆形时用textAdjustSize调节，这样既能满足两种样式边距的统一，又能满足两种样式badge的高度的统一。
    5. 调节圆角。设置圆角的圆的半径跟badge的高度的比例数。通常是0.5。
    6. 调节颜色。badgeColor调节badge颜色，textColor调节文字颜色。
 
 */

@interface YTBadge : NSObject
/*
 默认样式满足不了使用时，可以通过以下属性进一步定制
 */
@property (nonatomic, readonly) CGSize badgeSize;
@property (nonatomic, assign) CGPoint adjustPosition;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *badgeColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) UIEdgeInsets textInsets;
@property (nonatomic, assign) CGSize textAdjustSize;
@property (nonatomic, assign) CGSize textCircleAdjustSize;
@property (nonatomic, assign) NSUInteger textCircleUnderNum;
@property (nonatomic, assign) CGFloat textCornerRadius;
@property (nonatomic, assign) CGFloat dotWidth;
@property (nonatomic, assign) CGSize moreAdjustSize;
@property (nonatomic, assign) CGFloat moreCornerRadius;

/*
 初始化
 */
- (instancetype)initWithParentView:(UIView *)view;

/*
 初始化过后
 */
- (void)showWithNone;
- (void)showWithDot;
- (void)showWithMore;
//如果text为nil或空字符串，效果相当于showWithNone
- (void)showWithText:(NSString *)text;
//如果view为nil，效果相当于showWithNone
- (void)showWithCustomImage:(UIImage *)image;

@end
