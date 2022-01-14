//
//  RecomView.h
//  Wallpaper
//
//  Created by 曾 on 2021/12/16.
//

#import <UIKit/UIKit.h>

@protocol RecomViewDelegate <NSObject>
-(void)RefreshHeadHeight:(CGFloat)height;
-(void)LetGo:(BOOL)isof;
@end

NS_ASSUME_NONNULL_BEGIN

@interface RecomView : UIView
@property (nonatomic, weak)id<RecomViewDelegate> myDelegate;
@end

NS_ASSUME_NONNULL_END