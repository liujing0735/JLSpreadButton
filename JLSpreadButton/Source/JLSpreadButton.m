//
//  JLSpreadButton.m
//  ACTION
//
//  Created by JohnnyLiu on 2016/11/17.
//  Copyright © 2016年 JohnnyLiu. All rights reserved.
//

#import "JLSpreadButton.h"

@interface JLSpreadButton ()

@property (strong, nonatomic) NSMutableArray <UIButton *> *buttons;
@property (assign, nonatomic) BOOL isShowSubView;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSTimeInterval timeInterval;
@end

@implementation JLSpreadButton

- (void)initData {
    _spacing = 8.0;
    _duration = 0.5;
    _spreadOrientation = JLSpreadOrientationUp;
    _originalAngle = 0;
    _rotate = YES;
    _rotationAngle = M_PI;
    _isShowSubView = NO;
    _autoChoosePicture = YES;
    _autoHiddenSubViews = YES;
    _timing = -1;
    _timeInterval = -1;
    [self setTag:0];
    [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id <JLSpreadButtonDelegate>)delegate {

    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        _delegate = delegate;
    }
    return self;
}

- (void)setImages:(NSArray<UIImage *> *)images {
    if (images) {
        [self loadSubviewsWithImages:images];
        _images = images;
    }
}

- (void)setTag:(NSInteger)tag {
    if (_autoChoosePicture) {
        [self setImage:[_images objectAtIndex:tag] forState:UIControlStateNormal];
    }
}

- (void)setOriginalAngle:(CGFloat)originalAngle {

    if (originalAngle != 0) {
        [self setTransform:CGAffineTransformRotate(self.transform, originalAngle)];
        for (int i=0; i<[_buttons count]; i++) {
            UIButton *button = [_buttons objectAtIndex:i];
            [button setTransform:CGAffineTransformRotate(button.transform, originalAngle)];
        }
        _originalAngle = originalAngle;
    }
}

- (void)setTiming:(NSInteger)timing {

    if (timing > 0) {
        _timing = timing;
        _timeInterval = timing;
        
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFun:) userInfo:nil repeats:YES];
            [_timer fire];
        }
    }
}

- (void)timerFun:(NSTimer *)timer {
    if (_timeInterval > 0) {
        _timeInterval -= 1;
    }else {
        [self hiddenSubViews];
    }
}

- (void)loadSubviewsWithImages:(NSArray <UIImage *> *)images {
    
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] init];
    }else {
        [_buttons removeAllObjects];
    }
    
    for (int i=0; i<[images count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:self.frame];
        [button setImage:[images objectAtIndex:i] forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button setHidden:YES];
        [_buttons addObject:button];
    }
}

- (void)showSubViews {
    if (_isShowSubView) {
        return;
    }
    _isShowSubView = YES;
    
    for (int i=0; i<[_buttons count]; i++) {
        UIButton *button = [_buttons objectAtIndex:i];
        [self.superview insertSubview:button belowSubview:self];
        [button setHidden:NO];
    }
    [UIView animateWithDuration:_duration animations:^{
        if (_rotate) {
            [self setTransform:CGAffineTransformRotate(self.transform, _rotationAngle)];
        }
        for (int i=0; i<[_buttons count]; i++) {
            UIButton *button = [_buttons objectAtIndex:i];
            
            switch (_spreadOrientation) {
                case JLSpreadOrientationUp:
                {
                    [button setCenter:CGPointMake(self.center.x, self.center.y-(i+1)*(_spacing+self.frame.size.height))];
                }
                    break;
                case JLSpreadOrientationDown:
                {
                    [button setCenter:CGPointMake(self.center.x, self.center.y+(i+1)*(_spacing+self.frame.size.height))];
                }
                    break;
                case JLSpreadOrientationLeft:
                {
                    [button setCenter:CGPointMake(self.center.x-(i+1)*(_spacing+self.frame.size.width), self.center.y)];
                }
                    break;
                case JLSpreadOrientationRight:
                {
                    [button setCenter:CGPointMake(self.center.x+(i+1)*(_spacing+self.frame.size.width), self.center.y)];
                }
                    break;
                default:
                    break;
            }
            if (_rotate) {
                [button setTransform:CGAffineTransformRotate(button.transform, _rotationAngle)];
            }
        }
    } completion:^(BOOL finished) {
        
    }];
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(spreadButton:spreadState:)]) {
            [_delegate spreadButton:self spreadState:YES];
        }
    }
}

- (void)hiddenSubViews {
    if (!_isShowSubView) {
        return;
    }
    _isShowSubView = NO;
    
    [UIView animateWithDuration:_duration animations:^{
        if (_rotate) {
            [self setTransform:CGAffineTransformRotate(self.transform, -_rotationAngle)];
        }
        for (int i=0; i<[_buttons count]; i++) {
            UIButton *button = [_buttons objectAtIndex:i];
            [button setCenter:self.center];
            if (_rotate) {
                [button setTransform:CGAffineTransformRotate(button.transform, -_rotationAngle)];
            }
        }
    } completion:^(BOOL finished) {
        for (int i=0; i<[_buttons count]; i++) {
            UIButton *button = [_buttons objectAtIndex:i];
            [button setHidden:YES];
        }
    }];
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(spreadButton:spreadState:)]) {
            [_delegate spreadButton:self spreadState:NO];
        }
    }
}

- (void)touchUpInside:(UIButton *)button {
    if (_timing > 0) {
        _timeInterval = _timing;
    }
    
    if (button == self) {
        if (_isShowSubView) {
            [self hiddenSubViews];
        }else {
            [self showSubViews];
        }
        return;
    }
    
    [self setTag:button.tag];
    
    if (_autoHiddenSubViews) {
        [self hiddenSubViews];
    }
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(spreadButton:clickButtonAtIndex:)]) {
            [_delegate spreadButton:self clickButtonAtIndex:button.tag];
        }
    }
}
/*
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *result = [super hitTest:point withEvent:event];
        if (result) {
            return result;
        }else {
            for (UIView *subView in self.subviews.reverseObjectEnumerator) {
                CGPoint subPoint = [subView convertPoint:point fromView:self];
                result = [subView hitTest:subPoint withEvent:event];
                if (result) {
                    return result;
                }
            }
        }
    }
    return nil;
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
