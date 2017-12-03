//
//  BaseViewController.m
//  smartcar
//
//  Created by lbs on 15/4/20.
//  Copyright (c) 2015年 lbs. All rights reserved.
//

#import "BaseViewController.h"

#import "BaseView.h"
#import "DZComponent.h"
#define kNaviBarButtonFontSize 14

@interface BaseViewController (){
    dispatch_source_t _timer;
}

@property (nonatomic, strong) UILabel *lblPageTitle;
@property (nonatomic, strong) DZComponent* component;

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *className = NSStringFromClass([self class]);
    NSLog([NSString stringWithFormat:@"当前%@ ViewController >> [ %@ ]",className ]) ;
//#if VER_TYPE == 3
  
//#else
//    
//#endif
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)dealloc{
//<<<<<<< .mine
////    NSString *className = NSStringFromClass([self class]);
////    UIAlertView *aler =[[UIAlertView alloc] initWithTitle:@"释放" message:className delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
////    [aler show];
//=======
//    NSString *className = NSStringFromClass([self class]);
//    UIAlertView *aler =[[UIAlertView alloc] initWithTitle:@"释放" message:className delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//    [aler show];
    NSString *str =NSStringFromClass([self class]);
    NSLog(@"%@被释放了",NSStringFromClass([self class]));
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UILabel *lab = (UILabel *)[_navigationBarView viewWithTag:22];
    NSString *st = lab.text;
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"%@( %@ )",st,className);


}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//#if VER_TYPE == 3
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"className--%@",className);
//    [OperateService endLogPageView:className];
//#else
//    
//#endif
}

//设置导航栏颜色
- (void)setNavigationBar
{
    _navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20+44)];
    UIColor *color = SEUD_Color_TitleBottom_gray_9;
    _navigationBarView.backgroundColor = color;
    [self.view addSubview:_navigationBarView];
    [_navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0.0);
        make.left.equalTo(@0.0);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@64);
    }];
    _baseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 37, 9, 14)];
    [_baseImageView setImage:[UIImage imageNamed:@"btn_back_white"]];
    [_navigationBarView addSubview:_baseImageView];
    _baseImageView.hidden = YES;
}

- (void)setMakeNavViewToTop:(BOOL)makeNavViewToTop{
    if (makeNavViewToTop == YES) {
        [self.view bringSubviewToFront:_navigationBarView];
        _navigationBarView.backgroundColor = [UIColor clearColor];
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
}

- (void)addTitleView:(NSString *)title
{
    self.lblPageTitle.text = title;
    if (_modalType ==YES) {
        _baseImageView.hidden = NO;
    }
}

- (UILabel *)lblPageTitle
{
    if (!_lblPageTitle) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 31, ScreenWidth-80, 22)];
        label.tag=22;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = SEUD_Color_White_10;
        label.font = [UIFont boldSystemFontOfSize:17];
        //    label.adjustsFontSizeToFitWidth = YES;
        [_navigationBarView addSubview:label];
        _lblPageTitle = label;
    }
    return _lblPageTitle;
}


- (void)UpTitleView:(NSString *)title
{
    UILabel *lab = (UILabel *)[_navigationBarView viewWithTag:22];
    lab.text=title;
}

- (void)addCustomTitleView:(nullable NSString *)title image:(nullable UIImage *)image{
    CGFloat length = [SeudPublic textHeightStr:title font:16 labelWidth:150].width;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, length, 22)];
    lable.tag = 23;
    lable.textColor = SEUD_Color_White_10;
    lable.font = [UIFont systemFontOfSize:16];
    lable.text = title;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(length, 5, 12, 12)];
    imageV.tag = 24;
    imageV.userInteractionEnabled = YES;
    CGFloat imageWidth = 12;
    if (image != nil) {
        imageV.image = image;
    }else{
        imageWidth = 0;

    }

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth-length - imageWidth)/ 2.0, 31, length + imageWidth, 22)];
    view.tag = 25;
    [view addSubview:lable];
    [view addSubview:imageV];
    
    [_navigationBarView addSubview:view];
    if (_modalType == YES) {
        _baseImageView.hidden = NO;
    }
}
- (void)UpCustomTitleView:(nullable NSString *)title image:(nullable UIImage *)image{
    CGFloat length = [SeudPublic textHeightStr:title font:16 labelWidth:150].width;
    UILabel *label = [self.view viewWithTag:23];
    label.width = length;
    label.text = title;
    UIImageView *imageV = [self.view viewWithTag:24];
    imageV.left = length;
    imageV.image = image;
    UIView *view = [self.view viewWithTag:25];
    view.left = (ScreenWidth - length - imageV.width) / 2.0;
    view.width = length + imageV.width;
    
}

-(UILabel*)isGetTitleLable{
    UILabel *lab = (UILabel *)[_navigationBarView viewWithTag:22];
    return lab;
}

- (void)setLeftButton:(MEOBarButton *)leftButton
{
    _leftButton = leftButton;
    [_navigationBarView addSubview:_leftButton];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.size.equalTo(MASBoxValue(CGSizeMake(80, 60)));
    }];
}


- (void)setLeftButtons:(NSArray<MEOBarButton *> *)leftButtons{
    _leftButtons = [leftButtons copy];
    MEOBarButton *button = (MEOBarButton *)[leftButtons firstObject];
    [_navigationBarView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(31));
        make.left.equalTo(@(0));
        make.size.equalTo(MASBoxValue(CGSizeMake(20, 30)));
    }];
    
    for (int i = 1; i < _leftButtons.count; i++)
    {
        MEOBarButton *button01 = (MEOBarButton *)_leftButtons[i];
        MEOBarButton *button02 = (MEOBarButton *)_leftButtons[i - 1];
        [_navigationBarView addSubview:button01];
        
        [button01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(28));
            make.left.equalTo(button02.mas_right).offset(10);
            make.size.equalTo(MASBoxValue(CGSizeMake(40, 30)));
        }];
    }
}

