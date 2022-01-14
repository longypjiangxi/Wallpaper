//
//  PlayViewController.m
//  Wallpaper
//
//  Created by 曾 on 2021/12/16.
//

#import "PlayViewController.h"
#import "BaseScrollView.h"
#import "PayViewController.h"
#import "LastNewView.h"
#import "RecomView.h"
#import "HeadView.h"
@interface PlayViewController ()<GKViewControllerPushDelegate,RecomViewDelegate,LastNewViewDelegate>
@property (nonatomic, retain)RecomView*    recomView;
@property (nonatomic, retain)LastNewView*  lastNewView;
@property (nonatomic, retain)HeadView*     headView;
@property (nonatomic, retain)BaseScrollView* backScrollView;
@end

@implementation PlayViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self playAllVideo];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self stopAllVideo];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.gk_navBarAlpha=0;
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure *configure){
        configure.gk_pushTransitionCriticalValue=0.3;
        configure.backStyle=GKNavigationBarBackStyleNone;
    }];
    self.backScrollView.contentSize=CGSizeMake(SCREEN_WIDTH*2,0);
    [self.backScrollView addSubview:self.recomView];
    [self.backScrollView addSubview:self.lastNewView];
    self.gk_pushDelegate=self;
    self.backScrollView.contentOffset=CGPointMake(SCREEN_WIDTH,0);
    [self.view addSubview:self.headView];//添加头部s
    // Do any additional setup after loading the view.
}
- (void)pushToNextViewController
{
    PayViewController* pay=[[PayViewController alloc]init];
    pay.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pay animated:YES];
}
-(BaseScrollView*)backScrollView
{
    if(!_backScrollView)
    {
        _backScrollView=[[BaseScrollView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.pagingEnabled = YES;
        _backScrollView.bounces = NO; // 禁止弹簧效果
        if (@available(iOS 11.0, *)) {
            _backScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [self.view addSubview:_backScrollView];
    }
    return _backScrollView;
}
-(RecomView*)recomView
{
    if(!_recomView)
    {
        _recomView=[[RecomView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        _recomView.myDelegate=self;
    }
    return _recomView;
}
-(LastNewView*)lastNewView
{
    if(!_lastNewView)
    {
        _lastNewView=[[LastNewView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        _lastNewView.myDelegate=self;
    }
    return _lastNewView;
}
-(HeadView*)headView
{
    if(!_headView)
    {
        _headView=[[HeadView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,topHeight)];
    }
    return _headView;
}
-(void)RefreshHeadHeight:(CGFloat)height
{
    [self.headView upDateHeight:height];
}
-(void)LetGo:(BOOL)isof
{
    [self.headView LetGo:isof];
}
-(void)playAllVideo
{
    
}
-(void)stopAllVideo
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
