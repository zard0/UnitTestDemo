//
//  YTSlideMenu.m
//  YTSlideMenuDemo
//
//  Created by linkunzhu on 16/11/21.
//  Copyright © 2016年 linkunzhu. All rights reserved.
//

#import "YTSlideMenu.h"
#import "CAPSPageMenu.h"
#import "YTBadge.h"
#import "YTMarkView.h"

/// 当前设备的屏幕宽度
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
static NSString *MenuItemViewTitleLabelTextColorKeyPath = @"titleLabel.textColor";

@interface YTSlideMenu()<CAPSPageMenuDelegate>

@property (nonatomic, strong) CAPSPageMenu *pageMenuController;
@property (nonatomic, strong) NSMutableArray *badgePanelViews;
@property (nonatomic, strong) NSMutableArray *badgeViews;
@property (nonatomic, strong) NSMutableArray *selectionIndicators;
@property (nonatomic, strong) NSMutableArray *itemFrames;
@property (nonatomic, strong) NSMutableArray *titleFrames;
@property (nonatomic, copy) slideBlock willMoveBlock;
@property (nonatomic, copy) slideBlock didMoveBlock;

@end

@implementation YTSlideMenu

- (void)dealloc{
    for (MenuItemView *view in self.pageMenuController.menuItems) {
        [view removeObserver:self forKeyPath:MenuItemViewTitleLabelTextColorKeyPath];
    }
}

#pragma mark - Public Initialization

- (instancetype)initWithControllers:(NSArray *)controllers frame:(CGRect)frame{
    if (self = [super init]) {
        self.controllers = controllers;
        self.badgePanelViews = [NSMutableArray array];
        self.badgeViews = [NSMutableArray array];
        self.selectionIndicators = [NSMutableArray array];
        self.itemFrames = [NSMutableArray array];
        self.titleFrames = [NSMutableArray array];
        if ([self.controllers count] > 0) {
            self.pageMenuController = [self pageMenuWithControllers:self.controllers frame:frame delegate:self];
            self.currentPageIndex = self.pageMenuController.currentPageIndex;
            [self setupBadgePanelViews];
            [self setupBadgeViews];
            [self setupSelectionIndicatorViews];
            [self observeItemTitleColorChange];
        }
    }
    return self;
}

#pragma mark - Properties

- (void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    NSInteger itemCount = [self.pageMenuController.menuItems count];
    for (int i = 0; i < itemCount; i++) {
        MenuItemView *view = self.pageMenuController.menuItems[i];
        view.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
    }
}

#pragma mark - Show

- (void)showInView:(UIView *)view inController:(UIViewController *)controller{
    if (!view || !self.pageMenuController) {
        return;
    }
    if (controller) {
        [controller addChildViewController:self.pageMenuController];
    }
    [self showInView:view];
}

- (void)showInView:(UIView *)view{
    if (!view || !self.pageMenuController) {
        return;
    }
    [view addSubview:self.pageMenuController.view];
    
}

#pragma mark - Show Badge

- (void)showNoneBadgeForItem:(NSInteger)index{
    [self showBadgeType:YTBadgeTypeNone text:nil image:nil atIndex:index];
}

- (void)showDotBadgeForItem:(NSInteger)index{
    [self showBadgeType:YTBadgeTypeDot text:nil image:nil atIndex:index];
}

- (void)showMoreBadgeForItem:(NSInteger)index{
    [self showBadgeType:YTBadgeTypeMore text:nil image:nil atIndex:index];
}

- (void)showBadgeText:(NSString *)text forItem:(NSInteger)index{
    [self showBadgeType:YTBadgeTypeText text:text image:nil atIndex:index];
}

- (void)showCustomBadgeImage:(UIImage *)image forItem:(NSInteger)index{
    [self showBadgeType:YTBadgeTypeCustom text:nil image:image atIndex:index];
}

- (YTBadge *)badgeAtIndex:(NSInteger)index{
    if (index < 0 || index >= [self.badgeViews count]) {
        return nil;
    }
    YTBadge *badge = self.badgeViews[index];
    return badge;
}

