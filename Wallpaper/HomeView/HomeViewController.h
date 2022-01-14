//
//  HomeViewController.h
//  Wallpaper
//
//  Created by 曾 on 2021/12/16.
//

#import <UIKit/UIKit.h>

@protocol HomeViewDelegate <NSObject>
-(void)selectIndex:(NSInteger)index;
@end
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UITabBarController
@property (nonatomic, weak)id<HomeViewDelegate> myDelegate;
@end

NS_ASSUME_NONNULL_END
