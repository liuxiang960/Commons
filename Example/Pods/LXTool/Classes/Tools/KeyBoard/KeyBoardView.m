//
//  KeyBoardView.m
//  keyboardDemo
//
//  Created by Souyun on 16/3/17.
//  Copyright © 2016年 Souyun. All rights reserved.
//

#import "KeyBoardView.h"

#define keyHeight 220
#define keyWidth [UIScreen mainScreen].bounds.size.width

static KeyBoardView *sharedInstanceType1 = nil;
static KeyBoardView *sharedInstanceType2 = nil;
static KeyBoardView *sharedInstanceType3 = nil;
static KeyBoardView *sharedInstanceType4 = nil;
static KeyBoardView *sharedInstanceType5 = nil;
static KeyBoardView *sharedInstanceType9 = nil;

@interface KeyBoardView ()

{
    struct {
        unsigned int numberKeyBoardBackSpace : 1;
        unsigned int keybooarSearch : 1;
        unsigned int keyboardInputlongString : 1;
        unsigned int keyboardSure : 1;
        unsigned int keyboardLogin : 1;
        unsigned int keyboardNumLoadString : 1;
    }_delegateFlags;
}

@property (nonatomic, strong) NSMutableArray *numberKeyBtnArray;
@property (nonatomic, strong) NSMutableArray *abcKeyBtnArray;
@property (nonatomic, strong) NSMutableArray *keyType3BtnArray;
@property (nonatomic, strong) NSMutableArray *keyType4BtnArray;
@property (nonatomic, strong) NSMutableArray *keyType5BtnArray;
@property (nonatomic, strong) NSMutableArray *keyType6BtnArray;
@property (nonatomic, strong) NSMutableArray *keyType7BtnArray;
@property (nonatomic, strong) NSMutableArray *keyType8BtnArray;

@end

@implementation KeyBoardView

+ (instancetype)sharedInstance:(NSInteger)keyBoardType{
    return [KeyBoardView sharedInstance:keyBoardType withString:@""];
}

+ (instancetype)sharedInstance:(NSInteger)keyBoardType withString:(NSString *)string delegate:(id<keyBoardDelegate>)delegate{
    KeyBoardView *result = [KeyBoardView sharedInstance:keyBoardType withString:string];
    result.delegate = delegate;
    return result;
}

