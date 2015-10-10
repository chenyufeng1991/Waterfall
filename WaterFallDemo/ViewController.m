//
//  ViewController.m
//  WaterFallDemo
//
//  Created by chenyufeng on 15/9/17.
//  Copyright (c) 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import "WaterFallCollectionViewCell.h"
#import "WaterFallFlowLayout.h"



CGFloat const kImgCount = 17;
static NSString *identifier = @"collectionView";


@interface ViewController ()

@property(nonatomic,strong) NSArray *imgArr;

@end

@implementation ViewController

//懒加载；
-(NSArray *)imgArr{
  
  if (!_imgArr) {
    NSMutableArray *muArr = [NSMutableArray array];
    for (int i = 1; i < kImgCount; i++) {
      
      UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"huoying%d",i]];
      
      [muArr addObject:image];
      
      
    }
    
    _imgArr = muArr;
  }
  
  return _imgArr;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  WaterFallFlowLayout *flowLayout = [[WaterFallFlowLayout alloc] init];
  self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
  
  self.collectionView.backgroundColor = [UIColor yellowColor];
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  
  //注册单元格；
  [self.collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:identifier];
  
  [self.view addSubview:self.collectionView];
  
}

#pragma mark - UICollectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
  return self.imgArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
  
  if (!cell) {
    
    cell = [[WaterFallCollectionViewCell alloc] init];
    
  }
  
  cell.image = self.imgArr[indexPath.item];
  return cell;
  
}


-(float)imgHeight:(float)height width:(float)width{
  
  /*
   
   高度/宽度 = 压缩后高度/压缩后宽度（100）
   */
  
  float newHeight = height / width * 100;
  return newHeight;
}



#pragma mark - UICollectionView delegate flowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  UIImage *image = self.imgArr[indexPath.item];
  float height = [self imgHeight:image.size.height width:image.size.width];
  
  return CGSizeMake(100, height);
  
  
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
  
  UIEdgeInsets edgeInsets = {5,5,5,5};
  return edgeInsets;
}


@end


































