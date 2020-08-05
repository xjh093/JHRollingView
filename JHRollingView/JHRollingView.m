//
//  JHRollingView.m
//  JHKit
//
//  Created by HaoCold on 2020/7/3.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "JHRollingView.h"

@interface JHRollingView()
@property (nonatomic,  strong) NSArray *array;
@property (nonatomic,  assign) NSInteger  index;

@property (nonatomic,  strong) NSTimer *timer;
@end

@implementation JHRollingView

#pragma mark -------------------------------------视图-------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _duration = 3.0;
        
        [self addSubview:self.contentView];
    }
    return self;
}

#pragma mark -------------------------------------事件-------------------------------------------

- (void)configWithData:(NSArray *)array
{
    if (array.count == 0) {
        self.hidden = YES;
        return;
    }
    
    _index = 0;
    _array = array;
    self.hidden = NO;
    
    if (_refreshBlock) {
        _refreshBlock(self, _array[_index]);
    }
    
    if (!_timer) {
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark --- 动画
- (void)rolling
{
    _index++;
    if (_index >= _array.count) {
        _index = 0;
    }
    
    if (_refreshBlock) {
        _refreshBlock(self, _array[_index]);
    }
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.duration = 0.5;
    [_contentView.layer addAnimation:transition forKey:nil];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)setDuration:(CGFloat)duration
{
    if (duration < 0 || _array.count <= 0) {
        return;
    }
    
    _duration = duration;
    
    [_timer invalidate];
    _timer = nil;
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (UIView *)contentView{
    if (!_contentView) {
        UIView *view = [[UIView alloc] init];
        view.frame = self.bounds;
        _contentView = view;
    }
    return _contentView;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(rolling) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
