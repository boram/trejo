# Trejo

Trejo provides view helpers and utilities for common UI needs in Rails apps.

## Installation

Add it to the Gemfile and run `bundle`.

 ```ruby
 gem 'trejo'
 ```

## Usage

### nav_item

The `nav_item` helper renders a navigation link with `active` class when the requested path matches the link url.

For example, if the current path is `/home`, then the following

 ```
 <nav>
   <%= nav_item 'Home', '/home' %>
   <%= nav_item 'Blog', '/blog' %>
 </nav>
 ```

renders

 ```
 <nav>
   <a href='/home' class='active'>Home</a>
   <a href='/blog'>Blog</a>
 </nav>
 ```

`nav_item` assumes that the link url is the root of the resource, and ignores query parameters by default. So the above example also works if the requested path is `/home/index?foo=bar`.

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

### merge_classes

The `merge_classes` helper takes any string or array or combination thereof to produce a string of css classes separated by a single whitespace.

 ```ruby
 merge_classes 'foo', 'bar'                                   => 'foo bar'
 merge_classes 'foo bar', 'baz'                               => 'foo bar baz'
 merge_classes ['foo', 'bar'], 'baz'                          => 'foo bar baz'
 merge_classes ['walter', 'sobchak'], ['shomer', ['shabbas']] => 'walter sobchak shomer shabbas'
 ```

Whitespaces, duplicates and blank/nil values are omitted.



