//
//  LYDrawView.h
//  Quartz2DDrawDemo
//
//  Created by Liuyu on 14-7-1.
//  Copyright (c) 2014年 Liuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultLineColor   [UIColor blackColor];
#define kDefaultLineWidth   20
#define kDefaultLineAlpha   1.0

/*!
 *  画贝塞尔曲线
 */
@interface LYDrawView : UIView

// 线的颜色，默认 kDefaultLineColor
@property (nonatomic, strong) UIColor *lineColor;

// 线宽，默认 kDefaultLineWidth
@property (nonatomic) CGFloat lineWidth;

// 线透明度，默认 kDefaultLineAlpha
@property (nonatomic) CGFloat lineAlpha;

// 是否是橡皮擦，默认不是
@property (nonatomic, getter = isEraser) BOOL eraser;

@end
