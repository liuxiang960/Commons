//
//  SeudPublic.h
//  SEUDApp
//
//  Created by 刘湘 on 15/12/22.
//  Copyright © 2015年 chuangwuxian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^LoadUserInfoCallback)();

typedef NS_ENUM(NSInteger,EUserInputType){
    EUserInputTypeUserName
};

@interface SeudPublic : NSObject
+(NSString *)getNumToChinaNum:(NSInteger)num;
+(NSString *)getNumToChinaNums:(NSInteger)num;
+ (NSString *)deviceIPAdress;
/**json 和数组转字符串*/
+(NSString*)dictionaryToJson:(id)dic;
/**
 *  @author xiang
 *
 *  判断字符串是否包含另一个字符串
 *
 *  @param zongString 需要判断的
 *  @param mySting    是否有个这个字符串
 *
 *  @return
 */
+(BOOL)isStringBaoHanString:(NSString *)zongString  myString:(NSString*)mySting;
/**格林威治时间转date*/
+(NSDate *)TimeStringToDate:(NSString *)startTime;
/**将2017-02-10 9:37:46 转为2017021093746*/
+(NSString *)newDateToString:(NSString *)dateStr;
/**将2017-02-10 9:37:46 转为任意时间格式*/
+(NSString *)newDateToString:(NSString *)dateStr DateFormatter:(NSString *)Formatter;
/*!
 *  @author 刘湘, 17-07-17 16:07:02
 *
 *  @brief 增加时间转换
 *
 *  @param dateStr      时间
 *  @param Formatter    原来时间格式
 *  @param newForMatter 新时间格式
 *
 *  @return <#return value description#>
 *
 *  @since <#1.0.6#>
 */
+(NSString *)newDateToString:(NSString *)dateStr  DateFormatter:(NSString *)Formatter  NewDateFormatter:(NSString *)newForMatter;
+(NSString *)dateToString:(NSString *)startTime;
+(NSString *)MydateToString:(NSString *)startTime;

+(NSString *)myTimeToString:(NSString *)startTime;
+(CGFloat)GetTextWidth:(NSString*)text Font:(UIFont*)font Height:(CGFloat)height;
+(double)jinyiMethod:(double)num;
+(double)roundMethod:(double)num;
+(NSString *)getLastDate:(NSInteger)date;
/**获取上个月的今天*/
+ (NSString *)setupRequestDay;

+(NSString *)getCurrentTime;
/*!
 *  @author 刘湘, 16-11-15 16:11:46
 *
 *  获取当前时间
 *
 *  @param format 格式
 *
 *  @return
 */
+(NSString *)getCurrentTime:(NSString *)format;
+ (NSString *)getCurrentTimeDesc;
/**date 转化为yyyyMMddHHmmss*/
+ (NSString *)dateToFormatterString:(NSDate *)date;

+ (NSString *)dateToSString:(NSDate *)date;
+ (NSDate *)stringToDate:(NSString *)string;
+ (NSString *)oneMonthFromNow;

+(NSArray *)getStockArray:(NSString*)str;
+(NSString *)myLastDateToString:(NSString *)startTime Formatter:(NSString *)formatterStr;//获取Sep 9, 2016 3:43:54 PM这种格式时间
+(NSString *)myLastTimeToString:(NSString *)startTime; //返回的是时间
+(NSString *)MydateToString:(NSString *)startTime Formatter:(NSString*)formatt;
/**设置指定文字的颜色*/
+ (NSAttributedString *)setStringToAttributeStr:(NSString *)dataString strColor:(UIColor *)strColor units:(NSString *)units unitsColor:(UIColor *)unitsColor;

+(NSAttributedString *)addStringToAttributeString:(NSString *)dataString units:(NSString *)units;
#pragma mark - 属性字符串拼接在一起  颜色 字体
/*!
 *  @author 刘湘, 16-12-09 14:12:33
 *
 *  @brief 属性字符串拼接在一起  颜色 字体
 *
 *  @param dataString
 *  @param fontColor
 *  @param FoFont
 *  @param blowStr
 *  @param blowfont
 *  @param blowColor
 *
 *  @return 属性字符串拼接在一起  颜色 字体
 *
 *  @since <#1.0.3#>
 */
