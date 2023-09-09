Scrapy is a fast high-level [web crawling](https://en.wikipedia.org/wiki/Web_crawler) and [web scraping](https://en.wikipedia.org/wiki/Web_scraping) framework, used to crawl websites and extract structured data from their pages. It can be used for a wide range of purposes, from data mining to monitoring and automated testing.

Even though Scrapy was originally designed for [web scraping](https://en.wikipedia.org/wiki/Web_scraping), **it can also be used to extract data using APIs** (such as [Amazon Associates Web Services](https://affiliate-program.amazon.com/gp/advertising/api/detail/main.html)) or as a general purpose web crawler.

- spider is always there, middleware and pipelines are optional, data can even be sent to a database directly.


```python
import scrapy

class QuotesSpider(scrapy.Spider):
    name = "quotes"
    start_urls = [
        "https://quotes.toscrape.com/tag/humor/",
    ]

    def parse(self, response):
        for quote in response.css("div.quote"):
            yield {
                "author": quote.xpath("span/small/text()").get(),
                "text": quote.css("span.text::text").get(),
            }

        next_page = response.css('li.next a::attr("href")').get()
        if next_page is not None:
            yield response.follow(next_page, self.parse)
```

```bash 
scrapy runspider quotes_spider.py -o quotes.jsonl
```

## What else can Scrapy do?
You’ve seen how to extract and store items from a website using Scrapy, but this is just the surface. Scrapy provides a lot of powerful features for making scraping easy and efficient, such as:

-   Built-in support for [selecting and extracting](https://docs.scrapy.org/en/latest/topics/selectors.html#topics-selectors) data from HTML/XML sources using extended CSS selectors and XPath expressions, with helper methods to extract using regular expressions.
    
-   An [interactive shell console](https://docs.scrapy.org/en/latest/topics/shell.html#topics-shell) (IPython aware) for trying out the CSS and XPath expressions to scrape data, very useful when writing or debugging your spiders.
    
-   Built-in support for [generating feed exports](https://docs.scrapy.org/en/latest/topics/feed-exports.html#topics-feed-exports) in multiple formats (JSON, CSV, XML) and storing them in multiple backends (FTP, S3, local filesystem)
    
-   Robust encoding support and auto-detection, for dealing with foreign, non-standard and broken encoding declarations.
    
-   [Strong extensibility support](https://docs.scrapy.org/en/latest/index.html#extending-scrapy), allowing you to plug in your own functionality using [signals](https://docs.scrapy.org/en/latest/topics/signals.html#topics-signals) and a well-defined API (middlewares, [extensions](https://docs.scrapy.org/en/latest/topics/extensions.html#topics-extensions), and [pipelines](https://docs.scrapy.org/en/latest/topics/item-pipeline.html#topics-item-pipeline)).
    
-   Wide range of built-in extensions and middlewares for handling:
    
    -   cookies and session handling
        
    -   HTTP features like compression, authentication, caching
        
    -   user-agent spoofing
        
    -   robots.txt
        
    -   crawl depth restriction
        
    -   and more
        
-   A [Telnet console](https://docs.scrapy.org/en/latest/topics/telnetconsole.html#topics-telnetconsole) for hooking into a Python console running inside your Scrapy process, to introspect and debug your crawler
    
-   Plus other goodies like reusable spiders to crawl sites from [Sitemaps](https://www.sitemaps.org/index.html) and XML/CSV feeds, a media pipeline for [automatically downloading images](https://docs.scrapy.org/en/latest/topics/media-pipeline.html#topics-media-pipeline) (or any other media) associated with the scraped items, a caching DNS resolver, and much more!

Scrapy is written in pure Python and depends on a few key Python packages (among others):

-   [lxml](https://lxml.de/index.html), an efficient XML and HTML parser
    
-   [parsel](https://pypi.org/project/parsel/), an HTML/XML data extraction library written on top of lxml,
    
-   [w3lib](https://pypi.org/project/w3lib/), a multi-purpose helper for dealing with URLs and web page encodings
    
-   [twisted](https://twistedmatrix.com/trac/), an asynchronous networking framework
    
-   [cryptography](https://cryptography.io/en/latest/) and [pyOpenSSL](https://pypi.org/project/pyOpenSSL/), to deal with various network-level security needs