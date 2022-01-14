//
//  LastNewView.m
//  Wallpaper
//
//  Created by 曾 on 2021/12/16.
//

#import "LastNewView.h"
#import "PlayTableViewCell.h"
@interface LastNewView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain)UITableView* tableview;
@property (nonatomic, retain)ObjectAFNetWorking* objectAFN;
@property (nonatomic, retain)NSMutableArray*     dataSource;
@property (nonatomic, assign)CGFloat             scrollHeight;
@end

@implementation LastNewView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.objectAFN=[[ObjectAFNetWorking alloc]init];
        self.dataSource=[NSMutableArray new];
        self.scrollHeight=0;
        [self initAllView];
    }
    return self;
}
-(void)initAllView
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableview.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [_tableview registerNib:[UINib nibWithNibName:@"PlayTableViewCell" bundle:nil] forCellReuseIdentifier:@"PlayTableViewCell"];
    _tableview.pagingEnabled=YES;
    _tableview.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0f];
    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    UITableView.appearance.estimatedRowHeight = 0;
    UITableView.appearance.estimatedSectionFooterHeight = 0;
    UITableView.appearance.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever ;
    } else {
    }
    _tableview.contentInset = UIEdgeInsetsMake(0,0,0, 0);
    _tableview.scrollIndicatorInsets = _tableview.contentInset;
    [self addSubview:_tableview];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"x==%lf",scrollView.contentOffset.y);
    self.scrollHeight+=self.tableview.contentOffset.y;
    if(self.tableview.contentOffset.y<0)
    {
        self.tableview.contentOffset=CGPointMake(0,0); //重新设置为0
    }
    CGFloat height=self.tableview.frame.size.height; //当前tabbleview的高度
    if(self.tableview.contentSize.height>height)
    {
        if(self.tableview.contentOffset.y>=(self.tableview.contentSize.height-height))
        {
            NSLog(@"我到最后了");
            self.tableview.contentOffset=CGPointMake(0, self.tableview.contentSize.height-height);
        }
    }else
    {
        self.tableview.contentOffset=CGPointMake(0,0); //重新设置为0
    }
    if(self.scrollHeight<=-topHeight)
    {
        self.scrollHeight=-topHeight;
    }
    if(self.scrollHeight<0)
    {
        self.tableview.contentOffset=CGPointMake(0,0); //重新设置为0
    }else if(self.tableview.contentOffset.y>0)
    {
        self.scrollHeight=0;
    }
    [self.myDelegate RefreshHeadHeight:self.scrollHeight];
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    BOOL isof=false;
    if(self.scrollHeight<=-topHeight)
    {
        isof=YES;
    }
    self.scrollHeight=0;
    [self.myDelegate LetGo:isof];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.scrollHeight=0;
    [self.myDelegate RefreshHeadHeight:self.scrollHeight];

}
-(void)getData
{
//    self.obj
//    [self.objectAFN getUrlStr:@"" finish:^(id  _Nonnull dataString) {
//
//        } andError:^(NSError * _Nonnull error) {
//
//        }];
}
#pragma mark - tableview delegate and datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"PlayTableViewCell"];
    CGFloat    a = arc4random()%255;
    CGFloat    b = arc4random()%255;
    CGFloat    c = arc4random()%255;
    cell.backgroundColor=RBG(a,b,c);
    return cell;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
