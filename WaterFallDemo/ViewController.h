//
//  ViewController.h
//  WaterFall
//
//  Created by CarolWang on 14/11/29.
//  Copyright (c) 2014年 Carol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

