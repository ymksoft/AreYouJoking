//
//  Joke.m
//  AreYouJoking
//
//  Created by Юрий Куприянов on 17.10.15.
//  Copyright © 2015 YMK Soft. All rights reserved.
//

#import "Joke.h"

@implementation Joke

+(Joke *)jokeFromDictionary:(NSDictionary *)info {
    
    Joke *aJoke = [Joke new];
    
    aJoke.url = info[@"link"];
    aJoke.sourceSite = info[@"desc"];
    aJoke.html = info[@"elementPureHtml"];
    
    /*
    site
    name
    desc
    link
    elementPureHtml
    */
    
    return aJoke;
}

@end
