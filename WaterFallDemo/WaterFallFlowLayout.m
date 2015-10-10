//
//  WaterFallFlowLayout.m
//  WaterFall
//
//  Created by CarolWang on 14/11/29.
//  Copyright (c) 2014年 Carol. All rights reserved.
//

#import "WaterFallFlowLayout.h"
CGFloat const colCount = 3;
@implementation WaterFallFlowLayout
//准备布局：得到cell的总个数，为每个cell确定自己的位置
- (void)prepareLayout{
  [super prepareLayout];
  _colArr = [NSMutableArray array];
  _attributeDict = [NSMutableDictionary dictionary];
  self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
  //获取cell的总个数
  _cellCount = [self.collectionView numberOfItemsInSection:0];
  if (_cellCount == 0) {
    return;
  }
  float top = 0;
  for (int i = 0; i < colCount; i++) {
    [_colArr addObject:[NSNumber numberWithFloat:top]];
  }
  //循环调用layoutForItemAtIndexPath方法，为每个cell布局，将indexPath传入，作为布局字典的key
  //layoutAttributesForItemAtIndexPath方法的实现，这里用到了一个布局字典，其实就是将每个cell的位置信息与indexPath相对应，将它们放到字典中，方便后面视图的检索
  for (int i = 0; i < _cellCount; i++) {
    [self layoutItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
  }
  
}
//此方法会多次调用，为每个cell布局
- (void)layoutItemAtIndexPath:(NSIndexPath *)indexPath{
  //通过协议得到cell的间隙
  UIEdgeInsets edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.row];
  CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
  float col = 0;
  float shortHeight = [[_colArr objectAtIndex:col] floatValue];
  //找出高度最小的列，将cell加到最小列中
  for (int i = 0; i < _colArr.count; i++) {
    float height = [[_colArr objectAtIndex:i] floatValue];
    if (height < shortHeight) {
      shortHeight = height;
      col = i;
    }
  }
  float top = [[_colArr objectAtIndex:col] floatValue];
  //确定cell的frame
  CGRect frame = CGRectMake(edgeInsets.left + col * (edgeInsets.left + itemSize.width), top + edgeInsets.top, itemSize.width, itemSize.height);
  //更新列高
  [_colArr replaceObjectAtIndex:col withObject:[NSNumber numberWithFloat:top + edgeInsets.top + itemSize.height]];
  //每个cell的frame对应一个indexPath，放入字典中
  [_attributeDict setObject:indexPath forKey:NSStringFromCGRect(frame)];
}
//为每个cell布局完毕后，需要实现这个方法， 传入frame，返回的时cell的信息
//传入当前可见cell的rect，视图滑动时调用
- (NSArray *)indexPathsOfItem:(CGRect)rect{
  //遍历布局字典通过CGRectIntersectsRect方法确定每个cell的rect与传入的rect是否有交集，如果结果为true，则此cell应该显示，将布局字典中对应的indexPath加入数组
  NSMutableArray *array = [NSMutableArray array];
  for (NSString *rectStr in _attributeDict) {
    CGRect cellRect = CGRectFromString(rectStr);
    if (CGRectIntersectsRect(cellRect, rect)) {
      NSIndexPath *indexPath = _attributeDict[rectStr];
      [array addObject:indexPath];
    }
  }
  return array;
}
//返回cell的布局信息，如果忽略传入的rect一次性将所有的cell布局信息返回，图片过多时性能会很差
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
  NSMutableArray *muArr = [NSMutableArray array];
  //indexPathsOfItem方法，根据传入的frame值计算当前应该显示的cell
  NSArray *indexPaths = [self indexPathsOfItem:rect];
  for (NSIndexPath *indexPath in indexPaths) {
    UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
    [muArr addObject:attribute];
  }
  return muArr;
}
//最后还要实现这个方法，返回collectionView内容的大小
//只需要遍历前面创建的存放列高的数组得到列最高的一个作为高度返回就可以了
- (CGSize)collectionViewContentSize{
  CGSize size = self.collectionView.frame.size;
  float maxHeight = [[_colArr objectAtIndex:0] floatValue];
  //查找最高的列的高度
  for (int i = 0; i < _colArr.count; i++) {
    float colHeight = [[_colArr objectAtIndex:i] floatValue];
    if (colHeight > maxHeight) {
      maxHeight = colHeight;
    }
  }
  size.height = maxHeight;
  return size;
}
@end
