//
//  CycleView.h
//  CycleView
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 HYR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CycleView : UIView
@property(nonatomic,copy)void(^cycleViewDidSelected)(NSInteger index) ;

-(instancetype)initCycleViewWithListArray:(NSArray<NSString*>*)array frame:(CGRect)frame;
-(void)addTimer;
-(void)removeTimer;
@end

NS_ASSUME_NONNULL_END



///-------------------------
/// CycleTabCell
///-------------------------
NS_ASSUME_NONNULL_BEGIN

@interface CycleTabCell:UICollectionViewCell
@property(nonatomic,copy) NSString *imgUrl;
@end
NS_ASSUME_NONNULL_END
