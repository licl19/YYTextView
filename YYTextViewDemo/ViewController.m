//
//  ViewController.m
//  YYTextViewDemo
//
//  Created by lichanglai on 2018/3/26.
//  Copyright © 2018年 sankai. All rights reserved.
//

#import "ViewController.h"
#import <YYImage.h>
#import <YYText.h>

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    YYTextView *textView;
    textView = [YYTextView new];
    textView.userInteractionEnabled = YES;
    textView.textVerticalAlignment = YYTextVerticalAlignmentTop;
    CGRect frame = textView.bounds;
    frame.size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    textView.frame = frame;
    
    //    创建最主要的attribute文本
    NSMutableAttributedString *contentText = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:16];
    
    //    图片资源
    YYImage *image = [YYImage imageNamed:@"demo.jpg"];
    image.preloadAllAnimatedImageFrames = YES;
    
    //    添加文本+图片
    [contentText appendAttributedString:[[NSAttributedString alloc] initWithString:@"这是第一站图片" attributes:nil]];
    {
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width - 10, self.view.frame.size.width/image.size.width*image.size.height);
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView.frame.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [contentText appendAttributedString:attachText];
    }
    
    //    添加文本+图片
    [contentText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n 接下来是第二张" attributes:nil]];
    
    {
        YYAnimatedImageView *imageView2 = [[YYAnimatedImageView alloc] initWithImage:image];
        
        imageView2.frame = CGRectMake(0, 0, self.view.frame.size.width - 10, self.view.frame.size.width/image.size.width*image.size.height);
        NSMutableAttributedString *attachText2 = [NSMutableAttributedString yy_attachmentStringWithContent:imageView2 contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView2.frame.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [contentText appendAttributedString:attachText2];
    }
    
    textView.attributedText = contentText;
    [self.view addSubview:textView];
    
    //获取图片资源
    NSArray *attachments =  textView.textLayout.attachments;
    for(YYTextAttachment *attachment in attachments)
    {
        YYAnimatedImageView *imageView = attachment.content;
        YYImage *image = (YYImage *)imageView.image;
        NSLog(@"获取到图片:%@",image);
    }
    NSArray *attachmentRanges = textView.textLayout.attachmentRanges;
    for (NSValue *range in attachmentRanges)
    {
        NSRange r = [range rangeValue];
        NSLog(@"资源所在位置：%ld 长度: %ld",r.location,r.length);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