+(NSAttributedString *)addToAttributeStringFontStr:(NSString *)dataString forntColor:(UIColor *)fontColor  forntFont:(UIFont *)FoFont  blowSting:(NSString *)blowStr blowFornt:(UIFont *)blowfont blowColor:(UIColor *)blowColor;//属性字符串字体颜色
/*!
 *  @author 刘湘, 16-12-09 14:12:03
 *
 *  @brief 属性字符串拼接在一起  颜色不同 字体一样
 *
 *  @param NSAttributedString
 *
 *  @return 属性字符串拼接在一起  颜色不同 字体一样
 *
 *  @since <#1.0.3#>
 */
#pragma mark - 属性字符串拼接在一起  颜色不同 字体一样
+(NSAttributedString *)addToAttributeStringFontStr:(NSString *)dataString forntColor:(UIColor *)fontColor  blowSting:(NSString *)blowStr  blowColor:(UIColor *)blowColor  MyFornt:(UIFont *)font;
+ (NSAttributedString *)frontText:(NSString *)froText frontFont:(UIFont *)froFont blowText:(NSString *)bloText blowFont:(UIFont *)blowFont;

/*!
 *  @author 刘湘, 16-12-09 14:12:03
 *
 *  @brief 属性字符串拼接在一起  颜色相同 字体不同
 *
 *  @param NSAttributedString
 *
 *  @return 属性字符串拼接在一起  颜色不同 字体一样
 *
 *  @since
 */
+(NSAttributedString *)addToAttributeStringFontStr:(NSString *)dataString  forntFont:(UIFont *)FoFont  blowSting:(NSString *)blowStr blowFornt:(UIFont *)blowfont MyColor:(UIColor *)Color;
+(NSAttributedString *)addStringToAttributeStringColor:(NSString *)dataString units:(NSString *)units defualColor:(UIColor *)defualColor falgColar:(UIColor *)flagCloor;//可买数量119
+(NSString *)myLastDateToString:(NSString *)startTime;//返回的是日期

+(NSString *)moneyToney:(NSString *)money;
+(NSString *)moneyToMoney:(NSString *)money;
+(NSString *)keepTwoDecimalMoney:(NSString *)money;
/**<金额加单位 bol yes 小数为0时自动输出整数*/
+(NSString *)moneyAndUntil:(NSString *)money isSaveDecimal:(BOOL)bol;
+(NSString *)NumToNumStr:(NSString *)num;//数量转换

+(NSString *)ChangeNumberFormat:(NSString *)num;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)numberConvertToStandardNumberString:(double)number;

#pragma mark - 为NO的话是3月1号外部  YES为内部
+(BOOL)isGetVerSion;
#pragma mark - 截取时间
+(NSString *)myTimeSubTimeToString:(NSString *)startTime;
+(NSString *)myTimeDateToString:(NSString *)startTime;
#pragma mark - 为yes隐藏首页广告no为显示
+(BOOL)isHidenHomeAd;
#pragma mark - 时间戳转时间
+(NSString *)timeCodeTotimeStr:(NSString*)str;
#pragma mark - 数量转换
+(NSString *)numToNum:(NSString *)num;

//格林威治时间转换
+(NSString *)gelinTimeToString:(NSString *)startTime;

+(void)mysetLostHost:(NSString *)hostHerder;
+(NSString *)getHostHeader;//获取根路径
+(UILabel *)isdataColor:(NSString *)str cha:(NSString *)chaStr myLable:(UILabel *)lable;//修改字体颜色
+(UIColor *)isdataColor:(NSString *)str cha:(NSString *)chaStr;

+(void)isOrderPushServerCall:(NSString *)server TypeDic:(NSDictionary *)typeDic;//绑定
+(void)isUnOrderPushServerCall:(NSString *)server TypeDic:(NSDictionary *)typeDic;//解绑
//long or float字符串
+(NSString *)islongToString:(id)data;
+(NSString *)isFloatToString:(id)data;
/**
 *  @author xiang
 *
 *  科学计算法保留没有小数
 *
 *  @param numberStr 数量
 *
 *  @return 用数值的科学计算法
 */
+ (NSString *)rtToStandardNumberStringTxt:(NSString *)numberStr;/**< 数量科学计算法 */
/**
 *  科学计算法保留3位小数
 *
 *  @param numberStr 需要转换内容
 *
 *  @return 返还转换的值
 */
+ (NSString *)rtToStandardNumberStringThirs:(NSString *)numberStr;
/**
 *  @author xiang
 *
 *  科学计算法保留2位小数
 *
 *  @param numberStr 价格
 *
 *  @return 保留2位的科学计算值
 */
