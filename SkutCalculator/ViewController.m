//
//  ViewController.m
//  SkutCalculator
//
//  Created by Mac on 5/25/16.
//  Copyright © 2016 Mac. All rights reserved.
//copy

#import "ViewController.h"

typedef NS_ENUM (NSUInteger, OperationType) {
    
    OTDivide,
    OTMultiply,
    OTSubtract,
    OTAdd

};

#define OpersationTypeString(enum) [@[@"/",@"*",@"-",@"+"] objectAtIndex:enum]

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;
- (IBAction)actionResultButton:(UIButton*)sender;

- (IBAction)actionOperatorButton:(UIButton*)sender;
- (IBAction)actionDot:(UIButton*)sender;

- (IBAction)actionDigitButton:(UIButton*)sender;
- (IBAction)actionCleanButton:(UIButton*)sender;


@property (assign, nonatomic) OperationType operation;
@property (assign, nonatomic) CGFloat firstValue;
@property (assign, nonatomic) CGFloat secondValue;
@property (assign, nonatomic) BOOL dotFlag;
@property (assign, nonatomic) BOOL operationFlag;
@property (assign, nonatomic) BOOL resultFlag;
@property (strong, nonatomic) NSString* equation;
@property (assign, nonatomic) NSRange range;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dotFlag = NO;
    self.operationFlag = NO;
    self.resultFlag = NO;
    self.firstValue=0;
    self.secondValue=0;
    self.equation=@"";
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionOperatorButton:(UIButton*)sender {
    if (self.operationFlag==NO){
    
    self.firstValue=[self.indicatorLabel.text floatValue];
    self.operation=sender.tag;
    
    self.operationFlag=YES;
    self.dotFlag = NO;
    self.resultFlag=NO;
    
    self.indicatorLabel.text=[self.indicatorLabel.text stringByAppendingString: OpersationTypeString(sender.tag)];
    
    self.equation =self.indicatorLabel.text;
    }

}

- (IBAction)actionResultButton:(id)sender {
    
    
    if (self.operationFlag==YES){
        
        if(self.operation==OTDivide){
            
        self.firstValue=self.firstValue/self.secondValue;
        }
        if(self.operation==OTMultiply){
            
         self.firstValue=self.firstValue * self.secondValue;
        }
        if(self.operation==OTSubtract){
            
         self.firstValue=self.firstValue - self.secondValue;
        }
        if(self.operation==OTAdd){
            
         self.firstValue=self.firstValue+self.secondValue;
        }
    
        self.indicatorLabel.text = [NSString stringWithFormat:@"%g",self.firstValue];
    
        self.resultFlag=YES;
        self.operationFlag=NO;
        self.dotFlag = NO;
    }
}


- (IBAction)actionDigitButton:(UIButton*)sender {
    
    if(self.resultFlag == NO){
        if (self.operationFlag == NO){
           
            
                if ([self.indicatorLabel.text isEqualToString:@"0"]){
                    self.indicatorLabel.text=[NSString stringWithFormat:@"%ld",sender.tag];
                    self.firstValue=[self.indicatorLabel.text floatValue];//rep
                }
                else{
                    NSString* lastDigit = [NSString stringWithFormat:@"%ld",sender.tag];
                    self.indicatorLabel.text=[self.indicatorLabel.text stringByAppendingString: lastDigit];
                     self.firstValue=[self.indicatorLabel.text floatValue];//rep
                }
        }
        
        else{ // self.operationFlag == YES
            NSLog(@"self.operationFlag == YES");
        
            NSRange range = [self.indicatorLabel.text rangeOfString:self.equation];
            
            NSString *secondNumberString = [self.indicatorLabel.text stringByReplacingCharactersInRange:range withString:@""];
            NSString* lastDigit = [NSString stringWithFormat:@"%ld",sender.tag];
            secondNumberString = [secondNumberString stringByAppendingString:lastDigit];
            self.secondValue=[secondNumberString floatValue];
            
            self.indicatorLabel.text=[self.equation stringByAppendingString: secondNumberString];
        }
    }
    
    else{ //self.resultFlag==YES
        
        self.firstValue=0;
        self.secondValue=0;
        
        self.indicatorLabel.text=[NSString stringWithFormat:@"%ld",sender.tag];
        
        self.dotFlag = NO;
        self.resultFlag = NO;
        self.operationFlag = NO;
    }

}
    

- (IBAction)actionDot:(UIButton*)sender {
    if (self.resultFlag==NO){
    
        if(self.dotFlag == NO){
            if ([self.indicatorLabel.text isEqual: self.equation]){
                self.indicatorLabel.text=[self.indicatorLabel.text stringByAppendingString:@"0."];
                self.dotFlag = YES;
            }
            else{
    
                self.indicatorLabel.text=[self.indicatorLabel.text stringByAppendingString:@"."];
                self.dotFlag = YES;
            }
        }
    
        else{ //self.dotFlag == YES
            
            //do nothing
        
        }
        
    }
    else{ //self.resultFlag==YES
    
    //do nothing
        
    }
    
}

- (IBAction)actionCleanButton:(id)sender{
    
    NSLog(@"your just cleaned the window");
    self.indicatorLabel.text=@"0";
    self.dotFlag = NO;
    self.resultFlag = NO;
    self.operationFlag = NO;
    self.firstValue=0;
    self.secondValue=0;
 
}

@end



/*
 
 Вот друзья, обстановка становится все веселее, раньше мы с вами только в консоль смотрели, а теперь уже потихоньку приложения собираем :) Задание будет тоже, что я говорил в уроке, а именно - сделать калькулятор :)
 
 Ученик.
 
 1. Создайте и разместите кнопки цифр и операторов, создайте нужные акшины
 2. Добавьте лейбл и создайте соответствующий проперти
 3. По нажатию на кнопку на индикатор должна выводиться либо цифра, либо оператор (никаких вычислений - выводим просто значения кнопок)
 
 Студент.
 
 4. Наведите более / менее красоту, можете насоздавать линий (вьюхи с малой шириной)б ставить бэкграундыб используйте картинки если надо и тд. - проявите творчество :)
 5. Сделайте так, чтобы когда нажимаешь на цифровую кнопку, то число росло
 6. Сделайте кнопку сброса
 
 Мастер.
 
 7. Сохраняйте вводимое число
 8. Первую операцию тоже надо сохранить, пока не ввели второе число (используйте енумы!)
 9. Когда нажимаешь равно то первое число выболняет операцию над вторым и выводится результат
 10. После того, как результат вывелся на экран, он автоматом становиться первым числом и к нему уже можно прибавлять, вычитать и т.д. - как в калькуляторе
 
 Супермен
 
 11. Добавьте точку, теперь можно вводить и дробное число, точка должна работать также, как и точка на обычном калькуляторе (имею в виду, что двух точек в числе быть не может в случае повторного нажатия)
 12. С дробным вводом будет посложнее - задание для настоящих суперменов :)
 
 */

