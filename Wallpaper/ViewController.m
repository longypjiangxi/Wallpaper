//
//  ViewController.m
//  Wallpaper
//
//  Created by 曾 on 2021/12/16.
//

#import "ViewController.h"
#import "SearchViewController.h"
#import "HomeViewController.h"
#import "PayViewController.h"
#import "BaseScrollView.h"
@interface ViewController ()<UIScrollViewDelegate,HomeViewDelegate>
@property (nonatomic, retain)BaseScrollView* backScrollView;
@property (nonatomic, retain)SearchViewController* searchView;
@property (nonatomic, retain)HomeViewController*   homeView;
@property (nonatomic, retain)PayViewController*    payView;
@property (nonatomic, strong)NSArray          *    childVCs;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.gk_navBarAlpha=0;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.backScrollView];
    self.backScrollView.frame=self.view.bounds;
    self.childVCs=@[self.searchView,self.homeView];
    self.backScrollView.contentSize=CGSizeMake(SCREEN_WIDTH*self.childVCs.count, 0);
    self.backScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    self.navigationController.gk_openScrollLeftPush=YES;
    
    // Do any additional setup after loading the view.
}
- (UIScrollView *)backScrollView
{
    if (!_backScrollView) {
        _backScrollView = [[BaseScrollView alloc]initWithFrame:self.view.bounds];
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.pagingEnabled = YES;
        _backScrollView.bounces = NO; // 禁止弹簧效果
        if (@available(iOS 11.0, *)) {
            _backScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _backScrollView;
}
-(SearchViewController*)searchView
{
    if(!_searchView)
    {
        _searchView=[[SearchViewController alloc]init];
        _searchView.view.frame=CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
        [self addChildViewController:_searchView];
        [self.backScrollView addSubview:_searchView.view];
    }
    return _searchView;
}
-(HomeViewController*)homeView
{
    if(!_homeView)
    {
        _homeView=[[HomeViewController alloc]init];
        _homeView.view.frame=CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT);
        _homeView.navigationController.gk_openScrollLeftPush=YES;
        _homeView.myDelegate=self;
        [self addChildViewController:_homeView];
        [self.backScrollView addSubview:_homeView.view];
    }
    return _homeView;
}
-(void)selectIndex:(NSInteger)index
{
    if(index==0)
    {
        self.backScrollView.scrollEnabled=YES;
    }else
    {
        self.backScrollView.scrollEnabled=NO;
    }
}
@end