+ (instancetype)sharedInstance:(NSInteger)keyBoardType withString:(NSString *)string
{
    
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{
    
        CGRect frame = CGRectMake(0, 200, 367, 230);
        sharedInstanceType1 = [[KeyBoardView alloc] initWithFrame:frame];
        [sharedInstanceType1 initKeyBoardData:@""];
        [sharedInstanceType1 initCreateView];
        [sharedInstanceType1 choseKeyType:1];
        
        sharedInstanceType2 = [[KeyBoardView alloc] initWithFrame:frame];
        [sharedInstanceType2 initKeyBoardData:@""];
        [sharedInstanceType2 initCreateView];
        [sharedInstanceType2 choseKeyType:2];
        
        sharedInstanceType3 = [[KeyBoardView alloc] initWithFrame:frame];
        [sharedInstanceType3 initKeyBoardData:@""];
        [sharedInstanceType3 initCreateView];
        [sharedInstanceType3 choseKeyType:3];
        
        sharedInstanceType4 = [[KeyBoardView alloc] initWithFrame:frame];
        [sharedInstanceType4 initKeyBoardData:@""];
        [sharedInstanceType4 initCreateView];
        [sharedInstanceType4 choseKeyType:4];
        
        sharedInstanceType5 = [[KeyBoardView alloc] initWithFrame:frame];
        [sharedInstanceType5 initKeyBoardData:@""];
        [sharedInstanceType5 initCreateView];
        [sharedInstanceType5 choseKeyType:7];
    
        sharedInstanceType9 = [[KeyBoardView alloc] initWithFrame:frame];
        [sharedInstanceType9 initKeyBoardData:@""];
        [sharedInstanceType9 initCreateView];
        [sharedInstanceType9 choseKeyType:9];
    
    
//    });
    
    KeyBoardView *result;
    if (!string || [@"" isEqualToString:string]) {
        string = @"登录";
    }
    switch (keyBoardType) {
        case 1:
        {
            result = sharedInstanceType1;
        }
            break;
        case 2:
        {
            result = sharedInstanceType2;
        }
            break;
        case 3:
        {
            result = sharedInstanceType3;
        }
            break;
        case 4: case 5: case 6: case 8:
        {
            result = sharedInstanceType4;
            [result updateBtnText:string];
        }
            break;
        case 7:
        {
            result = sharedInstanceType5;
        }
            break;
        case 9:
        {
            result = sharedInstanceType9;
        }
            break;
        default:
            break;
    }
    return result;
}

/**
 *  @author 程凯, 16-07-18 15:07:59
 *
 *  更新键盘右下角按钮文字，如: 登录 、 完成
 */
-(void)updateBtnText:(NSString *)string{
    [self initKeyBoardData:string];
    
    UIButton *btnType4 = [self.keyType4BtnArray lastObject];
    [btnType4 setTitle:string forState:UIControlStateNormal];
    
    UIButton *btnType5 = [self.keyType5BtnArray lastObject];
    [btnType5 setTitle:string forState:UIControlStateNormal];
    
    UIButton *btnType6 = [self.keyType6BtnArray lastObject];
    [btnType6 setTitle:string forState:UIControlStateNormal];
    
    UIButton *btnType8 = [self.keyType8BtnArray lastObject];
    [btnType8 setTitle:string forState:UIControlStateNormal];
    
}

/**
 *  @author 程凯, 16-07-18 15:07:44
 *
 *  初始化键盘数据
 */
-(void)initKeyBoardData:(NSString *)string{
    if (!string || [@"" isEqualToString:string]) {
        string = @"登录";
    }
    _typeString = string;
    //样式一键盘字
    NSArray *numArray1 = [NSArray arrayWithObjects:@"600",@"1",@"2",@"3",@" ", nil];
    NSArray *numArray2 = [NSArray arrayWithObjects:@"300",@"4",@"5",@"6",@" ", nil];
    NSArray *numArray3 = [NSArray arrayWithObjects:@"键盘",@"7",@"8",@"9",@"删除", nil];
    NSArray *numArray4 = [NSArray arrayWithObjects:@"ABC",@"0",@"00",@"000",@"搜索", nil];
    _numkeyNameArray = [NSMutableArray arrayWithObjects:numArray1,numArray2,numArray3,numArray4 ,nil];
    
    //样式二键盘字
    NSArray *abcArray1 = [NSArray arrayWithObjects:@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P", nil];
    NSArray *abcArray2 = [NSArray arrayWithObjects:@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L", nil];
    NSArray *abcArray3 = [NSArray arrayWithObjects:@"键盘",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"删除", nil];
    NSArray *abcArray4 = [NSArray arrayWithObjects:@"123",@"空格",@"搜索", nil];
    _abcKeyNameArray = [NSMutableArray arrayWithObjects:abcArray1,abcArray2,abcArray3,abcArray4, nil];
    
    //样式三键盘字
    NSArray *keyType3Array1 = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSArray *keyType3Array2 = [NSArray arrayWithObjects:@"4",@"5",@"6", nil];
    NSArray *keyType3Array3 = [NSArray arrayWithObjects:@"7",@"8",@"9", nil];
    NSArray *keyType3Array4 = [NSArray arrayWithObjects:@"键盘",@".",@"0",@"删除", nil];
    
    _keyType3NameArray = [NSMutableArray arrayWithObjects:keyType3Array1,keyType3Array2,keyType3Array3,keyType3Array4, nil];
    
    //样式四键盘字
    NSArray *keyType4Array1 = [NSArray arrayWithObjects:@"!",@"@",@"＃",@"$",@"%",@"^",@"&",@"*",@"(",@")", nil];
    NSArray *keyType4Array2 = [NSArray arrayWithObjects:@"'",@"\"",@"`",@"=",@"_",@":",@";",@"?",@"~",@"|", nil];
    NSArray *keyType4Array3 = [NSArray arrayWithObjects:@"+",@"-",@"\\",@"/",@"[",@"]",@"{",@"}",@"删除", nil];
    NSArray *keyType4Array4 = [NSArray arrayWithObjects:@"123",@"ABC",@",",@".",@">",@"<",string, nil];
    
    _keyType4NameArray = [NSMutableArray arrayWithObjects:keyType4Array1,keyType4Array2,keyType4Array3,keyType4Array4 ,nil];
    
    //样式五键盘字
    NSArray *keyType5Array1 = [NSArray arrayWithObjects:@"Q", @"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",nil];
    NSArray *keyType5Array2 = [NSArray arrayWithObjects:@"A", @"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",nil];
    NSArray *keyType5Array3 = [NSArray arrayWithObjects:@"大小", @"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"删除",nil];
    NSArray *keyType5Array4 = [NSArray arrayWithObjects:@"123", @"#+=",string,nil];
    _keyType5NameArray = [NSMutableArray arrayWithObjects:keyType5Array1,keyType5Array2,keyType5Array3,keyType5Array4, nil];
    
    //样式六键盘字
    NSArray *keyType6Array1 = [NSArray arrayWithObjects:@"q", @"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",nil];
    NSArray *keyType6Array2 = [NSArray arrayWithObjects:@"a", @"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",nil];
    NSArray *keyType6Array3 = [NSArray arrayWithObjects:@"大小", @"z",@"x",@"c",@"v",@"b",@"n",@"m",@"删除",nil];
    NSArray *keyType6Array4 = [NSArray arrayWithObjects:@"123", @"#+=",string,nil];
    _keyType6NameArray = [NSMutableArray arrayWithObjects:keyType6Array1,keyType6Array2,keyType6Array3,keyType6Array4, nil];
    
    //样式七键盘
    NSArray *keyType7Array1 = [NSArray arrayWithObjects:@"全仓",@"1",@"2",@"3",nil];
    NSArray *keyType7Array2 = [NSArray arrayWithObjects:@"半仓",@"4",@"5",@"6",nil];
    NSArray *keyType7Array3 = [NSArray arrayWithObjects:@"1/3仓",@"7",@"8",@"9",nil];
    NSArray *keyType7Array4 = [NSArray arrayWithObjects:@"1/4仓",@"键盘",@"0",@"删除",nil];
    
    _keyType7NameArray = [NSMutableArray arrayWithObjects:keyType7Array1,keyType7Array2,keyType7Array3,keyType7Array4, nil];
    
    //样式八键盘
    NSArray *keyType8Array1 = [NSArray arrayWithObjects:@"1",@"2", @"3",@" ",nil];
    NSArray *keyType8Array2 = [NSArray arrayWithObjects:@"4",@"5", @"6",@"删除",nil];
    NSArray *keyType8Array3 = [NSArray arrayWithObjects:@"7",@"8", @"9",@" ",nil];
    NSArray *keyType8Array4 = [NSArray arrayWithObjects:@"ABC",@"0", @"#+=",string,nil];
    _keyType8NameArray = [NSMutableArray arrayWithObjects:keyType8Array1,keyType8Array2,keyType8Array3,keyType8Array4, nil];
}

-(void)initCreateView{
    //键盘父视图
    self.bounds = CGRectMake(0, 0, keyWidth, keyHeight);
    self.backgroundColor = SEUD_Color_Bg_Black_6;
    [self creatKeyView];
}

- (id)initWithFrame:(CGRect)frame withString:(NSString *)string
{
    self = [self initWithFrame:frame];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initKeyBoardData:@""];
        [self initCreateView];
    }
    return self;
}



#pragma mark - chooseKeyBoardType
-(void)choseKeyType:(NSInteger)keyNumber
{
    _tempIndex_1 = 0;
    _tempIndex_2 = 0;
    _tempIndex_3 = 0;
    _tempIndex_4 = 0;
    
    switch (keyNumber)
    {
        case 1:
            [self creatNumkeyBoard];
            break;
            
        case 2:
            [self creatABCKeyBoard];
            break;
        case 3:
            [self creatKeyBoardType_3];
            _keyType3View.hidden = !_keyType3View.hidden;
            break;
            
        case 4: case 5: case 6: case 8://4:特殊字符键盘 5:大写键盘 6:小写键盘 8:数字键盘
//            _keyType5View.hidden=NO;
            [self createKeyBoardType_5];
            [self createKeyBoardType_4];
            [self createKeyBoardType_8];
            _keyType8View.hidden = !_keyType8View.hidden;
            
            break;
            
            
        case 7:
            [self createKeyBoardType_7];//全仓／半仓键盘
            _keyType7View.hidden = !_keyType7View.hidden;
            break;
        case 9:{
            [self creatKeyBoardType_3];/**<9 phone 键盘*/
            _keyType3View.hidden = !_keyType3View.hidden;
            UIButton *button =  [_keyType3View viewWithTag:-3];
            [button setTitle:@"" forState:UIControlStateNormal];
            button.userInteractionEnabled = NO;
            break;
        }
            
        default:
            break;
    }
}


#pragma mark- 创建键盘视图
-(void)creatKeyView
{
    
    _numberKeyView = [[UIView alloc]initWithFrame:self.bounds];
    _abcKeyView = [[UIView alloc]initWithFrame:self.bounds];
    
//    _numberKeyView.backgroundColor = [UIColor blackColor];
//    _abcKeyView.backgroundColor = [UIColor blackColor];
    _numberKeyView.backgroundColor = SEUD_Color_Bg_Black_6;
    _abcKeyView.backgroundColor = SEUD_Color_Bg_Black_6;
    
    _keyType3View = [[UIView alloc]initWithFrame:self.bounds];
    _keyType4View = [[UIView alloc]initWithFrame:self.bounds];
    _keyType5View = [[UIView alloc]initWithFrame:self.bounds];
    _keyType6View = [[UIView alloc]initWithFrame:self.bounds];
    _keyType7View = [[UIView alloc]initWithFrame:self.bounds];
    _keyType8View = [[UIView alloc]initWithFrame:self.bounds];
    
    _numberKeyView.hidden = YES;
    _abcKeyView.hidden = YES;
    _keyType3View.hidden = YES;
    _keyType4View.hidden = YES;
    _keyType5View.hidden = YES;
    _keyType6View.hidden = YES;
    _keyType7View.hidden = YES;
    _keyType8View.hidden = YES;
    
    
    
    [self addSubview:_numberKeyView];
    [self addSubview:_abcKeyView];
    [self addSubview:_keyType3View];
    [self addSubview:_keyType4View];
    [self addSubview:_keyType5View];
    [self addSubview:_keyType6View];
    [self addSubview:_keyType7View];
    [self addSubview:_keyType8View];
}

#pragma mark -创建键盘Key
//键盘样式一
-(void)creatNumkeyBoard
{
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 5; j++)
        {
            UIButton *button  = [self creatNumButtonWithX:i Y:j];
            [self.numberKeyBtnArray addObject:button];
            [_numberKeyView addSubview:button];
            
        }
    }
}

