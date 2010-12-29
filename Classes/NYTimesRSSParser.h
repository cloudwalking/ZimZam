/*
 
 Created by Reed Morse on 12/20/10.
 Copyright 2010 Reed Morse.
 
 
 This file is part of ZimZam.
 
 ZimZam is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 ZimZam is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with ZimZam.  If not, see <http://www.gnu.org/licenses/>.
 
 */

#import <UIKit/UIKit.h>
#import "Article.h"

@interface NYTimesRSSParser : NSObject  <NSXMLParserDelegate>{
	NSMutableArray *articlesArray;
	NSMutableString *textInProgress;
	NSString *tagInProgress;
	Article *tempArticle;
	BOOL inItem;
}

@property (retain, nonatomic) NSString *tagInProgress;
@property (retain, nonatomic) NSMutableString *textInProgress;
@property (retain, nonatomic) NSMutableArray *articlesArray;
@property (retain, nonatomic) Article *tempArticle;
@property BOOL inItem;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