+ (NSString *)rtToStandardNumberString:(NSString *)numberStr;
/*!
 *  @author 刘湘, 16-11-08 15:11:40
 *
 *   科学计算法保留2位小数 带单位
 *
 *  @param str
 *
 *  @return
 */
+(NSString*)rtToStandardNumberStringAddSymbolic:(NSString *)str;

/**科学计数法转字符串*/
+(NSString *)standardNumberToString:(NSString *)standardNumberStr;
//取当前viewController
+ (UIViewController*)findTopViewController;
+(NSString *)trasUpdateMoney:(double)money;//大写字
+(NSString *)isAddTenYear:(NSString *)dateStr;//增加10年
+(NSString *)isAddYear:(NSString *)dataStr Years:(NSInteger) year;//增加年

+(BOOL)validateDate:(NSString *)startTime endDate:(NSString *)endTime;//日期比较

/**判断开始时间跟结束时间是否合理（开始时间 可以等于 结束时间）*/
+ (BOOL)validateDate1:(NSString *)startTime endDate:(NSString *)endTime;
+(BOOL)compareStartDate:(NSDate *)sDate withEndDate:(NSDate *)eDate;//是否10年20年
+(BOOL)compareStartDateStr:(NSString *)sDateStr withEndDate:(NSString *)eDateStr;
+(BOOL)isBegin:(NSString *)BeginDate  end:(NSString *)endDate;//身份证有效期
+(NSString *)limitInputChar:(NSString *)dataStr  untils:(NSString *)str  limitNum:(NSInteger)num;//计算包含多少中文和限制
+(void)loadUserStatusData;//用户信息
+(void)loadUserStatusData:(LoadUserInfoCallback)callback;//用户信息
//判断身份证是否有效
+(BOOL)IsIDCodeExactn:(NSString *)idCar;
+ (NSMutableString *)exchangeStr:(NSString *)str;
+ (NSMutableString *)exchangeString:(NSString *)str;
/**将2016-5-1转换成2016/5/31*/
+ (NSMutableString *)exchangeStrings:(NSString *)str;
/**将string转化为“2016-06-07 15：00：00”的nsdate*/
+ (NSDate *)stringToMyDate:(NSString *)string;

//判断字符串中中文的个数
+(NSInteger)IsChinese:(NSString *)str;
+(BOOL)IsChineseBool:(unichar)str;//是否是中文

/**金额取绝对值， 返回double*/
+(double)nsnumberAndStringToFabs:(id)nsnumberOrString;
/**金额取绝对值，返回string*/
+(NSString *)nsnumberAndStringToFabsStr:(id)nsnumberOrString;

/**计算文字的高度和长度*/
+ (CGSize)textHeightStr:(NSString *)str font:(CGFloat )font labelWidth:(CGFloat)width;

+(NSString* )isGetdate:(NSString *)time addDate:(NSInteger)addDate typeFormatter:(NSString*)type;/**< 转时间戳然后增加date  默认时间格式yyyy-MM-dd */
+(NSString*)dateFromTime:(long)time typeFormatter:(NSString*)type/**< 转时间戳然后增加date  默认时间格式yyyy-MM-dd */;
//时间格式转时间戳  获取时间差值
+(NSString *)dateToTimeIntervalsince:(NSString *)date;/**< 日期转时间戳 */

+(NSDate*)dateFromString:(NSString*)dateStr;

+ (NSDate *)stringToFullDate:(NSString *)string;
/**
 *  判断是不是周几
 *
 *  @param dateStr datrstr
 *
 *  @return 返货星期几
 */
+ (NSString *)calculateWeek:(NSString *)dateStr;

/**计算中英混排的字符串的长度*/
+ (int)getToInt:(NSString*)strtemp;



/*判断密码安全性的强度，返回字符串：弱、中、强*/
+ (NSString*)judgePasswordStrong:(NSString*)password;
/**
 *  @author xiang
 *
 *  时间转时间戳
 *
 *  @return 时间戳
 */
+(NSString *)dateToInterval:(NSString *)date;
+(UIViewController *)getStoryboard;
+(NSString *)getCurrentInterval;/****当前时间戳***/

/**
 *  @author xiang
 *
 *  时间格式转换
 *
 *  @param startTime        转换时间
 *  @param starformatterStr 原来格式
 *  @param formatterDate    需呀转换格式
 *
 *  @return 返回需要的时间格式
 */
