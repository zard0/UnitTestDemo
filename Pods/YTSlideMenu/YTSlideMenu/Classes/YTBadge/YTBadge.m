//
//  YTBadge.m
//  YTSlideMenuDemo
//
//  Created by linkunzhu on 16/11/22.
//  Copyright © 2016年 linkunzhu. All rights reserved.
//

#import "YTBadge.h"
#import "YTInsetsLabel.h"

static const CGFloat DefaultDotWidth = 10.0;
static const CGFloat DefaultMoreCornerRadius = 0.5;
static const CGFloat DefaultFontSize = 12.0;
static const CGFloat DefaultTextInsetsTop = 0;
static const CGFloat DefaultTextInsetsLeft = 0;
static const CGFloat DefaultTextInsetsBottom = 0;
static const CGFloat DefaultTextInsetsRight = 0;
static const CGFloat DefaultTextAdjustHeight = 0;
static const CGFloat DefaultTextAdjustWidth = 0;
static const CGFloat DefaultTextCornerRadius = 0.5;
#define DefaultBadgeColor [UIColor colorWithRed:0.91 green:0.32 blue:0.17 alpha:1.00]
#define DefaultTextColor [UIColor whiteColor]

@interface YTBadge ()

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UIImageView *customImageView;
@property (nonatomic, strong) UIImage *customImage;
@property (nonatomic, strong) YTInsetsLabel *moreLabel;
@property (nonatomic, strong) YTInsetsLabel *textLabel;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIView *shownView;
@property (nonatomic, strong) UIView *parentView;

@end

@implementation YTBadge

#pragma mark - Public

- (instancetype)initWithParentView:(UIView *)view{
    if (self = [super init]) {
        NSAssert(view, @"Parent view不能为nil");
        self.parentView = view;
    }
    return self;
}

- (void)showWithDot {
    [self updateShownViewByView:self.dotView];
    CGFloat width = self.dotWidth > 0 ? self.dotWidth : self.dotView.frame.size.width;
    _badgeSize = CGSizeMake(width, width);
    self.dotView.frame = CGRectMake(self.parentView.frame.size.width + self.adjustPosition.x, -DefaultDotWidth + self.adjustPosition.y, width, width);
    self.dotView.layer.cornerRadius = self.dotView.frame.size.width / 2;
    self.dotView.backgroundColor = self.badgeColor ? self.badgeColor : self.dotView.backgroundColor;
}

- (void)showWithMore {
    [self updateShownViewByView:self.moreLabel];
    
    UIFont *textFont = self.textFont ? self.textFont : [UIFont systemFontOfSize:DefaultFontSize];
    CGSize textSize = [self.moreLabel.text sizeWithAttributes:@{NSFontAttributeName:textFont}];
    CGFloat width = textSize.width + self.moreAdjustSize.width;
    CGFloat height = textSize.height + self.moreAdjustSize.height;
    CGSize labelSize = CGSizeMake(MAX(width, height), height);
    _badgeSize = CGSizeMake(labelSize.width, labelSize.height);
    CGFloat x = self.parentView.frame.size.width + self.adjustPosition.x;
    CGFloat y = -labelSize.height + self.adjustPosition.y;
    CGFloat cornerRadius = self.moreCornerRadius > 0 ? self.moreCornerRadius * labelSize.height : DefaultMoreCornerRadius * labelSize.height;
    UIColor *badgeColor = self.badgeColor ? self.badgeColor : DefaultBadgeColor;
    UIColor *textColor = self.textColor ? self.textColor : DefaultTextColor;
    
    self.moreLabel.frame = CGRectMake(x, y, labelSize.width, labelSize.height);
    self.moreLabel.layer.cornerRadius = cornerRadius;
    self.moreLabel.backgroundColor = badgeColor;
    self.moreLabel.textColor = textColor;
    self.moreLabel.font = textFont;
    self.moreLabel.insets = UIEdgeInsetsMake(0, 3, (textSize.height / 2.0) - 0.5, 3);
}

- (void)showWithNone{
    if (self.shownView) {
        [self.shownView removeFromSuperview];
        self.shownView = nil;
    }
}

