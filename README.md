# Trejo

Trejo provides `nav_item` helper to render navigation links. An `active` class is applied to the link when the requested path matches the link url.

## Installation

Add it to your Gemfile and run the `bundle` command to install it.

 ```ruby
 gem 'trejo'
 ```

## Usage

If the current path is `/home`, then the following usage

 ```
 <nav>
   <%= nav_item 'Home', '/home' %>
   <%= nav_item 'Blog', '/blog' %>
 </nav>
 ```

generates

 ```
 <nav>
   <a class='active'>Home</a>
   <a>Blog</a>
 </nav>
 ```

Trejo assumes that the link url is the root of the resource, so the above example also works if the requested path is `/home/index`.

By default, query parameters are ignored.

If you need more granularity in the criteria for determining an active link, you can supply a regular expression in the `selected ` option. So if the current path is `/home?foo=bar`, then the following usage

 ```
 <nav>
   <%= nav_item 'Home', '/home', selected: /^\/home\?foo=bar/ %>
   <%= nav_item 'Blog', '/blog', selected: /^\/blog\?foo=bar/ %>
 </nav>
 ```

generates

 ```
 <nav>
   <a class='active'>Home</a>
   <a>Blog</a>
 </nav>
 ```

The default css class applied to the link is `active`. This can be overridden by passing a `class` option with the desired class.


 ```
 <%= nav_item 'Home', '/home', class: 'current-section' %>
 ```
