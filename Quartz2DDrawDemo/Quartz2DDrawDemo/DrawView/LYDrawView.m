//
//  LYDrawView.m
//  Quartz2DDrawDemo
//
//  Created by Liuyu on 14-7-1.
//  Copyright (c) 2014年 Liuyu. All rights reserved.
//

#import "LYDrawView.h"
#import <CoreGraphics/CoreGraphics.h>

@interface LYDrawView ()

@property (nonatomic, strong) UIBezierPath *currentPath;

@end


@implementation LYDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];    // 要实现橡皮檫效果，背景色必须为透明颜色
        
        self.lineColor = kDefaultLineColor;
        self.lineWidth = kDefaultLineWidth;
        self.lineAlpha = kDefaultLineAlpha;
    }
    return self;
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    // 绘制之前的线
    [self.image drawInRect:self.bounds];
    
    // 绘制当前线
    [self drawLine];
}

- (void)drawLine
{
    // 可以查看 CGBlendMode 更多的效果
    [self.lineColor setStroke];
    [self.currentPath strokeWithBlendMode:(self.isEraser ? kCGBlendModeClear : kCGBlendModeNormal) alpha:self.lineAlpha];
}

#pragma mark - Getter

- (UIBezierPath *)currentPath
{
    if (!_currentPath) {
        _currentPath = [[UIBezierPath alloc] init];
        _currentPath.lineCapStyle = kCGLineCapRound;
        _currentPath.lineWidth = self.lineWidth;
    }
    return _currentPath;
}

- (BOOL)isEraser
{
    return _eraser;
}

#pragma mark - Setter



#pragma mark - Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touches.count == 1) {
        // 开始绘线
        [self.currentPath moveToPoint:[[touches anyObject] locationInView:self]];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touches.count == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint point1 = [touch locationInView:self];
        CGPoint point2 = [touch previousLocationInView:self];
        
        [self.currentPath addQuadCurveToPoint:CGPointMake((point1.x + point2.x)/2.0, (point1.y + point2.y)/2.0) controlPoint:point2];
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    
    // set the draw point
    [self.image drawAtPoint:CGPointZero];
    [self drawLine];
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 绘线结束
    self.currentPath = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - 

// 清除屏幕
- (void)clean
{
    self.image = nil;
    [self setNeedsDisplay];
}

@end
