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
