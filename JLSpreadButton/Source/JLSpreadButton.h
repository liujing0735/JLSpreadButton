//
//  JLSpreadButton.h
//  ACTION
//
//  Created by JohnnyLiu on 2016/11/17.
//  Copyright © 2016年 JohnnyLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 子按钮伸展方向

 - JLSpreadOrientationUp: 向上伸展
 - JLSpreadOrientationDown: 向下伸展
 - JLSpreadOrientationLeft: 向左伸展
 - JLSpreadOrientationRight: 向右伸展
 */
typedef NS_ENUM(NSUInteger, JLSpreadOrientation) {
    JLSpreadOrientationUp,
    JLSpreadOrientationDown,
    JLSpreadOrientationLeft,
    JLSpreadOrientationRight,
};

@class JLSpreadButton;
/**
 代理
 */
@protocol JLSpreadButtonDelegate <NSObject>
@required// 必须实现


@optional// 可选实现

/**
 主按钮伸展状态事件代理

 @param spreadButton JLSpreadButton的实例
 @param state 伸展状态
 */
- (void)spreadButton:(JLSpreadButton *)spreadButton spreadState:(BOOL)state;

/**
 子按钮点击事件代理

 @param spreadButton JLSpreadButton的实例
 @param index 被点击按钮的序号
 */
- (void)spreadButton:(JLSpreadButton *)spreadButton clickButtonAtIndex:(NSInteger)index;
@end

/**
 接口
 */
@interface JLSpreadButton : UIButton

/**
 初始化
 
 @param frame CGRect
 @param delegate 委托
 @return JLSpreadButton
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id <JLSpreadButtonDelegate>)delegate;

/**
 子按钮图片数组
 */
@property (strong, nonatomic) NSArray <UIImage *> *images;

/**
 代理
 */
@property (strong, nonatomic) id <JLSpreadButtonDelegate> delegate;

/**
 展开间距，默认8.0f
 */
@property (assign, nonatomic) NSInteger spacing;

/**
 展开方向，默认向上
 */
@property (assign, nonatomic) JLSpreadOrientation spreadOrientation;

/**
 动画持续时间，默认0.5s
 */
@property (assign, nonatomic) NSTimeInterval duration;

/**
 创建按钮时的角度，默认0
 */
@property (assign, nonatomic) CGFloat originalAngle;

/**
 展开时是否旋转，默认为YES
 */
@property (assign, nonatomic) BOOL rotate;

/**
 展开时旋转角度,默认M_PI
 */
@property (assign, nonatomic) CGFloat rotationAngle;

/**
 自动设置选择的子按钮图标为主按钮图标，默认为YES
 */
@property (assign, nonatomic) BOOL autoChoosePicture;

/**
 点击子按钮后，自动隐藏所有子按钮，默认为YES
 */
@property (assign, nonatomic) BOOL autoHiddenSubViews;

/**
 限制该时间内未操作，自动隐藏所有子按钮，默认为-1，不限制
 */
@property (assign, nonatomic) NSInteger timing;

- (void)showSubViews;

- (void)hiddenSubViews;
@end
