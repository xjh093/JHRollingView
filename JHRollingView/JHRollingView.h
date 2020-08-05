//
//  JHRollingView.h
//  JHKit
//
//  Created by HaoCold on 2020/7/3.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JHRollingView;

typedef void(^JHRollingViewRefreshBlock)(JHRollingView *view, id data);

@interface JHRollingView : UIView
/// Default is 3.0
@property (nonatomic,  assign) CGFloat  duration;
@property (nonatomic,  strong) UIView *contentView;

@property (nonatomic,    copy) JHRollingViewRefreshBlock refreshBlock;

/// 上面的属性配置好后，最后调用这个方法
- (void)configWithData:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
