//
//  YJHomeViewController.m
//  YJTangguo
//
//  Created by wanyongjian on 2017/7/19.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "YJHomeViewController.h"
#import "YJTableViewController.h"
#import "UILabel+size.h"
#define FONTMIN 14.0
#define FONTMAX 16.0
#define SEGINSET 20
@interface YJHomeViewController () <UIScrollViewDelegate>


@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

//分类相关
@property (nonatomic,strong) UIScrollView *segmentScrollView;
@property (nonatomic,strong) NSMutableArray *cateGoryArray;
@property (nonatomic,strong) UIImageView *currentSelectedImgView;
@property (nonatomic,strong) NSMutableArray *titleButtonArray;//存储button数组
@property (nonatomic,strong) UIButton *previousButton;//记录上个button

@property (nonatomic,strong) UIScrollView *bottomScrollView;

@end

@implementation YJHomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.titleButtonArray = [@[] mutableCopy];
        
        [self.view addSubview:self.bottomScrollView];
        [self.view addSubview:self.cycleScrollView];
        [self.view addSubview:self.segmentScrollView];
        

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)segmentClicked:(UIButton *)button{
    _previousButton.selected = NO;
    button.selected = YES;
    _previousButton = button;
    
    NSInteger index = [self.titleButtonArray indexOfObject:button];

    
    [UIView animateWithDuration:0.2 animations:^{
        
        if (index == 0) {
            self.currentSelectedImgView.frame = CGRectMake(CGRectGetMinX(button.frame), self.segmentScrollView.frame.size.height-2, button.frame.size.width, 2);
        }else{
            UIButton *preBtn = self.titleButtonArray[index-1];
            [self.segmentScrollView scrollRectToVisible:CGRectMake(CGRectGetMinX(preBtn.frame)-SEGINSET, 0, self.segmentScrollView.frame.size.width, self.segmentScrollView.frame.size.height) animated:YES];
            self.currentSelectedImgView.frame = CGRectMake(CGRectGetMinX(button.frame), self.segmentScrollView.frame.size.height-2, button.frame.size.width, 2);
        }
        self.bottomScrollView.contentOffset = CGPointMake(index * KScreenWidth, 0);
    }];
}

#pragma mark - scrollview 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView != self.bottomScrollView) {
        return;
    }
    
    int index = scrollView.contentOffset.x/scrollView.frame.size.width;
    UIButton *selectBtn = self.titleButtonArray[index];
    _previousButton.selected = NO;
    selectBtn.selected = YES;
    _previousButton = selectBtn;
    
    [UIView animateWithDuration:0.1 animations:^{
       
        if (index == 0) {
            UIButton *previousBtn = self.titleButtonArray[index];
            CGFloat x = CGRectGetMinX(previousBtn.frame);
            self.currentSelectedImgView.frame = CGRectMake(x, selectBtn.frame.size.height-2, selectBtn.frame.size.width, 2);
        }else{
            UIButton *previousBtn = self.titleButtonArray[index-1];
            CGFloat x = CGRectGetMinX(previousBtn.frame);
            
            [self.segmentScrollView scrollRectToVisible:CGRectMake(x-SEGINSET, 0, self.segmentScrollView.frame.size.width, self.segmentScrollView.frame.size.height) animated:YES];
            
            self.currentSelectedImgView.frame = CGRectMake(CGRectGetMinX(selectBtn.frame), selectBtn.frame.size.height-2, selectBtn.frame.size.width, 2);
        }
    }];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    UITableView *table = (UITableView *)object;
    CGFloat offsetY = table.contentOffset.y;
    
    if (offsetY > 0 && offsetY < (200-64)) {
        CGRect rect = self.cycleScrollView.frame ;
        rect.origin.y = offsetY;
        self.cycleScrollView.frame = CGRectMake(rect.origin.x, -rect.origin.y, rect.size.width, rect.size.height);
        
        CGRect rectSeg = self.segmentScrollView.frame;
        rectSeg.origin.y = offsetY;
        self.segmentScrollView.frame = CGRectMake(rectSeg.origin.x, 200-rectSeg.origin.y, rectSeg.size.width, rectSeg.size.height);
    } else if (offsetY < 0){
        self.cycleScrollView.frame = (CGRect){0,0,KScreenWidth,200};
        self.segmentScrollView.frame = CGRectMake(0, 200, KScreenWidth, 40);
    } else if (offsetY > 136){
        self.cycleScrollView.frame = (CGRect){0,-136,KScreenWidth,200};
        self.segmentScrollView.frame = CGRectMake(0, 200-136, KScreenWidth, 40);
    }

}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
#pragma mark - lazyload
- (NSMutableArray *)cateGoryArray{
    if (!_cateGoryArray) {
        _cateGoryArray = [@[@"推荐",@"原创",@"热门",@"美食",@"生活",@"设计感",@"家居",@"礼物",@"阅读",@"运动健身",@"旅行户外"] mutableCopy];
    }
    return _cateGoryArray;
}

