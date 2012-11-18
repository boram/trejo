# Trejo

Trejo provides `nav_item` helper to render navigation links. An `active` class is applied to the link when the requested path matches the link url.

## Installation

Add it to your Gemfile and run the `bundle` command to install it.

 ```ruby
 gem 'trejo'
 ```

## Usage

If the current path is `/home`, then the following

 ```
 <nav>
   <%= nav_item 'Home', '/home' %>
   <%= nav_item 'Blog', '/blog' %>
 </nav>
 ```

generates

 ```
 <nav>
   <a href='/home' class='active'>Home</a>
   <a href='/blog'>Blog</a>
 </nav>
 ```

Trejo assumes that the link url is the root of the resource, and ignores query parameters by default. So the above example also works if the requested path is `/home/index?foo=bar`.

The default css class applied to the link is `active`. This can be overridden by passing a `class` option with the desired class.

 ```
 <%= nav_item 'Home', '/home', class: 'current-section' %>
 ```

generates

 ```
 <a href='/home' class='current-section'>Home</a>
 ```

If you need more granularity in the criteria for determining an active link, you can supply a regular expression in the `selected ` option. So if the current path is `/home?foo=bar`, then the following

 ```
 <%= nav_item 'Home', '/home?foo=bar', selected: /^\/home\?foo=\w+/ %>
 ```

generates

 ```
 <a class='active'>Home</a>
 ```