- (void)setBigLeftButton:(MEOBarButton *)bigLeftButton{
    _leftButton = bigLeftButton;
    [_navigationBarView addSubview:_leftButton];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.size.equalTo(MASBoxValue(CGSizeMake(120, 60)));
    }];
}

- (void)setRightButton:(MEOBarButton *)rightButton
{
    _rightButton = rightButton;
    [_navigationBarView addSubview:_rightButton];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(22));
        make.right.equalTo(@(15));
        make.size.equalTo(MASBoxValue(CGSizeMake(75, 40)));
    }];
}

- (void)setBigRightButton:(MEOBarButton *)bigRightButton{
    _bigRightButton = bigRightButton;
    [_navigationBarView addSubview:_bigRightButton];
    [_bigRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(31));
        make.right.equalTo(@(-5));
        make.size.equalTo(MASBoxValue(CGSizeMake(100, 22)));
    }];
}

- (void)setRightButtons:(NSArray *)rightButtons
{
    _rightButtons = [rightButtons copy];
    MEOBarButton *button = (MEOBarButton *)[rightButtons firstObject];
    [_navigationBarView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(27));
        make.right.equalTo(@(-10));
        make.size.equalTo(MASBoxValue(CGSizeMake(30, 30)));
    }];
    
    for (int i = 1; i < _rightButtons.count; i++)
    {
        MEOBarButton *button01 = (MEOBarButton *)_rightButtons[i];
        MEOBarButton *button02 = (MEOBarButton *)_rightButtons[i - 1];
        [_navigationBarView addSubview:button01];
        
        [button01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(27));
            make.right.equalTo(button02.mas_left).offset(-10);
            make.size.equalTo(MASBoxValue(CGSizeMake(30, 30)));
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = SEUD_Color_Bg_Black_6;
    self.view.backgroundColor = color;
    [self setNavigationBar];
    [self configLeftNavView];
    // Do any additional setup after loading the view.
}

-(void)configLeftNavView{
    [_navigationBarView addSubview:self.leftNavView];
    [_leftNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(20));
        make.left.equalTo(@(0));
        make.size.equalTo(MASBoxValue(CGSizeMake(100, 44)));
    }];
    
}

- (UIView *)leftNavView
{
    if (!_leftNavView) {
        _leftNavView = [[UIView alloc] init];
        [_leftNavView setBackgroundColor:[UIColor clearColor]];
    }
    return _leftNavView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//////////////////////////////////////////////////////////


-(void)addSubView:(UIView *)view{
    [self.view addSubview:view];
    if ( [view isKindOfClass:[BaseView class]] ){
        ((BaseView*)view).parent = self;
    }
}

-(void)addSubViewFalg:(UIView *)view{
    if ( [view isKindOfClass:[BaseView class]] ){
        ((BaseView*)view).parent = self;
    }
}

-(void)postEvent:(NSString *)name{
    [self postEvent:name data:nil];
}

-(void)postEvent:(NSString *)name data:(id)data{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ( self.model ){
            [self.model pushEvent:name sender:self data:data];
        }
    });
}

#pragma mark - DZComponent

-(void)render{
    [self.component clearDiff];
}

-(NSDictionary*)schema{
    return nil;
}

-(NSDictionary*)readSchema:(NSString *)name{
    return [self.component readSchema:name];
}

-(BOOL)diff:(NSString *)key{
    return [self.component diff:key];
}

-(void)clearDiff{
    [self.component clearDiff];
}

-(NSString*)checkSchema:(id)prototype data:(id)value{
    return [self.component checkSchema:prototype data:value];
}

-(DZComponent*)component{
    if ( !_component ){
        _component = [[DZComponent alloc] init];
        _component.wrapper = self;
    }
    return _component;
}

-(NSDictionary*)state{
    return self.component.state;
}

-(void)setState:(NSDictionary *)state{
    self.component.state = state;
}

-(void)startRandomState{
    if ( !_timer ){
        dispatch_queue_t queue = dispatch_get_main_queue();
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), 3*NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^()
                                          {
                                              [self setState:[self.component randomState:self.schema]];
                                          });
        dispatch_resume(_timer);
    }
}

-(void)stopRandomState{
    if ( _timer ){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}


//////////////////////////////////////////////////////////

@end

@implementation MEOBarButton

- (instancetype)initWithTitle:(NSString *)title Target:(id)target Action:(SEL)action
{
    self = [super init];
    if(self)
    {
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:kNaviBarButtonFontSize];
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithBackGroundImg:(UIImage *)image Target:(id)target Action:(SEL)action
{
    self = [super init];
    if(self)
    {
        [self setBackgroundImage:image forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:kNaviBarButtonFontSize];
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (instancetype)initWithImg:(UIImage *)image Target:(id)target Action:(SEL)action
{
    self = [super init];
    if(self)
    {
        [self setImage:image forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.font = [UIFont systemFontOfSize:kNaviBarButtonFontSize];
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;

}


- (instancetype)initWithCustomView:(UIButton *)button Target:(id)target Action:(SEL)action{
    self = [super init];
    if (self) {
        self = button;
        
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end

