//
//  CAPSPageMenu.h
//
//
//  Created by Jin Sasaki on 2015/05/30.
//
//

#import <UIKit/UIKit.h>

@class CAPSPageMenu;

#pragma mark - Delegate functions
@protocol CAPSPageMenuDelegate <NSObject>

@optional
- (void)willMoveToPage:(UIViewController *)controller index:(NSInteger)index;
- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index;
@end

@interface MenuItemView : UIView

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIView *menuItemSeparator;

- (void)setUpMenuItemView:(CGFloat)menuItemWidth
     menuScrollViewHeight:(CGFloat)menuScrollViewHeight
          indicatorHeight:(CGFloat)indicatorHeight
separatorPercentageHeight:(CGFloat)separatorPercentageHeight
           separatorWidth:(CGFloat)separatorWidth
      separatorRoundEdges:(BOOL)separatorRoundEdges
   menuItemSeparatorColor:(UIColor *)menuItemSeparatorColor;

- (void)setTitleText:(NSString *)text;

@end
/// 类似于网易选项卡的控件
@interface CAPSPageMenu : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *menuScrollView;
@property (nonatomic, strong) UIScrollView *controllerScrollView;

@property (nonatomic, readonly) NSArray *controllerArray;
@property (nonatomic, readonly) NSArray *menuItems;
@property (nonatomic, readonly) NSArray *menuItemWidths;

@property (nonatomic) NSInteger currentPageIndex;
@property (nonatomic) NSInteger lastPageIndex;
/**
 *  item 宽度根据文字定宽度时 底部滑动条相对于item向前偏移的量
 */
@property (nonatomic) CGFloat menuItemSelectionIndicatorX;
/**
 *  item 宽度根据文字定宽度时 首尾item与item间距的差值，item间距 - 首尾item想要设置的间距
 */
@property (nonatomic) CGFloat menuItemHeadFootDifference;
/**
 *  @author 钟远科, 16-03-25 14:03:42
 *
 *  menu 的frame 的Y
 */
@property (nonatomic) CGFloat menuOffsetY;
@property (nonatomic) CGFloat menuHeight;
@property (nonatomic) CGFloat menuMargin;
@property (nonatomic) CGFloat menuItemWidth;
@property (nonatomic) CGFloat selectionIndicatorHeight;
@property (nonatomic) NSInteger scrollAnimationDurationOnMenuItemTap;

@property (nonatomic) UIColor *selectionIndicatorColor;
@property (nonatomic) UIColor *selectedMenuItemLabelColor;
@property (nonatomic) UIColor *unselectedMenuItemLabelColor;
@property (nonatomic) UIColor *scrollMenuBackgroundColor;
@property (nonatomic) UIColor *viewBackgroundColor;
@property (nonatomic) UIColor *bottomMenuHairlineColor;
@property (nonatomic) UIColor *menuItemSeparatorColor;

@property (nonatomic) UIFont *menuItemFont;
@property (nonatomic) CGFloat menuItemSeparatorPercentageHeight;
@property (nonatomic) CGFloat menuItemSeparatorWidth;
@property (nonatomic) BOOL menuItemSeparatorRoundEdges;

@property (nonatomic) BOOL addBottomMenuHairline;
@property (nonatomic) BOOL menuItemWidthBasedOnTitleTextWidth;
@property (nonatomic) BOOL useMenuLikeSegmentedControl;
@property (nonatomic) BOOL centerMenuItems;
@property (nonatomic) BOOL enableHorizontalBounce;
@property (nonatomic) BOOL hideTopMenuBar;

@property (nonatomic, weak) id<CAPSPageMenuDelegate> delegate;

@property (nonatomic) CGFloat selectionPercentageMargin;
@property (nonatomic) BOOL controllerScrollViewScrollEnabled;

- (void)addPageAtIndex:(NSInteger)index;

/**
 Move to page at index

 :param: index Index of the page to move to
 */
- (void)moveToPage:(NSInteger)index;

/*!
 *  @author 钟远科, 16-04-15 11:04:00
 *
 *  @brief Move to page at index
 *
 *  @param index      跳转页面的索引
 *  @param animate    是否显示动画 （默认不执行动画）
 *  @param completion 跳转完成回调
 *
 *  @since <#2.0.3#>
 */
- (void)moveToPage:(NSInteger)index animate:(BOOL)animate completion:(void (^)())completion;

- (instancetype)initWithViewControllers:(NSArray *)viewControllers frame:(CGRect)frame options:(NSDictionary *)options;

extern NSString *const CAPSPageMenuOptionSelectionIndicatorHeight;
extern NSString *const CAPSPageMenuOptionMenuItemSeparatorWidth;
extern NSString *const CAPSPageMenuOptionScrollMenuBackgroundColor;
extern NSString *const CAPSPageMenuOptionViewBackgroundColor;
extern NSString *const CAPSPageMenuOptionBottomMenuHairlineColor;
extern NSString *const CAPSPageMenuOptionSelectionIndicatorColor;
extern NSString *const CAPSPageMenuOptionMenuItemSeparatorColor;
extern NSString *const CAPSPageMenuOptionMenuMargin;
extern NSString *const CAPSPageMenuOptionMenuHeight;
extern NSString *const CAPSPageMenuOptionSelectedMenuItemLabelColor;
extern NSString *const CAPSPageMenuOptionUnselectedMenuItemLabelColor;
extern NSString *const CAPSPageMenuOptionUseMenuLikeSegmentedControl;
extern NSString *const CAPSPageMenuOptionMenuItemSeparatorRoundEdges;
extern NSString *const CAPSPageMenuOptionMenuItemFont;
extern NSString *const CAPSPageMenuOptionMenuItemSeparatorPercentageHeight;
extern NSString *const CAPSPageMenuOptionMenuItemWidth;
extern NSString *const CAPSPageMenuOptionEnableHorizontalBounce;
extern NSString *const CAPSPageMenuOptionAddBottomMenuHairline;
extern NSString *const CAPSPageMenuOptionMenuItemWidthBasedOnTitleTextWidth;
extern NSString *const CAPSPageMenuOptionScrollAnimationDurationOnMenuItemTap;
extern NSString *const CAPSPageMenuOptionCenterMenuItems;
extern NSString *const CAPSPageMenuOptionHideTopMenuBar;
extern NSString *const CAPSPageMenuOptionSelectionPercentageMargin;
extern NSString *const CAPSPageMenuOptionControllerScrollViewScrollEnabled;
extern NSString *const CAPSPageMenuOptionControllerMenuOffsetY;
extern NSString *const CAPSPageMenuOptionControllerMenuItemSelectionIndicatorX;
extern NSString *const CAPSPageMenuOptionControllerMenuItemHeadFootDifference;
@end
