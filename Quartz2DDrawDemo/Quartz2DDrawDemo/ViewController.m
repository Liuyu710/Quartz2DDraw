//
//  ViewController.m
//  Quartz2DDrawDemo
//
//  Created by Liuyu on 14-7-1.
//  Copyright (c) 2014年 Liuyu. All rights reserved.
//

#import "ViewController.h"
#import "LYDrawView.h"

@interface ViewController ()

@property (nonatomic, strong) LYDrawView *drawView;
@property (nonatomic, strong) NSArray *colors;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    // 画板
    self.drawView = [[LYDrawView alloc] initWithFrame:self.view.bounds];
    self.drawView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.drawView];
    
    // 宽度选择
    do {
        UISlider *widthSlider = [[UISlider alloc] initWithFrame:CGRectMake(60, 30, 250, 20)];
        widthSlider.minimumValue = 20;
        widthSlider.maximumValue = 70;
        widthSlider.value = 20;
        [widthSlider addTarget:self action:@selector(selectedWidth:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:widthSlider];
        
        UILabel *widthLabel = [[UILabel alloc] initWithFrame:CGRectMake(-50, 00, 50, 20)];
        widthLabel.textAlignment = NSTextAlignmentRight;
        widthLabel.text = @"width:";
        [widthSlider addSubview:widthLabel];
    } while (0);
    
    // 透明度选择
    do {
        UISlider *alphaSlider = [[UISlider alloc] initWithFrame:CGRectMake(60, 60, 250, 20)];
        alphaSlider.minimumValue = 0;
        alphaSlider.maximumValue = 1.0;
        alphaSlider.value = 1.0;
        [alphaSlider addTarget:self action:@selector(selectedAlpha:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:alphaSlider];
        
        UILabel *alphaLabel = [[UILabel alloc] initWithFrame:CGRectMake(-50, 00, 50, 20)];
        alphaLabel.textAlignment = NSTextAlignmentRight;
        alphaLabel.text = @"alpha:";
        [alphaSlider addSubview:alphaLabel];
    } while (0);
    
    // 颜色选择
    self.colors = @[[UIColor blackColor],
                    [UIColor whiteColor],
                    [UIColor redColor],
                    [UIColor yellowColor],
                    [UIColor blueColor],
                    ];
    
    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.borderWidth = 0.5;
        button.backgroundColor = self.colors[i];
        button.frame = CGRectMake(i*(320.0/5) + 10, 90, 320.0/5 - 20, 20);
        button.tag = i;
        [button addTarget:self action:@selector(selectedColor:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    // 笔 / 橡皮檫
    do {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.borderWidth = 0.5;
        button.frame = CGRectMake(10, 120, 100, 30);
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button setTitle:[NSString stringWithFormat:@"使用橡皮擦"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectedEraser:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    } while (0);
    
    // 清零
    do {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.borderWidth = 0.5;
        button.frame = CGRectMake(110, 120, 100, 30);
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button setTitle:[NSString stringWithFormat:@"清零"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cleanDrawView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    } while (0);
    
    // 保存
    do {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.borderWidth = 0.5;
        button.frame = CGRectMake(210, 120, 100, 30);
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button setTitle:[NSString stringWithFormat:@"保存到相册"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(saveDrawViewToAlbum:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    } while (0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)selectedWidth:(UISlider *)slider
{
    self.drawView.lineWidth = slider.value;
}

- (void)selectedAlpha:(UISlider *)slider
{
    self.drawView.lineAlpha = slider.value;
}

- (void)selectedColor:(UIButton *)button
{
    self.drawView.lineColor = self.colors[button.tag];
}

- (void)selectedEraser:(UIButton *)button
{
    button.selected = !button.selected;
    
    //
    if (button.selected) {
        self.drawView.eraser = YES;
        [button setTitle:[NSString stringWithFormat:@"使用画笔"] forState:UIControlStateNormal];
    }
    else {
        self.drawView.eraser = NO;
        [button setTitle:[NSString stringWithFormat:@"使用橡皮擦"] forState:UIControlStateNormal];
    }
}

- (void)cleanDrawView:(UIButton *)button
{
    [self.drawView clean];
}

- (void)saveDrawViewToAlbum:(UIButton *)button
{
    if (self.drawView.image) {
        UIImageWriteToSavedPhotosAlbum(self.drawView.image, nil, nil, nil);
    }
}


@end
