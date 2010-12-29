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

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ZimZamLoadDelegate : NSObject <UIWebViewDelegate>

	NSMutableDictionary *options;
	int webViewLoads;

@property (nonatomic, retain) NSMutableDictionary *options;

- (void)webView:(UIWebView *)sender didFailLoadWithError:(NSError *)error;
- (void)webView:(UIWebView *)sender didFailProvisionalLoadWithError:(NSError *)error;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)doGrab:(UIWebView *)webView;
- (void)getURL:(UIWebView *)webView;
- (NSString *)description;
- (void)getURL:(UIWebView *)webView;
- (void)start:(UIWebView *)webView;

@end
