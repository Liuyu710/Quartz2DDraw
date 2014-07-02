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

@property (nonatomic, retain) UIBezierPath *path;

@end


@implementation LYDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        self.lineColor = kDefaultLineColor;
        self.lineWidth = kDefaultLineWidth;
        self.lineAlpha = kDefaultLineAlpha;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.path.lineWidth = self.lineWidth;
    [self.lineColor setStroke];
    [self.path strokeWithBlendMode:(self.isEraser ? kCGBlendModeClear : kCGBlendModeNormal) alpha:self.lineAlpha];
}

#pragma mark - Getter

- (UIBezierPath *)path
{
    if (!_path) {
        _path = [[UIBezierPath alloc] init];
        _path.lineCapStyle = kCGLineCapRound;
    }
    return _path;
}

- (BOOL)isEraser
{
    return _eraser;
}

#pragma mark - Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touches.count == 1) {
        [self.path removeAllPoints];
        [self.path moveToPoint:[[touches anyObject] locationInView:self]];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touches.count == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint point1 = [touch locationInView:self];
        CGPoint point2 = [touch previousLocationInView:self];
        
        [self.path addQuadCurveToPoint:CGPointMake((point1.x + point2.x)/2.0, (point1.y + point2.y)/2.0) controlPoint:point2];
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

@end
