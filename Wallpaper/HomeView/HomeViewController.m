//
//  HomeViewController.m
//  Wallpaper
//
//  Created by 曾 on 2021/12/16.
//

#import "HomeViewController.h"
#import "PlayViewController.h"
#import "TypeViewController.h"
#import "AddViewController.h"
#import "MakViewController.h"
#import "MeViewController.h"
@interface HomeViewController ()<UITabBarControllerDelegate>
@property (nonatomic, retain)UIView* centView;
@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *select = [NSDictionary dictionaryWithObject:RBG(107,80,255) forKey:NSForegroundColorAttributeName];
    NSArray* vcArr;
    NSArray* nameArr=@[@"首页",@"分类",@"添加",@"制作",@"我的"];
    PlayViewController* player=[[PlayViewController alloc]init];
    TypeViewController* type=[[TypeViewController alloc]init];
    AddViewController* addView=[[AddViewController alloc]init];
    MakViewController* mak=[[MakViewController alloc]init];
    MeViewController* me=[[MeViewController alloc]init];
    vcArr=@[player,type,addView,mak,me];
    self.tabBar.unselectedItemTintColor=RBG(60,60,59);
    NSMutableArray* navArr=[NSMutableArray new];
    for(int i=0;i<vcArr.count;i++)
    {
        UIViewController* myvc=vcArr[i];
        [myvc.tabBarItem setTitleTextAttributes:select forState:UIControlStateSelected];
        NSString* str=nameArr[i];
        myvc.tabBarItem.image=[UIImage imageNamed:str];
        NSString* str1=[NSString stringWithFormat:@"%@_%d",str,0];
        myvc.tabBarItem.selectedImage=[UIImage imageNamed:str1];
        myvc.tabBarItem.title=nameArr[i];
        if(i==2)
        {
            myvc.tabBarItem.title=@"";
        }
        UINavigationController* testnav=[UINavigationController rootVC:myvc translationScale:false];
        testnav.gk_openScrollLeftPush=YES;
        testnav.navigationBarHidden=NO;
        [navArr addObject:testnav];
    }
    self.viewControllers=navArr;
    self.selectedIndex=0;
    
    UIView* view=[[UIView alloc]init];
    view.backgroundColor=RBG(10,14,19);
    if(topHeight==64)
    {
        view.frame=self.tabBar.bounds;
    }else
    {
        view.frame=CGRectMake(self.tabBar.bounds.origin.x, self.tabBar.bounds.origin.y, self.tabBar.bounds.size.width, self.tabBar.bounds.size.height+40);
    }
    self.centView=view;
    [[UITabBar appearance] insertSubview:view atIndex:0];
    self.delegate=self;
    self.selectedIndex=0;
    [self.myDelegate selectIndex:self.selectedIndex];
    self.centView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0f];
    // Do any additional setup after loading the view.
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(self.selectedIndex==0){
        self.centView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0f];
    }else{
        self.centView.backgroundColor=RBG(10,14,19);
    }
    NSLog(@"我点击了%ld",self.selectedIndex);
    [self.myDelegate selectIndex:self.selectedIndex];
    ///测试测试
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