//键盘样式二
-(void)creatABCKeyBoard
{
    for (int i = 0; i < 4; i++)
    {
        NSArray *temArray = _abcKeyNameArray[i];
        for (int j = 0; j < temArray.count; j++)
        {
            UIButton *button = [self creatABCButtonWithX:i Y:j];
            [self.abcKeyBtnArray addObject:button];
            [_abcKeyView addSubview:button];
            
        }
    }
    
}


//键盘样式三
-(void)creatKeyBoardType_3
{
    for (int i = 0; i < 4; i++)
    {
        NSArray *tempArray = _keyType3NameArray[i];
        for (int j = 0; j < tempArray.count; j++)
        {
            UIButton *button = [self createKeyType3WithX:i Y:j];
            [self.keyType3BtnArray addObject:button];
            [_keyType3View addSubview:button];
        }
    }
}

//键盘样式四－ 特殊符号
-(void)createKeyBoardType_4
{
    for (int i = 0; i < 4; i++)
    {
        NSArray *tempArray = _keyType4NameArray[i];
        for (int j = 0; j < tempArray.count; j++)
        {
            UIButton *button = [self createKeyType4WithX:i Y:j];
            [self.keyType4BtnArray addObject:button];
            [_keyType4View addSubview:button];
        }
    }
}

//键盘样式五 键盘样式六－大小写英文键盘
-(void)createKeyBoardType_5
{
    for (int i = 0; i < 4; i++)
    {
        NSArray *tempArray = _keyType5NameArray[i];
        for (int j = 0; j < tempArray.count; j++)
        {
            //同时创建大小写键盘
            
            UIButton *button2 = [self createKeyType5WithX:i Y:j array:_keyType6NameArray isUn:NO];
            [self.keyType5BtnArray addObject:button2];
            [_keyType5View addSubview:button2];
            
            UIButton *button1 = [self createKeyType5WithX:i Y:j array:_keyType5NameArray isUn:YES];
            [self.keyType6BtnArray addObject:button1];
            [_keyType6View addSubview:button1];
            
        }
    }
    
}

//键盘样式七 全仓／半仓键盘
-(void)createKeyBoardType_7
{
    for (int i = 0; i < 4; i++)
    {
        NSArray *tempArray = _keyType7NameArray[i];
        for (int j = 0 ; j < tempArray.count; j++)
        {
            UIButton *button = [self createKeyType7WithX:i Y:j];
            [self.keyType7BtnArray addObject:button];
            [_keyType7View addSubview:button];
        }
    }
}

-(void)createKeyBoardType_8
{
    for (int i = 0; i < 4; i++)
    {
        NSArray *tempArray = _keyType8NameArray[i];
        for (int j = 0 ; j < tempArray.count; j++)
        {
            UIButton *button = [self createKeyType8WithX:i Y:j];
            if (button) {
                [self.keyType8BtnArray addObject:button];
            }
            [_keyType8View addSubview:button];
        }
    }
}


