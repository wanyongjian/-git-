//
//  ViewController.m
//  YJTangguo
//
//  Created by wanyongjian on 2017/7/18.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "YJTableViewController.h"
#import "TopicModel.h"
#import "TopicCell.h"

@interface YJTableViewController () <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSMutableArray *topicModelArray;
@end

@implementation YJTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:self.tableview];
        [self loadData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadData{
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"json"]];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSString *mes = dict[@"msg"];
//    NSString *status = dict[@"status"];
//    NSString *ts = dict[@"ts"];
    NSArray *dataArr = dict[@"data"][@"topic"];
//    NSLog(@"%@",dataArr);
    for (NSDictionary *topic in dataArr) {
        TopicModel *model = [TopicModel mj_objectWithKeyValues:topic];
        [self.topicModelArray addObject:model];
    }
    NSLog(@"%@",self.topicModelArray);
    
    [self.tableview reloadData];
}
#pragma makr - table代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.topicModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"reuse";
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        
        cell = [[TopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.topicModel = self.topicModelArray[indexPath.row];
    }
    return cell;
}


#pragma mark - lazyload
- (UITableView *)tableview{
    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = [UIColor blueColor];
        headView.frame = CGRectMake(0, 0, KScreenWidth, 242);
        _tableview.tableHeaderView = headView;
    }
    return _tableview;
}

- (NSMutableArray *)topicModelArray{
    if (!_topicModelArray) {
        
        _topicModelArray = [[NSMutableArray alloc]init];
    }
    return _topicModelArray;
}
@end
