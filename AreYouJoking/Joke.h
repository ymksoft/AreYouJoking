//
//  Joke.h
//  AreYouJoking
//
//  Created by Юрий Куприянов on 17.10.15.
//  Copyright © 2015 YMK Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Joke : NSObject

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *html;
@property (nonatomic,strong) NSString *sourceSite;

+(Joke *)jokeFromDictionary:(NSDictionary *)info;

@end
