# Trejo

Trejo provides view helpers and utilities for common UI needs in Rails apps.

## Installation

Add it to the Gemfile

```ruby
gem 'trejo'
```

And run

```
bundle
```

Then run the installer to generate the initializer

```
$ rails g trejo:install
```

An initializer should now be at

```
config/initializers/trejo.rb
```

### Configuration parameters

The initializer should look similar to the following

```ruby
Trejo.configure do |config|
  config.site_title = 'My Website Title'
  config.company_name = 'My Company Name'
end
```

Set the values for the config params `site_title` and/or `company_name` as needed.

## Usage

### nav_item

The `nav_item` helper renders a navigation link with `active` class when the requested path matches the link url.

For example, if the current path is `/home`, then the following

```erb
<nav>
  <%= nav_item 'Home', '/home' %>
  <%= nav_item 'Blog', '/blog' %>
</nav>
```

renders

```html
<nav>
  <a href='/home' class='active'>Home</a>
  <a href='/blog'>Blog</a>
</nav>
```

`nav_item` assumes that the link url is the root of the resource, and ignores query parameters by default. So the above example also works if the requested path is `/home/index?foo=bar`.

The default css class applied to the link is `active`. This can be overridden by passing a `class` option with the desired class.

```erb
<%= nav_item 'Home', '/home', class: 'current-section' %>
```

generates

```html
<a href='/home' class='current-section'>Home</a>
```

If you need more granularity in the criteria for determining an active link, you can supply a regular expression in the `selected ` option. So if the current path is `/home?foo=bar`, then the following

```erb
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

### site_title

`site_title` returns the parameter of the same name as configured in the initializer. If no value is initialized, then it
returns the top level application module name.

### title

`title` is called from the current template and generates the content that goes in the title tag.

In the application layout template, add the following

```erb
<title><%= yield(:title).presence || site_title %></title>
```

Then set the page title anywhere in the current page template

```erb
<%= title 'About Us' %>
```

which yields

```html
<title>About Us | My Website Title</title>
```


### copyright_notice

```erb
<%= copyright_notice 'My Company Name' %>
```

yields

```html
© 2015 My Company Name, All Rights Reserved
```

You can also call it without the company name

```erb
<%= copyright_notice %>
```

This defaults to the `company_name` config param, which itself defaults to the top level application module name.

In `config/initializers/trejo.rb`,

```ruby
Trejo.configure do |config|
  config.company_name = 'My Company Name'
end
```

### page_id, page_class

It's often useful to scope the current page's elements at the top level.

On the `body` tag, usually in the application layout, add the following

```erb
<body id='<%= body_id %>' class='<%= body_class %>'>
</body>
```

Then in the current template

```erb
<%= page_id 'body-tag-id' %>
<%= page_class 'body-tag-class' %>
```

If `page_class` is not called, then no class is applied.

If `page_id` is not called, then `body_id` outputs a dom id in the following format

```ruby
"#{controller_name}-#{action_name}-page".dasherize
```

