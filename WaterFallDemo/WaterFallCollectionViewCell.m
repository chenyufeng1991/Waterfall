//
//  WaterFallCollectionViewCell.m
//  WaterFall
//
//  Created by CarolWang on 14/11/29.
//  Copyright (c) 2014年 Carol. All rights reserved.
//

#import "WaterFallCollectionViewCell.h"

@implementation WaterFallCollectionViewCell
- (void)setImage:(UIImage *)image{
  if (_image != image) {
    _image = image;
  }
  [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
  float newHeight = _image.size.height / _image.size.width * 100;
  [_image drawInRect:CGRectMake(0, 0, 100, newHeight)];
}
@end
