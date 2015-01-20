//
//  ArticleHTMLParser.m
//  St Kilda
//
//  Created by Alexander Crompton on 19/01/2015.
//  Copyright (c) 2015 Okeito. All rights reserved.
//

#import "TFHpple.h"
#import "ArticleCell.h"

@implementation ArticleHTMLParser : NSObject


-(NSString*)parseArticleHTML:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url]; //download the contents of the URL
    TFHpple *parser = [TFHpple hppleWithHTMLData:data]; //initialize the hpple parser with the data downloaded from the url
    NSMutableString *articleText = [[NSMutableString alloc] initWithString:@""]; 
    NSString *xPathString = @"//div[@id='content-area']/p"; //XPath Query that searches for the correct text; the <p>'s in the div with the id 'content-area'
    NSArray *paragraphs = [parser searchWithXPathQuery:xPathString]; //init an NSArray * with the elements found by the above XPath Query
    //loop through the elements and add the text of them to the article text that we're going to return
    for(TFHppleElement *element in paragraphs){ 
        if(element.text){
            [articleText appendString:element.text];
        }
    }

    //return the complete article
    return articleText;
}
    
    







@end