- (void)showWithText:(NSString *)text{
    self.text = text;
    if (!self.text || self.text.length == 0) {
        [self showWithNone];
        return;
    }
    [self updateShownViewByView:self.textLabel];
    
    UIFont *textFont = self.textFont ? self.textFont : [UIFont systemFontOfSize:DefaultFontSize];
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName:textFont}];
    textSize = CGSizeMake(MAX(textSize.width, textSize.height), textSize.height);
    UIEdgeInsets insets = !UIEdgeInsetsEqualToEdgeInsets(self.textInsets, UIEdgeInsetsZero) ? self.textInsets : UIEdgeInsetsMake(DefaultTextInsetsTop, DefaultTextInsetsLeft, DefaultTextInsetsBottom, DefaultTextInsetsRight);
    CGFloat adjustHeight = self.textAdjustSize.height + DefaultTextAdjustHeight;
    CGFloat adjustWidth = self.textAdjustSize.width + DefaultTextAdjustWidth;
    CGSize labelSize = CGSizeMake(textSize.width + adjustWidth, textSize.height + adjustHeight);
    if (self.textCircleUnderNum > 0 && [self.text integerValue] < self.textCircleUnderNum) {
        adjustHeight = self.textCircleAdjustSize.height + DefaultTextAdjustHeight;
        adjustWidth = self.textCircleAdjustSize.width + DefaultTextAdjustWidth;
        labelSize = CGSizeMake(textSize.width + adjustWidth, textSize.height + adjustHeight);
        labelSize = CGSizeMake(MAX(labelSize.width, labelSize.height), MAX(labelSize.width, labelSize.height));
    }
    _badgeSize = CGSizeMake(labelSize.width, labelSize.height);
    CGFloat x = self.parentView.frame.size.width + self.adjustPosition.x;
    CGFloat y = -labelSize.height + self.adjustPosition.y;
    CGFloat cornRadius = self.textCornerRadius > 0 ? self.textCornerRadius : DefaultTextCornerRadius;
    UIColor *textColor = self.textColor ? self.textColor : DefaultTextColor;
    UIColor *badgeColor = self.badgeColor ? self.badgeColor : DefaultBadgeColor;
    
    self.textLabel.frame = CGRectMake(x, y, labelSize.width, labelSize.height);
    self.textLabel.insets = insets;
    self.textLabel.layer.cornerRadius = self.textLabel.frame.size.height * cornRadius;
    self.textLabel.textColor = textColor;
    self.textLabel.backgroundColor = badgeColor;
    self.textLabel.font = textFont;
    self.textLabel.text = self.text;
}

- (void)showWithCustomImage:(UIImage *)image{
    self.customImage = image;
    if (!self.customImage) {
        [self showWithNone];
        return;
    }
    [self updateShownViewByView:self.customImageView];
    _badgeSize = CGSizeMake(self.customImage.size.width, self.customImage.size.height);
    CGFloat x = self.parentView.frame.size.width + self.adjustPosition.x;
    CGFloat y = -self.customImage.size.height + self.adjustPosition.y;
    self.customImageView.frame = CGRectMake(x, y, self.customImage.size.width, self.customImage.size.height);
}

- (void)updateShownViewByView:(UIView *)view {
    if (self.shownView != view) {
        [self.shownView removeFromSuperview];
        self.shownView = nil;
        [self.parentView addSubview:view];
        self.shownView = view;
    }
}

#pragma mark - Properties

- (UIView *)dotView {
    if (!_dotView) {
        _dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DefaultDotWidth, DefaultDotWidth)];
        _dotView.backgroundColor = DefaultBadgeColor;
        _dotView.layer.cornerRadius = DefaultDotWidth / 2.0;
    }
    return _dotView;
}

- (YTInsetsLabel *)moreLabel {
    if (!_moreLabel) {
        _moreLabel = [[YTInsetsLabel alloc] init];
        _moreLabel.text = @"...";
        _moreLabel.textAlignment = NSTextAlignmentCenter;
        self.moreLabel.clipsToBounds = YES;
    }
    return _moreLabel;
}

- (YTInsetsLabel *)textLabel{
    if (!_textLabel && _text.length > 0) {
        _textLabel = [[YTInsetsLabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.clipsToBounds = YES;
    }
    return _textLabel;
}

- (UIImageView *)customImageView{
    if (!_customImageView && _customImage) {
        _customImageView = [[UIImageView alloc] initWithImage:_customImage];
    }
    return _customImageView;
}


@end


















