//
//  UILabel+size.m
//  YJTangguo
//
//  Created by wanyongjian on 2017/7/19.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "UILabel+size.h"

@implementation UILabel (size)

+ (CGSize)labelSizeFromFont:(CGFloat)font andString:(NSString *)str{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
    label.text = str;
    label.font = [UIFont systemFontOfSize:font];
    [label sizeToFit];
    label.numberOfLines = 0;
    CGSize size = label.frame.size;
    return size;
}
@end
