//
//  WaterFallFlowLayout.h
//  WaterFall
//
//  Created by CarolWang on 14/11/29.
//  Copyright (c) 2014年 Carol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFallFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) id<UICollectionViewDelegateFlowLayout> delegate;
@property (nonatomic, assign) NSInteger cellCount;//cell的个数
@property (nonatomic, strong) NSMutableArray *colArr;//存放列的高度
@property (nonatomic, strong) NSMutableDictionary *attributeDict;//存放cell的位置信息


@end