+(NSString *)myDateToDate:(NSString *)startTime startFormatter:(NSString *)starformatterStr  dateToFormatter:(NSString *)formatterDate;

/**
 *  @author xiang
 *
 *  时间格式转换
 *
 *  @param startTime        转换时间
 *  @param 默认的格式是yyyy-MM-dd
 *  @param formatterDate    需呀转换格式
 *
 *  @return 返回需要的时间格式
 */
+(NSString *)DateFormatterStart:(NSString*)start toFormatter:(NSString *)formatter;
/*!
 *  @author 刘湘, 16-11-02 10:11:48
 *
 *  获取价格波动
 *
 *  @param price 需要转换的价格算波动
 *
 *  @return
 */
+(double)isGetFloatedPrice:(NSString *)price;
/*!
 *  @author dp, 17-5-17 10:11:48
 *
 *  获取价格波动
 *
 *  @param price 需要转换的价格算波动
 *
 *  @return
 */
+ (double)minWavePrice:(NSString*)price;
/*!
 *  @author 刘湘, 16-11-04 13:11:35
 *
 *  测试写入plist
 *  name 表名
 *  @param info
 */
+(void)isWriteFieil:(NSDictionary *)info tabName:(NSString *)name;
/*!
 *  @author dp, 16-12-07 13:11:35
 *
 *  设置圆角
 *
 *  @param info
 */
+ (void)cornerRadiusWith:(UIView*)view corners:(UIRectCorner)corners;
+ (void)cornerRadiusWith:(UIView*)view corners:(UIRectCorner)corners viewRect:(CGRect)rect;
/*!
 *  @author dp, 16-12-07 13:11:35
 *
 *  获取label自适应高度
 *
 *  @param info
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;
/*!
 *  @author dp, 16-12-15 13:11:35
 *
 *  判断用户性别(YES:男性.NO:女性)
 *
 *  @param info
 */
+ (BOOL)checkOutIDCardSexWithString:(NSString*)str;
/*!
 *  @author dp, 16-12-15 13:11:35
 *
 *  隐藏电话号码中间4位
 *
 *  @param telNum 需要转换的电话号码
 */
+ (NSString*)hideMidFourOfTelNum:(NSString*)telNum;
/*!
 *  @author dp, 16-12-29 13:11:35
 *
 *  判断证件是否过期
 *
 *  @param startTime           起始时间
 *  @param validityInterval    有效期
 */
+ (BOOL)checkIDCardOutTimeWithStartTime:(NSString*)startTime validityTimeInterval:(NSString*)validityInterval;
/*!
 *  @author dp, 17-1-9 13:11:35
 *
 *  绘制扇形图
 *
 *  @param center        中心点
 *  @param radius        半径
 *  @param startAngle   起始角
 *  @param  endAngle   终止角
 *  @param  bgColor    背景颜色
 */
+ (void)drawCircularSectorWithPointCenter :(CGPoint)center Radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle backGrundColor:(UIColor*)bgColor;
/*!
 *  @author dp, 17-1-11 13:11:35
 *
 *  数字大于0时添加+,小于0时添加-,等于0不添加符号
 *
 *  @param numberStr        需要处理的字符串数字
 */
+ (NSString*)changeNumberStringFormatWithNumStr:(NSString*)numberStr;

// 创建BezierPath 并设置角 和 半径
//UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerTopRight | UIRectCornerBottomRight;
/**指定四个角切圆*/
+ (void)setLayerAndBezierPathCutCircularWithView:(UIView *)view rectCorner:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii;

/**设置字符串特定范围内文字的颜色*/
+ (NSAttributedString *)attributeForTextOfSpecifieldRange:(NSRange)range textColor:(UIColor *)textcolor textFont:(UIFont *)textFont otherTextColor:(UIColor *)otherTextColor otherTextFont:(UIFont *)otherTextFont initText:(NSString *)initText;
/*!
 *  @author dp, 17-2-7 13:11:35
 *
 *  判断图片是否相同
 *
 *  @param
 */
+ (BOOL)isSameToDefaultIamge:(UIImage*)image defultImage:(UIImage*)defaultImage;
/*!
 *  @author dp, 17-3-7 13:11:35
 *
 *  判断传入字典是否不为空
 *
 *  @param
 */