- (void)showBadgeType:(YTBadgeType)type text:(NSString *)text image:(UIImage *)image atIndex:(NSInteger)index{
    YTBadge *badge = [self badgeAtIndex:index];
    if (!badge) {
        return;
    }
    switch (type) {
        case YTBadgeTypeNone:{
            [badge showWithNone];
        }
            break;
        case YTBadgeTypeDot:{
            badge.adjustPosition = CGPointMake(0, 10 / 2.0);
            [badge showWithDot];
        }
            break;
        case YTBadgeTypeMore:{
            badge.adjustPosition = CGPointMake(0, 14 / 2.0);
            [badge showWithMore];
        }
            break;
        case YTBadgeTypeText:{
            badge.adjustPosition = CGPointMake(0, 18 / 2.0);
            [badge showWithText:text];
        }
            break;
        case YTBadgeTypeCustom:{
            badge.adjustPosition = CGPointMake(0, image.size.height / 2.0);
            [badge showWithCustomImage:image];
        }
            break;
        default:
            break;
    }
    // show之后，才能知道badgeSize真实大小
    //NSLog(@"Type:%@ BadgeSize: (%@, %@)",@(type),@(badge.badgeSize.width),@(badge.badgeSize.height));
}


#pragma mark - Slide Event Handle

- (void)willMoveToPage:(slideBlock)block{
    self.willMoveBlock = block;
}

- (void)didMoveToPage:(slideBlock)block{
    self.didMoveBlock = block;
}

- (void)moveToPageAtIndex:(NSInteger)index{
    //index = 0不会自己走will方法。index != 0就会走，这应该是CAPSPageMenu的一个bug
    if (index == 0) {
        [self.pageMenuController.delegate willMoveToPage:nil index:index];
    }
    //@weakify(self);
    [self.pageMenuController moveToPage:index animate:YES completion:^{
        //@strongify(self);
        //did方法要在block里面手动设置才会走
        [self.pageMenuController.delegate didMoveToPage:[self controllers][index] index:index];
    }];
}

#pragma mark - Private Initialization


/**
 *  菜单初始化
 */
- (CAPSPageMenu *)pageMenuWithControllers:(NSArray *)controllers frame:(CGRect)frame delegate:(id)delegate{
    // 菜单栏控制器
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor whiteColor],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor clearColor],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:16.0],
                                 CAPSPageMenuOptionMenuHeight: @40.0,
                                 CAPSPageMenuOptionMenuItemWidth: @52.0,
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor: [UIColor blackColor],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor: [UIColor redColor],
                                 CAPSPageMenuOptionSelectionIndicatorHeight: @0.0,
                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor redColor],
                                 //CAPSPageMenuOptionSelectionPercentageMargin: @(percentWidth),
                                 CAPSPageMenuOptionMenuItemSeparatorWidth: @0.0,
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor clearColor],
                                 CAPSPageMenuOptionEnableHorizontalBounce: @NO,
                                 CAPSPageMenuOptionControllerScrollViewScrollEnabled: @YES,
                                 CAPSPageMenuOptionScrollAnimationDurationOnMenuItemTap: @300.0,
                                 CAPSPageMenuOptionHideTopMenuBar: @NO,
                                 CAPSPageMenuOptionControllerMenuOffsetY: @0,
                                 };
    CAPSPageMenu *pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:self.controllers frame:frame options:parameters];
    pageMenu.delegate = delegate;
    
    return pageMenu;
}

- (void)setupBadgePanelViews{
    NSInteger itemCount = [self.pageMenuController.menuItems count];
    for (int i = 0; i < itemCount; i++) {
        MenuItemView *itemView = self.pageMenuController.menuItems[i];
        NSString *title = itemView.titleLabel.text;
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:self.pageMenuController.menuItemFont}];
        CGSize itemSize = CGSizeMake(screenWidth / itemCount, self.pageMenuController.menuHeight);
        CGRect itemFrame = CGRectMake(itemSize.width * i, 0, itemSize.width, itemSize.height);
        CGRect titleFrame = CGRectMake(itemFrame.origin.x + (itemSize.width - titleSize.width) / 2.0, (itemSize.height - titleSize.height) / 2.0, titleSize.width, titleSize.height);
        YTMarkView *badgePanelView = [[YTMarkView alloc] initWithFrame:titleFrame];
        //badgePanelView.layer.borderColor = [UIColor redColor].CGColor;
        //badgePanelView.layer.borderWidth = 0.5;
        badgePanelView.userInteractionEnabled = YES;
        [self.pageMenuController.view addSubview:badgePanelView];
        [self.badgePanelViews addObject:badgePanelView];
        [self.itemFrames addObject:[NSValue valueWithCGRect:itemFrame]];
        [self.titleFrames addObject:[NSValue valueWithCGRect:titleFrame]];
    }
    
}

