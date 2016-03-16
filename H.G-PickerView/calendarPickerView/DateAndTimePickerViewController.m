//  练手
//
//  Created by H.G on 16/1/12.
//  Copyright © 2016年 H.G. All rights reserved.
//  QQ交流:297505427
//
#import "DateAndTimePickerViewController.h"
#define currentMonth [currentMonthString integerValue]


@interface DateAndTimePickerViewController ()<UITextFieldDelegate>

#pragma mark - IBActions


@property (weak, nonatomic) IBOutlet UITextField *textFieldEnterDate;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;

@property (weak, nonatomic) IBOutlet UIPickerView *customPicker;


#pragma mark - IBActions

- (IBAction)actionCancel:(id)sender;

- (IBAction)actionDone:(id)sender;



@end

@implementation DateAndTimePickerViewController
{
    
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *monthMutableArray;
     NSMutableArray *DaysMutableArray;
    NSMutableArray *DaysArray;
    NSArray *HArray;
    NSMutableArray *MinuteArray;
    NSString *currentMonthString;
    
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    NSInteger selectedHourRow;
    NSInteger selectedMinuteRow;
    
    BOOL firstTimeLoad;
    
    NSInteger m ;
    int year;
    int month;
    int day;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    m=0;
    firstTimeLoad = YES;
    self.customPicker.hidden = YES;
    self.toolbarCancelDone.hidden = YES;
    
    NSDate *date = [NSDate date];
    
    // 年
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                    [formatter stringFromDate:date]];
    year =[currentyearString intValue];
  
    // 月
    [formatter setDateFormat:@"MM"];
    
    currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
    month=[currentMonthString intValue];

    // 日
    
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    day =[currentDateString intValue];
  
    
    yearArray = [[NSMutableArray alloc]init];
    monthMutableArray = [[NSMutableArray alloc]init];
    DaysMutableArray= [[NSMutableArray alloc]init];
    for (int i = 2000; i <= year ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d年",i]];
        
    }
    //小时
    [formatter setDateFormat:@"HH"];
    
    HArray = @[@"01时",@"02时",@"03时",@"04时",@"05时",@"06时",@"07时",@"08时",@"09时",@"10时",@"11时",@"12时",@"13时",@"14时",@"15时",@"16时",@"17时",@"18时",@"19时",@"20时",@"21时",@"22时",@"23时",@"24时"];
    
    //分钟
    [formatter setDateFormat:@"mm"];
    MinuteArray = [NSMutableArray new];
    for (NSInteger i=0; i<60; i++) {
        [MinuteArray addObject:[NSString stringWithFormat:@"%2ld分",(long)i]];
    }
    // PickerView -  Months data
 
    monthArray = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];

    for (int i=1; i<month+1; i++) {
        [monthMutableArray addObject:[NSString stringWithFormat:@"%d月",i]];
    }
       DaysArray = [[NSMutableArray alloc]init];
    
    for (int i = 1; i <= 31; i++)
    {
        [DaysArray addObject:[NSString stringWithFormat:@"%d日",i]];
        
    }
    for (int i = 1; i <day+1; i++)
    {
        [DaysMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    // PickerView - Default Selection as per current Date
    // 设置初始默认值
    [self.customPicker selectRow:yearArray.count inComponent:0 animated:YES];
    
   // [pickerView selectRow:30 inComponent:0 animated:NO];
    
    [self.customPicker selectRow:[monthArray indexOfObject:[NSString stringWithFormat:@"%@月",currentMonthString]] inComponent:1 animated:YES];
    
    [self.customPicker selectRow:0 inComponent:2 animated:YES];
    
    [self.customPicker selectRow:0 inComponent:3 animated:YES];
    
    [self.customPicker selectRow:0 inComponent:4 animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    m=row;
    if (component == 0)
    {
        selectedYearRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        
        [self.customPicker reloadAllComponents];
        
    }else if (component == 3)
    {
        selectedHourRow = row;
        [self.customPicker reloadAllComponents];
    }else if (component == 4)
    {
        selectedMinuteRow = row;
        [self.customPicker reloadAllComponents];
    }
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width/5, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:17.0f]];
    }
    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
        
    }else if(component == 3)
    {
        pickerLabel.text = [HArray objectAtIndex:row];
    }else if (component == 4)
    {
        pickerLabel.text = [MinuteArray objectAtIndex:row];
    }
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 5;

}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        int n;
        n= year-2000;
        if (selectRow==n) {
            return [monthMutableArray count];
        }else
        {
            return [monthArray count];

        }
    }
    else if (component ==2)
    {
        NSInteger selectRow1 =  [pickerView selectedRowInComponent:0];
        int n;
        n= year-2000;
        NSInteger selectRow =  [pickerView selectedRowInComponent:1];
       
        if (selectRow==month-1 &selectRow1==n) {
            
            return day;
            
        }else{
            
            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
            {
                return 31;
            }
            else if (selectedMonthRow == 1)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
                
                
            }
            else
            {
                return 30;
            }

            
        }
        
    }else if (component == 3)
    {
            return 24;
    }else
    {
        return MinuteArray.count;
    }
}
- (IBAction)actionCancel:(id)sender
{
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.customPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];

    
}

- (IBAction)actionDone:(id)sender
{

    
    self.textFieldEnterDate.text = [NSString stringWithFormat:@"%@%@%@%@%@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]],[HArray objectAtIndex:[self.customPicker selectedRowInComponent:3]],[MinuteArray objectAtIndex:[self.customPicker selectedRowInComponent:4]]];
   
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.customPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                     }
                     completion:^(BOOL finished){
                    
                     }];
    
  
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.customPicker.hidden = NO;
                         self.toolbarCancelDone.hidden = NO;
                         self.textFieldEnterDate.text = @"";
                     }
                     completion:^(BOOL finished){
                     }];
    self.customPicker.hidden = NO;
    self.toolbarCancelDone.hidden = NO;
    self.textFieldEnterDate.text = @"";
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}




@end