- (UIImageView *)currentSelectedImgView{
    if (!_currentSelectedImgView) {
        _currentSelectedImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nar_bgbg"]];
    }
    return _currentSelectedImgView;
}
- (UIScrollView *)segmentScrollView{
    
    if (!_segmentScrollView) {
        
        _segmentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, KScreenWidth, 40)];
        _segmentScrollView.backgroundColor = [UIColor whiteColor];
        _segmentScrollView.showsHorizontalScrollIndicator = NO;
        _segmentScrollView.showsHorizontalScrollIndicator = NO;
        [_segmentScrollView addSubview:self.currentSelectedImgView];
        
        CGFloat btnOffset = 0;
        for (NSInteger i=0; i<self.cateGoryArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:self.cateGoryArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(segmentClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:FONTMIN];
            CGSize btnSize = [UILabel labelSizeFromFont:FONTMAX andString:self.cateGoryArray[i]];
            
            CGFloat btnX = btnOffset+SEGINSET;
            button.frame = CGRectMake(btnX, 0, btnSize.width, 40);
            [_segmentScrollView addSubview:button];
            [self.titleButtonArray addObject:button];
            
            btnOffset = CGRectGetMaxX(button.frame);
            
            //默认选中第一个
            if (i == 0) {
                button.selected = YES;
                _currentSelectedImgView.frame = CGRectMake(SEGINSET, _segmentScrollView.frame.size.height-2, button.frame.size.width, 2);
                _previousButton = button;
            }
        }
        
        _segmentScrollView.contentSize = CGSizeMake(btnOffset+SEGINSET, 40);
    }
    
    return _segmentScrollView;
}

- (SDCycleScrollView *)cycleScrollView{
    
    if (!_cycleScrollView) {
        
        NSMutableArray *imgArray = [[NSMutableArray alloc]init];
        for (int i=1 ; i<9 ; i++) {
            NSString *imgName = [NSString stringWithFormat:@"cycle_%02d.jpg",i];
            [imgArray addObject:imgName];
        }
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:(CGRect){0,0,KScreenWidth,200} imageNamesGroup:imgArray];
    }
    return _cycleScrollView;
}

- (UIScrollView *)bottomScrollView{
    if (!_bottomScrollView) {
        
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.showsVerticalScrollIndicator = NO;
        _bottomScrollView.delegate = self;
        
        for (NSInteger i = 0; i<self.cateGoryArray.count; i++) {
            YJTableViewController *controller = [[YJTableViewController alloc]init];
            controller.view.frame = CGRectMake(KScreenWidth*i, 0, KScreenWidth, KScreenHeight);
            [self addChildViewController:controller];
            [_bottomScrollView addSubview:controller.view];
            
            [controller.tableview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        }
        _bottomScrollView.contentSize = CGSizeMake(KScreenWidth*self.cateGoryArray.count, 0);
    }
    return _bottomScrollView;
}
@end