+ (BOOL)dictIsNotNull:(NSDictionary*)dict;
/*!
 *  @author 刘湘, 17-03-14 14:03:37
 *
 *  @brief 通过渠道号返回相应渠道
 *
 *  @param code
 *
 *  @return
 *
 *  @since <#1.0.5#>
 */
+(NSString *)payChannelCode:(NSString *)code;
/*!
 *  @author dp, 17-03-14 14:03:37
 *
 *  @brief 统计字符串中字符个数,中文和英文字母都算一个
 *
 *  @param strtemp
 *
 *  @return
 *
 *  @since <#1.0.5#>
 */
+  (NSInteger)convertToInt:(NSString*)strtemp;


/*!
 *  @author dp, 17-03-14 14:03:37
 *
 *  @brief 校验用户输入是否合法
 *
 *  @param content,type
 *
 *  @return
 *
 *  @since <#1.0.5#>
 */
+(NSString*)verifyUserInput:(NSString*)content type:(EUserInputType)type;


/**判断用户名是否为复姓*/
+ (BOOL)isCompoundSurname:(NSString *)userName;
/**判断两张图片是否一致*/
+(BOOL)isEqualImageToImage:(UIImage *)imageFornt BlowImage:(UIImage *)blow;
/**通过type获取交易类型图片*/
+(UIImage *)getTraderTypeString:(id)type;
/*判断字符串是否为中文**/
+ (BOOL)isChinese:(NSString *)str;
/*判断是不是小写字母**/
+ (BOOL)isLowerLetter:(NSString *)str;
/*判断是不是大写字母**/
+ (BOOL)isCatipalLetter:(NSString *)str;
/*判断是否只包含中文和英文字母**/
+ (BOOL)isOnlyChineseAndEnglish:(NSString*)str;
/**
 * 字母、数字、中文正则判断（不包括空格）
 */
+ (BOOL)isInputRuleNotBlank:(NSString *)str;
/**
 * 字母、数字、中文正则判断（包括空格）（在系统输入法中文输入时会出现拼音之间有空格，需要忽略，当按return键时会自动用字母替换，按空格输入响应汉字）
 */
+ (BOOL)isInputRuleAndBlank:(NSString *)str;
/**
 *  过滤字符串中的emoji
 */
+ (NSString *)disable_emoji:(NSString *)text;
/**
 * 纯数字
 */
+ (BOOL)isonlyIntChar:(NSString*)str;
/*!
 *  @author 刘湘, 17-06-19 14:06:46
 *
 *  @brief 通过code 判断大盘状态和品种状态
 *
 *  @param retCode
 *  @param bol     yes 是买
 *
 *  @return  也是是可以执行
 *
 *  @since <#1.0.6#>
 */
+(BOOL)isscodeTradeTime:(NSInteger)retCode isBuyer:(BOOL)bol;
/**<与上方法一致 增加是否tost*/
+(BOOL)isscodeTradeTime:(NSInteger)retCode isBuyer:(BOOL)bol isShowTost:(BOOL)tost;
+(double)doubleSavePoint:(double)dou;/**double 保留2位比较*/
/*!
 *  @author dp, 17-07-14 14:06:46
 *
 *  @brief 添加倾斜45度文字
 *
 *  @param view 目标View
 *  @param str  要添加的文字
 *  @param font  字体大小
 *
 *  @return
 *
 *  @since <#1.0.6#>
 */
+ (void)addSlopeLabelInView:(UIView*)view WithString:(NSString*)str labelFont:(CGFloat)font textColor:(UIColor*)color;
/*!
 *  @author 刘湘, 17-08-16 13:08:57
 *
 *  @brief 获取导航中 移除某些控制器
 *
 *  @param first 第一个控制器名字
 *  @param secVc 第二个控制器名字
 *
 *  @return 数组
 *
 *  @since <#1.1.1#>
 */
+(NSArray *)removeNavagationFistClassVc:(NSString *)first SecoundVcStr:(NSString *)secVc;
/**时间有效期转换*/
+ (NSString *)validTimeData:(NSString *)str;

/*!
 *  @author DP, 17-09-5 14:06:46
 *
 *  @brief 字符串加*
 *
 *  @param str
 *  @param bol
 *
 *  @return
 *
 *  @since <#1.0.6#>
 */
+ (NSString*)addSpecialSymbolInTheMiddleOfString:(NSString*)str symbolNum:(NSInteger)num frontLegth:(NSInteger)fNum backLength:(NSInteger)bNum;
@end
