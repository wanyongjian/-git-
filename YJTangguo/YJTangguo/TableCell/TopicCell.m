//
//  TopicCell.m
//  YJTangguo
//
//  Created by wanyongjian on 2017/7/18.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "TopicCell.h"

@interface TopicCell ()

@property(nonatomic, strong) UIImageView *topicImgView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *userNameLable;
@property(nonatomic, strong) UIImageView *pvImgView;
@property(nonatomic, strong) UILabel *pvLabel;
@property(nonatomic, strong) UIImageView *starImgView;
@property(nonatomic, strong) UILabel *starLabel;
@property(nonatomic, strong) UIView  *bottomCenterView;


@end



@implementation TopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.topicImgView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.userNameLable];
        [self.contentView addSubview:self.pvImgView];
        [self.contentView addSubview:self.pvLabel];
        [self.contentView addSubview:self.starImgView];
        [self.contentView addSubview:self.starLabel];
        [self.contentView addSubview:self.bottomCenterView];
        
    }
    return self;
}

- (void)setTopicModel:(TopicModel *)topicModel{
    [_topicImgView sd_setImageWithURL:[NSURL URLWithString:topicModel.pic] placeholderImage:nil];
    _titleLabel.text = topicModel.title;
    _userNameLable.text = topicModel.user.nickname;
    _pvLabel.text = topicModel.views;
    _starLabel.text = topicModel.likes;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_topicImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(200);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.right.mas_equalTo(self.contentView).offset(-20);
        make.top.mas_equalTo(self.contentView).offset(20);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topicImgView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self);
    }];
    
    [_userNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(_bottomCenterView.mas_left);
    }];
    
    [_pvImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userNameLable.mas_right).offset(10);
        make.top.mas_equalTo(_userNameLable.mas_top);
        make.width.height.mas_equalTo(11);
    }];
    
    [_pvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_pvImgView.mas_right).offset(5);
        make.top.mas_equalTo(_pvImgView.mas_top);
    }];
    
    [_starImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_pvLabel.mas_right).offset(5);
        make.top.mas_equalTo(_pvLabel.mas_top);
        make.width.height.mas_equalTo(11);
    }];
    
    [_starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_starImgView.mas_right).offset(5);
        make.top.mas_equalTo(_starImgView.mas_top);
    }];
    
    [_bottomCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userNameLable.mas_left);
        make.right.mas_equalTo(_starLabel.mas_right);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(_userNameLable.mas_height);
    }];
}


#pragma mark - lazyload
- (UIImageView *)topicImgView{
    if (!_topicImgView) {
        
        _topicImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"recomand_01.jpg"]];

    }
    return _topicImgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.text = @"测试主题";
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

- (UILabel *)userNameLable{
    if (!_userNameLable) {
        _userNameLable = [[UILabel alloc]init];
        _userNameLable.font = [UIFont systemFontOfSize:12];
        _userNameLable.text = @"小糖君";
        _userNameLable.textColor = [UIColor grayColor];
    }
    return _userNameLable;
}

- (UIImageView *)pvImgView
{
    if (!_pvImgView) {
        _pvImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_watch"]];
    }
    return _pvImgView;
}

- (UILabel *)pvLabel{
    if (!_pvLabel) {
        _pvLabel = [[UILabel alloc]init];
        _pvLabel.text = @"1000";
        _pvLabel.textColor = [UIColor grayColor];
        _pvLabel.font = [UIFont systemFontOfSize:11];
    }
    return _pvLabel;
}

- (UIImageView *)starImgView{
    if (!_starImgView) {
        _starImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_like"]];
    }
    return _starImgView;
}

- (UILabel *)starLabel{
    if(!_starLabel){
        _starLabel = [[UILabel alloc]init];
        _starLabel.text = @"1000";
        _starLabel.textColor = [UIColor grayColor];
        _starLabel.font = [UIFont systemFontOfSize:11];
    }
    return _starLabel;
}

- (UIView *)bottomCenterView{
    if (!_bottomCenterView) {
        _bottomCenterView = [[UIView alloc]init];
    }
    return _bottomCenterView;
}


@end