- (void)setupBadgeViews{
    for (UIView *panelView in self.badgePanelViews) {
        YTBadge *badge = [[YTBadge alloc] initWithParentView:panelView];
        badge.textCircleUnderNum = 10;
        badge.textAdjustSize = CGSizeMake(12, 4);
        badge.textCircleAdjustSize = CGSizeMake(4, 4);
        badge.moreAdjustSize = CGSizeMake(10, 0);
        badge.textFont = [UIFont systemFontOfSize:12];
        badge.adjustPosition = CGPointMake(0, badge.badgeSize.height / 2);
        [self.badgeViews addObject:badge];
    }
}

// 重新设置选中红线，不用原来的，这样就方便让红线宽度就着title的宽度了
- (void)setupSelectionIndicatorViews{
    NSInteger count = [self.pageMenuController.menuItems count];
    for (int i = 0; i < count; i++) {
        CGRect titleFrame = [self.titleFrames[i] CGRectValue];
        CGRect itemFrame = [self.itemFrames[i] CGRectValue];
        UIView *indicator = [[UIView alloc] initWithFrame:CGRectMake(titleFrame.origin.x, itemFrame.size.height - 2.0, titleFrame.size.width, 2.0)];
        indicator.backgroundColor = self.pageMenuController.selectionIndicatorColor;
        if (self.pageMenuController.currentPageIndex == i) {
            indicator.hidden = NO;
        }else{
            indicator.hidden = YES;
        }
        [self.pageMenuController.view addSubview:indicator];
        [self.selectionIndicators addObject:indicator];
    }
}

- (void)showSelectionIndicatorAtIndex:(NSInteger)index{
    NSInteger count = [self.selectionIndicators count];
    for (int i = 0; i < count; i++) {
        UIView *indicator = self.selectionIndicators[i];
        if (index == i) {
            indicator.hidden = NO;
        }else{
            indicator.hidden = YES;
        }
    }
}

#pragma mark - KVO

- (void)observeItemTitleColorChange{
    for (int i = 0; i < [self.pageMenuController.menuItems count]; i++) {
        MenuItemView *itemView = self.pageMenuController.menuItems[i];
        [itemView addObserver:self forKeyPath:MenuItemViewTitleLabelTextColorKeyPath options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(@(i))];
    }
}
// 如果在代理方法里面设置选中红线，那么红线出现的时机是会比标题颜色变化的时机要慢，UI体验就不好了，所以用KVO解决红线与标题颜色变化的同步问题
// 因为含有 NSKeyValueChangeKey，在iOS7上面不存在，所以会崩溃
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:MenuItemViewTitleLabelTextColorKeyPath]) {
//        UIColor *newColor = [change valueForKey:NSKeyValueChangeNewKey];
//        UIColor *redColor = [UIColor redColor];
//        if (CGColorEqualToColor(newColor.CGColor, redColor.CGColor)) {
//            NSInteger index = [(__bridge NSNumber *)context integerValue];
//            [self showSelectionIndicatorAtIndex:index];
//        }
//    }
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:MenuItemViewTitleLabelTextColorKeyPath]) {
        UIColor *newColor = [change valueForKey:NSKeyValueChangeNewKey];
        UIColor *redColor = [UIColor redColor];
        if (CGColorEqualToColor(newColor.CGColor, redColor.CGColor)) {
            NSInteger index = [(__bridge NSNumber *)context integerValue];
            [self showSelectionIndicatorAtIndex:index];
        }
    }
}


#pragma mark - CAPSPageMenuDelegate
- (void)willMoveToPage:(UIViewController *)controller index:(NSInteger)index {
    if (self.willMoveBlock) {
        self.willMoveBlock(controller, index);
    }
}
- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index {
    self.currentPageIndex = index;
    if (self.didMoveBlock) {
        self.didMoveBlock(controller, index);
    }
}



@end
