//
//  JokeDtailtedViewController.m
//  AreYouJoking
//
//  Created by Юрий Куприянов on 17.10.15.
//  Copyright © 2015 YMK Soft. All rights reserved.
//

#import "JokeDtailtedViewController.h"

@interface JokeDtailtedViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JokeDtailtedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create attributed string from HTML
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithData:[self.joke.html dataUsingEncoding:NSUTF8StringEncoding]
                                     options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                               NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                          documentAttributes:nil error:nil];
                                   
    
    self.textView.attributedText = attStr;

}


@end
