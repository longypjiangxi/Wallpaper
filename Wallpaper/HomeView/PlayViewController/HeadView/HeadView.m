//
//  HeadView.m
//  Wallpaper
//
//  Created by 曾 on 2021/12/16.
//

#import "HeadView.h"

@interface HeadView()
@property (nonatomic, retain)UIView* titleView;
@property (nonatomic, retain)UILabel* refreshLabel;
@property (nonatomic, retain)NSMutableArray* btnArr;
@property (nonatomic, retain)UIView* lineView;
@property (nonatomic, retain)UIButton* searchBtn;
@property (nonatomic, retain)UIImageView* refreshImageView;
@end

@implementation HeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
//        self.backgroundColor=[UIColor whiteColor];
        self.btnArr=[NSMutableArray new];
        self.titleView.alpha=1;
        self.searchBtn.alpha=1;
        self.refreshLabel.alpha=0;
        [self initHeaderView];
    }
    return self;
}
-(void)initHeaderView
{
        
}
-(UIView*)titleView
{
    if(!_titleView)
    {
        _titleView=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,topHeight)];
        NSArray* array=@[@"关注",@"推荐"];
        for (int i=0;i<2;i++)
        {
            UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-wid(180))/2.0-wid(20)+i*(wid(90)+wid(10)),StatusBarHeight+(topHeight-StatusBarHeight-wid(40))/2.0,wid(90),wid(40))];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:FontSize(16)]];
            btn.titleLabel.adjustsFontSizeToFitWidth=YES;
            btn.titleLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
            btn.tag=200+i;
            if(i==1)
            {
                btn.selected=YES;
                _lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.frame.origin.x+(wid(90)-wid(40))/2.0,btn.frame.origin.y+wid(50),wid(40),wid(4))];
                _lineView.backgroundColor=[UIColor whiteColor];
                _lineView.layer.masksToBounds=YES;
                _lineView.layer.cornerRadius=wid(4)/2.0;
                [_titleView addSubview:_lineView];
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_btnArr addObject:btn];
            [_titleView addSubview:btn];
        }
        [self addSubview:_titleView];
    }
    return _titleView;
}
-(UILabel*)refreshLabel
{
    if(!_refreshLabel)
    {
        _refreshLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,StatusBarHeight+ (topHeight-StatusBarHeight-wid(40))/2.0+wid(40),SCREEN_WIDTH,wid(40))];
        _refreshLabel.text=@"下拉刷新内容";
        _refreshLabel.textColor=[UIColor whiteColor];
        _refreshLabel.textAlignment=NSTextAlignmentCenter;
        _refreshLabel.adjustsFontSizeToFitWidth=YES;
        _refreshLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        [_refreshLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        [self addSubview:_refreshLabel];
    }
    return _refreshLabel;
}

-(UIButton*)searchBtn
{
    if(!_searchBtn)
    {
        _searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-wid(20)-wid(40), StatusBarHeight+(topHeight-StatusBarHeight-wid(40))/2.0,wid(40),wid(40))];
        [_searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchBtn];
    }
    return _searchBtn;
}
-(UIImageView*)refreshImageView
{
    if(!_refreshImageView)
    {
        _refreshImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-wid(20)-wid(80), StatusBarHeight+ (topHeight-StatusBarHeight-wid(40))/2.0+wid(40),wid(80),wid(14))];
        _refreshImageView.image=[UIImage imageNamed:@"loading10"];
        _refreshImageView.alpha=0;
        NSMutableArray* imageArr=[NSMutableArray new];
        for(int i=1;i<22;i++)
        {
            UIImage* image=[UIImage imageNamed:[NSString stringWithFormat:@"loading%d",i]];
            [imageArr addObject:image];
        }
        _refreshImageView.animationImages=imageArr;
        _refreshImageView.animationDuration=0.5;
        [self addSubview:_refreshImageView];
    }
    return _refreshImageView;
}
-(void)upDateHeight:(CGFloat)height
{
    NSLog(@"%lf",height);
//    height=height/3.0;
    CGFloat max=-topHeight+(StatusBarHeight+(topHeight-StatusBarHeight-wid(40))/2.0);
    CGFloat minRefresh=topHeight-(StatusBarHeight+ (topHeight-StatusBarHeight-wid(40))/2.0+wid(40));
    if(height<max)
    {
        height=max;
    }
    self.titleView.frame=CGRectMake(self.titleView.frame.origin.x,height/2.0*-1,self.titleView.frame.size.width,self.titleView.frame.size.height);
    self.titleView.alpha=1.0-self.titleView.frame.origin.y*2.0/(topHeight+max)*1.0;
    self.searchBtn.frame=CGRectMake(self.searchBtn.frame.origin.x,self.titleView.frame.origin.y+StatusBarHeight+ (topHeight-StatusBarHeight-wid(40))/2.0,self.searchBtn.frame.size.width,self.searchBtn.frame.size.height);
    self.searchBtn.alpha=self.titleView.alpha;

    self.refreshLabel.alpha=1-self.titleView.alpha;
    self.refreshLabel.frame=CGRectMake(self.refreshLabel.frame.origin.x,StatusBarHeight+ (topHeight-StatusBarHeight-wid(40))/2.0+wid(40)+minRefresh*self.refreshLabel.alpha,self.refreshLabel.frame.size.width,self.refreshLabel.frame.size.height);
    self.refreshImageView.alpha=self.refreshLabel.alpha;
    self.refreshImageView.frame=CGRectMake(self.refreshImageView.frame.origin.x,self.refreshLabel.frame.origin.y+(wid(40)-wid(14))/2.0,self.refreshImageView.frame.size.width,self.refreshImageView.frame.size.height);
}
-(void)LetGo:(BOOL)isof
{
    CGFloat max=-topHeight+(StatusBarHeight+(topHeight-StatusBarHeight-wid(40))/2.0);
    CGFloat time=0.5*(max/2.0*-1.0-self.titleView.frame.origin.y);
    [UIView animateKeyframesWithDuration:time delay:0 options:0 animations:^{
        self.titleView.frame=CGRectMake(0,0,SCREEN_WIDTH,topHeight);
        self.titleView.alpha=1;
        self.refreshLabel.alpha=0;
        self.refreshLabel.frame=CGRectMake(0,StatusBarHeight+ (topHeight-StatusBarHeight-wid(40))/2.0+wid(40),SCREEN_WIDTH,wid(40));
        self.searchBtn.alpha=!isof;
        self.refreshImageView.alpha=isof;
        self.searchBtn.frame=CGRectMake(SCREEN_WIDTH-wid(20)-wid(40), StatusBarHeight+(topHeight-StatusBarHeight-wid(40))/2.0,wid(40),wid(40));
        self.refreshImageView.frame=CGRectMake(SCREEN_WIDTH-wid(20)-wid(80), StatusBarHeight+ (topHeight-StatusBarHeight-wid(40))/2.0+wid(40),wid(80),wid(14));
    } completion:^(BOOL finished){
        
    }];
}
-(void)searchBtnAction
{
    
}
-(void)btnAction:(UIButton*)btn
{
    NSLog(@"%ld",btn.tag);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
