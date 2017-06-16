//
//  WJSegmentedView.h
//  jf_store
//
//  Created by reborn on 2017/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJSegmentedView;
@protocol WJSegmentedViewDelegate <NSObject>

- (void)segmentedView:(WJSegmentedView *)segmentedView buttonClick:(NSInteger)index;
@end

@interface WJSegmentedView : UIView
@property(nonatomic,weak)id<WJSegmentedViewDelegate> delegate;
@property(nonatomic,assign)NSInteger selectedSegmentIndex;
@property(nonatomic,assign)BOOL      isShowBottomLine;
-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;
-(void)changeSegmentTitleWithItems:(NSArray *)items;
-(void)setBottomLineView:(BOOL)isShow;


@end