#pragma mark - create keyBoard KeyButton
-(UIButton *)creatABCButtonWithX:(NSInteger)x Y:(NSInteger)y
{
    //static int tempIndex = 0;
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat frameX,frameW,frameY,frameH;
    
    //计算按钮位置 大小
    if (x == 0)
    {
        frameW = keyWidth/10;
        frameH = keyHeight/4;
        frameX = y * frameW;
        frameY = x * frameH;
        button.frame = CGRectMake(frameX + 1, frameY + 1, frameW -1, frameH-1);
    }else if (x == 1 || x== 2)
    {
        float frameWS = (keyWidth - (keyWidth/10 * 7))/2;
        if (y == 0)
        {
            frameW = frameWS;
            frameH = keyHeight/4;
            frameX = 0;
            frameY = x * frameH;
        }else if(y == 8)
        {
            frameW = frameWS;
            frameH = keyHeight/4;
            frameX = (y - 1) * (keyWidth/10) +frameWS;
            frameY = x * frameH;
            
        }else
        {
            frameW = keyWidth/10;
            frameH = keyHeight/4;
            frameX = (y-1) * frameW + frameWS;
            frameY = x * frameH;
        }
        button.frame = CGRectMake(frameX + 1, frameY + 1, frameW -1, frameH-1);
    }else
    {
        if (y == 0)
        {
            frameW = 71;
            frameH = keyHeight/4;
            frameX = y * frameW ;
            frameY = x * frameH;
            
        }else if(y == 1)
        {
            frameW = keyWidth - 71*2;
            frameH = keyHeight/4;
            frameX = y * 71 ;
            frameY = x * frameH;
        }else
        {
            frameW = 71;
            frameH = keyHeight/4;
            frameX = 71 + (keyWidth - 71*2);
            frameY = x * frameH;
        }
        button.frame = CGRectMake(frameX + 1, frameY + 1, frameW -1, frameH-1);
    }
    
    
    
    //设置按钮样式
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblue.png"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    //设置按钮名称
    NSArray *tempArray = _abcKeyNameArray[x];
    NSString *tagString = tempArray[y];
    if ([tagString isEqualToString:@"键盘"])
    {
        [button setImage:[UIImage imageNamed:@"keyBoard_2.png"] forState:UIControlStateNormal];
    }else if([tagString isEqualToString:@"删除"])
    {
        [   button setImage:[UIImage imageNamed:@"keyBoard_4.png"] forState:UIControlStateNormal];
    }else if([tagString isEqualToString:@"空格"])
    {
        [button setTitle:@"" forState:UIControlStateNormal];
    }else if ([tagString isEqualToString:@"搜索"])
    {
        [button setImage:[UIImage imageNamed:@"keyBoard_3.png"] forState:UIControlStateNormal];
    }else
    {
        [button setTitle:tagString forState:UIControlStateNormal];
    }
    

    //给按钮设置tag值
    button.tag = _tempIndex_1;
    if(x==0){
        button.tag = y;
    }else if (x==1){
     button.tag = y+10;
    }else if (x==2){
     button.tag = y+19;
    }else if (x==3){
     button.tag = y+28;
    }
    
//   _tempIndex_1;
    
    //给按钮添加事件
    [button addTarget:self action:@selector(abcButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
}

-(UIButton *)creatNumButtonWithX:(NSInteger)x Y:(NSInteger)y
{
    UIButton *button;
    CGFloat frameX,frameW,frameY,frameH;
    
    //设置frame
    frameW = keyWidth/5;
    frameH = keyHeight/4;
    frameX = y * frameW;
    frameY = x * frameH;
    
    //设置按钮属性
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(frameX + 1, frameY + 1, frameW -1, frameH-1);
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblue.png"] forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    
    //设置按钮名称／tag值
    NSArray *tempArray = _numkeyNameArray[x];
    NSString *tagString = tempArray[y];
    
    [button setTitle:tagString forState:UIControlStateNormal];
    
    if ([tagString isEqualToString:@"600"])
    {
        button.tag = -1;
    }else if ([tagString isEqualToString:@"300"])
    {
        button.tag = -2;
    }else if ([tagString isEqualToString:@"删除"])
    {
        button.tag = -3;
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyBoard_4.png"] forState:UIControlStateNormal];
        
        
    }else if ([tagString isEqualToString:@"键盘"])
    {
        button.tag = -4;
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyBoard_2.png"] forState:UIControlStateNormal];
        
    }else if ([tagString isEqualToString:@"ABC"])
    {
        
        button.tag = -5;
    }
    else if ([tagString isEqualToString:@"00"])
    {
        button.tag = -6;
    }else if ([tagString isEqualToString:@"000"])
    {
        button.tag = -7;
    }else if ([tagString isEqualToString:@"搜索"])
    {
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyBoard_3.png"] forState:UIControlStateNormal];
        button.tag = -8;
        
    }else if ([tagString isEqualToString:@" "])
    {
        button.userInteractionEnabled = NO;
        button.tag = -9;
    }else
    {
        button.tag = [tagString integerValue];
    }
    
    
    //给按钮添加事件
    [button addTarget:self action:@selector(numButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
    
}

-(UIButton *)createKeyType3WithX:(NSInteger)x Y:(NSInteger)y
{
    UIButton *button;
    CGFloat frameX,frameW,frameY,frameH;
    
    if (x != 3)
    {
        //设置frame
        frameW = keyWidth/3;
        frameH = keyHeight/4;
        frameX = y * frameW;
        frameY = x * frameH;
    }else
    {
        switch (y)
        {
            case 0:
                frameW = 88;
                frameH = keyHeight/4;
                frameX = y * frameW;
                frameY = x * frameH;
                break;
                
            case 1:
                frameW = (keyWidth - 88*2)/2;
                frameH = keyHeight/4;
                frameX = y * 88;
                frameY = x * frameH;
                break;
                
            case 2:
                frameW = (keyWidth - 88*2)/2;
                frameH = keyHeight/4;
                frameX = 88 + frameW;
                frameY = x * frameH;
                break;
                
            case 3:
                frameW = 88;
                frameH = keyHeight/4;
                frameX = (y-1)*((keyWidth - 88*2)/2) + 88;
                frameY = x * frameH;
                break;
            default:
                break;
        }
    }
    
    
    
    //设置按钮属性
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(frameX + 1, frameY + 1, frameW -1, frameH-1);
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblue.png"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:18];

    
    
    //设置按钮名称／tag值
    NSArray *tempArray = _keyType3NameArray[x];
    NSString *tagString = tempArray[y];
    [button setTitle:tagString forState:UIControlStateNormal];
    
    //设置button 的 tag 值
    if ([tagString isEqualToString:@"键盘"])
    {
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyBoard_2.png"] forState:UIControlStateNormal];
        button.tag = -1;
        
    }else if([tagString isEqualToString:@"删除"])
    {
        [button setImage:[UIImage imageNamed:@"keyBoard_4.png"] forState:UIControlStateNormal];
        [button setTitle:nil forState:UIControlStateNormal];
        button.tag = -2;
    }else if([tagString isEqualToString:@"."])
    {
        button.tag = -3;
    }else
    {
        button.tag = [tagString integerValue];
    }
    
    
    //给按钮添加事件
    [button addTarget:self action:@selector(keyBoardType3ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

-(UIButton *)createKeyType4WithX:(NSInteger)x Y:(NSInteger)y
{
   // static int tempIndex = 0;
    UIButton *button;
    CGFloat frameX,frameW,frameY,frameH;
    
    if (x == 0 || x == 1)
    {
        //设置frame
        frameW = keyWidth/10;
        frameH = keyHeight/4;
        frameX = y * frameW;
        frameY = x * frameH;
        
    }else if(x == 2)
    {
        
        if (y == 8)
        {
            frameW = keyWidth - 8*(keyWidth/10);
            frameH = keyHeight/4;
            frameX = y * (keyWidth/10);
            frameY = x * frameH;
            
        }else
        {
            //设置frame
            frameW = keyWidth/10;
            frameH = keyHeight/4;
            frameX = y * frameW;
            frameY = x * frameH;
            
        }
        
    }else
    {
        switch (y)
        {
            case 0: case 1:
            {
                frameW = keyWidth - 8*(keyWidth/10);
                frameH = keyHeight/4;
                frameX = y * frameW;
                frameY = x * frameH;
            }
                break;
            case 6:
            {
                frameW = keyWidth - 8*(keyWidth/10);
                frameH = keyHeight/4;
                frameX = 2 * frameW + (y - 2)*(keyWidth/10);
                frameY = x * frameH;
            }
                break;
            default:
            {
                float frameWS = keyWidth - 8*(keyWidth/10);
                frameW = keyWidth/10;
                frameH = keyHeight/4;
                frameX = 2 * frameWS + (y - 2) * frameW;
                frameY = x * frameH;
            }
                
                break;
        }
        
        
    }
    
    //设置按钮属性
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(frameX + 1, frameY + 1, frameW -1, frameH-1);
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblue.png"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    //设置按钮名称／tag值
    NSArray *tempArray = _keyType4NameArray[x];
    NSString *tagString = tempArray[y];
    [button setTitle:tagString forState:UIControlStateNormal];
    
    //设置button 的 tag 值
    if ([tagString isEqualToString:@"123"])
    {
        button.tag = -1;
    }else if([tagString isEqualToString:@"删除"])
    {
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyBoard_4.png"] forState:UIControlStateNormal];
        button.tag = -2;
    }else if([tagString isEqualToString:@"ABC"])
    {
        button.tag = -3;
    }else if([tagString isEqualToString:_typeString])
    {
        button.tag = -4;
    }
    else
    {
        button.tag = _tempIndex_2;
        _tempIndex_2++;
    }
    
    
    //给按钮添加事件
    [button addTarget:self action:@selector(keyBoardType4ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
}

-(UIButton *)createKeyType5WithX:(NSInteger)x Y:(NSInteger)y array:(NSArray *)keyArray isUn:(BOOL)isUnlm
{
//    static int tempIndex_1 = 0;
//    static int tempIndex_2 = 0;
    UIButton *button;
    CGFloat frameX,frameW,frameY,frameH;
    
    //设置frame
    if (x == 0)
    {
        frameW = keyWidth/10;
        frameH = keyHeight/4;
        frameX = y * frameW;
        frameY = x * frameH;
    }else if(x == 1)
    {
        float frameWS = (keyWidth - 9*(keyWidth/10))/2;//计算空白宽度
        frameW = keyWidth/10;
        frameH = keyHeight/4;
        frameX = y * frameW + frameWS;
        frameY = x * frameH;
    }else if(x == 2)
    {
        float frameWS = (keyWidth - 7*(keyWidth/10))/2;//计算删除按钮宽度
        if (y == 0 || y == 8)
        {
            
            frameH = keyHeight/4;
            if (y == 0)
            {
                frameW = frameWS;
                frameWS = 0;
                frameX = y * frameW + frameWS;
                frameY = x * frameH;
            }else
            {
                frameW = frameWS;
                frameX =(y-1) * (keyWidth/10) + frameW;
                frameY = x * frameH;
            }
            
            
        }else
        {
            frameW = keyWidth/10;
            frameH = keyHeight/4;
            frameX = (y - 1) * frameW + frameWS;
            frameY = x * frameH;
        }
        
    }else
    {
        float frameWS = (keyWidth - 7*(keyWidth/10))/2;//计算删除按钮宽度
        float frameWT = 4 * (keyWidth/10) + frameWS;   //计算登陆宽度
        float frameWC = (keyWidth - frameWT)/2;        //计算123、#+=按钮宽度
        
        switch (y)
        {
            case 0:case 1:
            {
                frameW = frameWC;
                frameH = keyHeight/4;
                frameX = y * frameW;
                frameY = x * frameH;
                
            }
                break;
            case 2:
            {
                frameW = frameWT;
                frameH = keyHeight/4;
                frameX = y * frameWC;
                frameY = x * frameH;
                
            }
                break;
                
            default:
                break;
        }
    }
    
    //设置按钮属性
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(frameX, frameY + 1, frameW, frameH-1);
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblue.png"] forState:UIControlStateHighlighted];
//    button.titleLabel.font = [UIFont systemFontOfSize:16];
      button.titleLabel.font = [UIFont systemFontOfSize:18];
    
    //设置按钮名称／tag值
    NSArray *tempArray = keyArray[x];
    NSString *tagString = tempArray[y];
    [button setTitle:tagString forState:UIControlStateNormal];
    
    
    //设置button 的 tag 值
    if ([tagString isEqualToString:@"123"])
    {
        button.tag = -1;
    }else if([tagString isEqualToString:@"#+="])
    {
        button.tag = -2;
    }else if([tagString isEqualToString:_typeString])
    {
        button.tag = -3;
    }else if([tagString isEqualToString:@"大小"])
    {
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyBoard_5.png"] forState:UIControlStateNormal];
        button.tag = -4;
    }else if ([tagString isEqualToString:@"删除"])
    {
        button.tag = -5;
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyBoard_4.png"] forState:UIControlStateNormal];
    }
    else
    {
        if (isUnlm)
        {
            button.tag = _tempIndex_3;
            _tempIndex_3++;
        }else
        {
            button.tag = _tempIndex_4;
            _tempIndex_4++;
        }
        
        
    }
    
    //给按钮添加事件
    if (isUnlm == YES) //大写
    {
        [button addTarget:self action:@selector(keyBoardType5ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }else
    {
        //小写
        [button addTarget:self action:@selector(keyBoardType6ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    return button;
}

-(UIButton *)createKeyType7WithX:(NSInteger)x Y:(NSInteger)y
{
    static int tempIndex = 0;
    CGFloat frameX,frameW,frameY,frameH;
    
    frameW = keyWidth/4;
    frameH = keyHeight/4;
    frameX = y * frameW;
    frameY = x * frameH;
    
    //设置按钮属性
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(frameX + 1, frameY + 1, frameW -1, frameH-1);
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblue.png"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    //设置按钮名称／tag值
    NSArray *tempArray = _keyType7NameArray[x];
    NSString *tagString = tempArray[y];
    [button setTitle:tagString forState:UIControlStateNormal];
    
    if ([tagString isEqualToString:@"全仓"])
    {
        button.tag = -1;
    }else if([tagString isEqualToString:@"半仓"])
    {
        button.tag = -2;
    }else if([tagString isEqualToString:@"1/3仓"])
    {
        button.tag = -3;
    }else if([tagString isEqualToString:@"1/4仓"])
    {
        button.tag = -4;
    }else if([tagString isEqualToString:@"键盘"])
    {
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyBoard_2.png"] forState:UIControlStateNormal];
        button.tag = -5;
    }else if([tagString isEqualToString:@"删除"])
    {
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyBoard_4.png"] forState:UIControlStateNormal];
        button.tag = -6;
    }else
    {
        button.tag = [tagString integerValue];
    }
    
    [button addTarget:self action:@selector(keyBoardType7ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
}

-(UIButton *)createKeyType8WithX:(NSInteger)x Y:(NSInteger)y
{
    
//    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat frameX,frameW,frameY,frameH;
    CGFloat sepWidth = 1.f;
    frameW = (keyWidth - 5*sepWidth)/4;
    frameH = keyHeight/4;
    frameX = y * frameW + (y+1)*sepWidth;
    frameY = x * frameH;
    
    if (x == 0  && y == 3)
    {
        return nil ;
    }else if(x == 2 && y == 3)
    {
        return nil;
        
    }else if(x == 1 && y == 3)
    {
        frameH = 2 * (keyHeight/4);
        frameY = 0;
    }else if(x == 3 && y == 3)
    {
        frameH = 2 * (keyHeight/4);
        frameY =frameH;
    }
    
    
    //设置按钮属性
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(frameX, frameY + 1, frameW, frameH-1);
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"keyboardblue.png"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    //设置按钮名称／tag值
    NSArray *tempArray = _keyType8NameArray[x];
    NSString *tagString = tempArray[y];
    [button setTitle:tagString forState:UIControlStateNormal];
    
    if ([tagString isEqualToString:@"ABC"])
    {
        button.tag = -1;
    }else if([tagString isEqualToString:@"#+="])
    {
        button.tag = -2;
    }else if([tagString isEqualToString:@"删除"])
    {
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"keyBoard_4.png"] forState:UIControlStateNormal];
        button.tag = -3;
    }else if([tagString isEqualToString:_typeString])
    {
        button.tag = -4;
    }else
    {
        button.tag = [tagString integerValue];
    }
    
    [button addTarget:self action:@selector(keyBoardType8ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - 键盘事件
//ABC键盘事件
-(void)abcButtonClick:(UIButton *)button
{
    NSString *tempString;
    switch (button.tag)
    {
        case 19:
        {
            NSLog(@"收回键盘");
            if (_delegateFlags.keyboardSure) {
                [self.delegate keyboardSure];
            }
        }
            break;
        case 27:
        {
            NSLog(@"删除");
            if (_delegateFlags.numberKeyBoardBackSpace) {
                [self.delegate numberKeyBoardBackSpace];
            }
        }
            break;
        case 28:
            NSLog(@"切换123");
            [self changeKeyboard];
            break;
        case 29:
        {
            NSLog(@"空格");
            if (_delegateFlags.keyboardInputlongString) {
                tempString = @" ";
                [self.delegate keyboardInputlongString:tempString];
            }
        }
            break;
        case 30:
        {
            NSLog(@"搜索");
            if (_delegateFlags.keybooarSearch) {
                [self.delegate keybooarSearch];
            }
        }
            break;
            
        default:
        {
            //输出字符
            if (button.tag >= 0 && button.tag < 10)
            {
                NSArray *tempArray = _abcKeyNameArray[0];
                tempString = tempArray[button.tag];
                NSLog(@"%@",tempString);
                
            }else if(button.tag >=10 && button.tag <= 18)
            {
                NSArray *tempArray = _abcKeyNameArray[1];
                tempString = tempArray[button.tag - 10];
                NSLog(@"%@",tempString);
                
            }else if(button.tag >= 19 && button.tag < 27)
            {
                NSArray *tempArray = _abcKeyNameArray[2];
                tempString = tempArray[button.tag - 19];
                NSLog(@"%@",tempString);
            }
            
            NSLog(@"%@",tempString);
            if (_delegateFlags.keyboardInputlongString) {
                [self.delegate keyboardInputlongString:tempString];
            }
        }
            break;
    }
    
}

//数字键盘按钮事件
-(void)numButtonClick:(UIButton *)button
{
    NSLog(@"%ld",button.tag);
    
    switch (button.tag)
    {
        case -1:
        {
            if (_delegateFlags.keyboardInputlongString) {
                //600
                [self.delegate keyboardInputlongString:@"600"];
            }
        }
            
            break;
            
        case -2:
        {
            if (_delegateFlags.keyboardInputlongString) {
                //300
                [self.delegate keyboardInputlongString:@"300"];
            }
        }
            break;
            
        case -3:
            //删除
            [self.delegate numberKeyBoardBackSpace];
            break;
            
        case -4:
            //收回键盘
            [self.delegate keyboardSure];
            break;
            
        case -5:
            //"ABC"
            [self  changeKeyboard];
            break;
            
        case -6:
            //“00”
            [self.delegate keyboardInputlongString:@"00"];
            break;
            
        case -7:
            //"000"
            [self.delegate keyboardInputlongString:@"000"];
            
        case -8:
            //"搜索"
            [self.delegate keybooarSearch];
            break;
            
        case -9:
            //" "
            break;
            
        default:
            [self.delegate keyboardInputlongString:[NSString stringWithFormat:@"%ld",button.tag]];
            
            break;
    }
}

-(void)keyBoardType3ButtonClick:(UIButton *)button
{
    switch (button.tag)
    {
        case -1:
            //收回键盘
            [self.delegate keyboardSure];
            break;
            
        case -2:
            [self.delegate numberKeyBoardBackSpace];
            break;
            
        case -3:
            [self.delegate keyboardInputlongString:@"."];
            break;
            
            
        default:
            [self.delegate keyboardInputlongString:[NSString stringWithFormat:@"%ld",(long)button.tag]];
            
            break;
    }
}

-(void)keyBoardType4ButtonClick:(UIButton *)button
{
    switch (button.tag)
    {
        case -1:
            //123
            _keyType4View.hidden = !_keyType4View.hidden;
            _keyType8View.hidden = !_keyType8View.hidden;
            break;
            
        case -2:
            //删除
            [self.delegate numberKeyBoardBackSpace];
            break;
            
        case -3:
            //ABC
            _keyType4View.hidden = !_keyType4View.hidden;
            _keyType5View.hidden = !_keyType5View.hidden;
            break;
            
        case -4:
            //登陆
            [self.delegate keyboardLogin];
            break;
        default:
        {
            if (button.tag >= 0 && button.tag <= 9)
            {
                NSArray *tempArray = _keyType4NameArray[0];
                NSString *tempString = tempArray[button.tag];
                [self.delegate keyboardInputlongString:tempString];
            }else if(button.tag >= 10 && button.tag <= 19)
            {
                NSArray *tempArray = _keyType4NameArray[1];
                NSString *tempString = tempArray[button.tag - 10];
                [self.delegate keyboardInputlongString:tempString];
            }else if(button.tag >= 20 && button.tag <= 27)
            {
                NSArray *tempArray = _keyType4NameArray[2];
                NSString *tempString = tempArray[button.tag - 20];
                [self.delegate keyboardInputlongString:tempString];
            }else if (button.tag >= 28 && button.tag <= 31)
            {
                NSArray *tempArray = _keyType4NameArray[3];
                NSString *tempString = tempArray[button.tag - 26];
                [self.delegate keyboardInputlongString:tempString];
            }
        }
            break;
    }
}

-(void)keyBoardType5ButtonClick:(UIButton *)button
{
    NSLog(@"%ld",button.tag);
    switch (button.tag)
    {
        case -1:
            //123
            _keyType5View.hidden = !_keyType5View.hidden;
            _keyType8View.hidden = !_keyType8View.hidden;
            if (_keyType5View.hidden==_keyType8View.hidden) {
                _keyType5View.hidden=YES;
            }
            _keyType4View.hidden=YES;
            _keyType6View.hidden=YES;
            _keyType3View.hidden=YES;
            break;
            
        case -2:
            //#+=
//          _keyType8View.hidden =!_keyType8View.hidden;
            _keyType4View.hidden = !_keyType4View.hidden;
            _keyType5View.hidden = YES;
            _keyType6View.hidden = YES;
//            _keyType5View.hidden = !_keyType5View.hidden;
//            _keyType6View.hidden=!_keyType6View.hidden;
//            if (_keyType4View.hidden==_keyType5View.hidden) {
//                _keyType4View.hidden=YES;
//            }
            break;
            
        case -3:
            //登陆
            [self.delegate keyboardLogin];
            break;
            
        case -4:
            //大小写
            _keyType5View.hidden = !_keyType5View.hidden;
            _keyType6View.hidden = !_keyType6View.hidden;
            
            break;
        case -5:
            //删除
            [self.delegate numberKeyBoardBackSpace];
            break;
            
        default:
        {
            if (button.tag >= 0 && button.tag <= 9)
            {
                NSArray *tempArray = _keyType5NameArray[0];
                NSString *tempString = tempArray[button.tag];
                [self.delegate keyboardInputlongString:tempString];
            }else if(button.tag >= 10 && button.tag <= 18)
            {
                NSArray *tempArray = _keyType5NameArray[1];
                NSString *tempString = tempArray[button.tag - 10];
                [self.delegate keyboardInputlongString:tempString];
            }else if(button.tag >= 19 && button.tag <= 25)
            {
                NSArray *tempArray = _keyType5NameArray[2];
                NSString *tempString = tempArray[button.tag - 18];
                [self.delegate keyboardInputlongString:tempString];
            }
        }
            break;
    }
}


-(void)keyBoardType6ButtonClick:(UIButton *)button
{
    NSLog(@"%ld",button.tag);
    switch (button.tag)
    {
        case -1:
            //123
            _keyType6View.hidden = !_keyType6View.hidden;
            _keyType8View.hidden = !_keyType8View.hidden;
            if (_keyType6View.hidden==_keyType8View.hidden) {
                _keyType6View.hidden=YES;
            }
            _keyType4View.hidden=YES;
            _keyType5View.hidden=YES;
            _keyType3View.hidden=YES;
            break;
            
        case -2:
            //#+=
            _keyType4View.hidden = !_keyType4View.hidden;
            _keyType5View.hidden = YES;
            
//            _keyType6View.hidden = !_keyType6View.hidden;
//            if (_keyType6View.hidden==_keyType4View.hidden) {
//                _keyType6View.hidden=YES;
//            }
            break;
            
        case -3:
            //登陆
            if([_delegate respondsToSelector:@selector(keyboardLogin)]){
                [self.delegate keyboardLogin];
            }
            break;
            
        case -4:
            //大小写
            _keyType5View.hidden = !_keyType5View.hidden;
            _keyType6View.hidden = !_keyType6View.hidden;
            break;
            
        case -5:
            //删除
            [self.delegate numberKeyBoardBackSpace];
            break;
            
        default:
        {
            if (button.tag >= 0 && button.tag <= 9)
            {
                NSArray *tempArray = _keyType6NameArray[0];
                NSString *tempString = tempArray[button.tag];
                [self.delegate keyboardInputlongString:tempString];
            }else if(button.tag >= 10 && button.tag <= 18)
            {
                NSArray *tempArray = _keyType6NameArray[1];
                NSString *tempString = tempArray[button.tag - 10];
                [self.delegate keyboardInputlongString:tempString];
            }else if(button.tag >= 19 && button.tag <= 25)
            {
                NSArray *tempArray = _keyType6NameArray[2];
                NSString *tempString = tempArray[button.tag - 18];
                [self.delegate keyboardInputlongString:tempString];
            }
        }
            break;
    }
}


-(void)keyBoardType7ButtonClick:(UIButton *)button
{
    
    NSLog(@"%ld",button.tag);
    switch (button.tag)
    {
        case -1://全仓
            [self.delegate keyboardNumLoadString:@"全仓"];
            break;
            
        case -2://半仓
            [self.delegate keyboardNumLoadString:@"半仓"];
            
            break;
            
        case -3://1/3仓
            [self.delegate keyboardNumLoadString:@"1/3仓"];
            break;
            
        case -4://1/4仓
            [self.delegate keyboardNumLoadString:@"1/4仓"];
            break;
            
        case -5://键盘
            if([_delegate respondsToSelector:@selector(keyboardSure)]){
                [self.delegate keyboardSure];
            }
            break;
            
        case -6://删除
            [self.delegate numberKeyBoardBackSpace];            break;
            
        default:
            [self.delegate keyboardInputlongString:[NSString stringWithFormat:@"%ld",button.tag]];
            break;
    }
}


-(void)keyBoardType8ButtonClick:(UIButton *)button
{
    NSLog(@"%ld",button.tag);
    switch (button.tag)
    {
        case -1://ABC
            _keyType8View.hidden = !_keyType8View.hidden;
            _keyType5View.hidden = !_keyType5View.hidden;
            break;
            
        case -2://#+=
            _keyType4View.hidden = !_keyType4View.hidden;
            _keyType8View.hidden = !_keyType8View.hidden;
            break;
            
        case -3://删除
            [self.delegate numberKeyBoardBackSpace];
            break;
            
        case -4://登陆
            [self.delegate keyboardLogin];
            break;
            
        default:
            [self.delegate keyboardInputlongString:[NSString stringWithFormat:@"%ld",(long)button.tag]];
            break;
    }
}
#pragma mark - 按钮事件

//键盘样式一 键盘样式二 之间的切换
-(void) changeKeyboard
{
    _numberKeyView.hidden = !_numberKeyView.hidden;
    _abcKeyView.hidden = !_abcKeyView.hidden;
    
}

#pragma mark -
#pragma mark Life Cycle




#pragma mark -
#pragma mark Private Method




#pragma mark -
#pragma mark Event Response




#pragma mark -
#pragma mark Getter & Setter

- (NSMutableArray *)numberKeyBtnArray
{
    if (!_numberKeyBtnArray) {
        _numberKeyBtnArray = [[NSMutableArray alloc] init];
    }
    return _numberKeyBtnArray;
}

- (NSMutableArray *)abcKeyBtnArray
{
    if (!_abcKeyBtnArray) {
        _abcKeyBtnArray = [NSMutableArray new];
    }
    return _abcKeyBtnArray;
}

- (NSMutableArray *)keyType3BtnArray
{
    if (!_keyType3BtnArray) {
        _keyType3BtnArray = [NSMutableArray new];
    }
    return _keyType3BtnArray;
}

- (NSMutableArray *)keyType4BtnArray
{
    if (!_keyType4BtnArray) {
        _keyType4BtnArray = [NSMutableArray new];
    }
    return _keyType4BtnArray;
}

- (NSMutableArray *)keyType5BtnArray
{
    if (!_keyType5BtnArray) {
        _keyType5BtnArray = [NSMutableArray new];
    }
    return _keyType5BtnArray;
}

- (NSMutableArray *)keyType6BtnArray
{
    if (!_keyType6BtnArray) {
        _keyType6BtnArray = [NSMutableArray new];
    }
    return _keyType6BtnArray;
}

- (NSMutableArray *)keyType7BtnArray
{
    if (!_keyType7BtnArray) {
        _keyType7BtnArray = [NSMutableArray new];
    }
    return _keyType7BtnArray;
}

- (NSMutableArray *)keyType8BtnArray
{
    if (!_keyType8BtnArray) {
        _keyType8BtnArray = [NSMutableArray new];
    }
    return _keyType8BtnArray;
}

-(void)setDelegate:(id<keyBoardDelegate>)delegate{
    _delegate = delegate;
    _delegateFlags.keyboardInputlongString = [delegate respondsToSelector:@selector(keyboardInputlongString:)];
    _delegateFlags.numberKeyBoardBackSpace = [delegate respondsToSelector:@selector(numberKeyBoardBackSpace)];
    _delegateFlags.keybooarSearch = [delegate respondsToSelector:@selector(keybooarSearch)];
    _delegateFlags.keyboardSure = [delegate respondsToSelector:@selector(keyboardSure)];
    _delegateFlags.keyboardLogin = [delegate respondsToSelector:@selector(keyboardLogin)];
    _delegateFlags.keyboardNumLoadString = [delegate respondsToSelector:@selector(keyboardNumLoadString:)];
}

#pragma mark -
#pragma mark PublicMethod







@end
