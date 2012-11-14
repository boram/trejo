# Trejo

Navigation links with active states based on current path

## Installation

Add to your Gemfile and run the `bundle` command to install it.

 ```ruby
 gem 'trejo'
 ```

## Usage

Use the nav_item helper method in your view to generate a navigation link.

If the current path is `/home`, then the following usage

 ```
 <nav>
   <%= nav_item 'Home', home_path %>
   <%= nav_item 'Blog', blog_path %>
 </nav>
 ```

generates

 ```
 <nav>
   <a class='active'>Home</a>
   <a>Blog</a>
 </nav>
 ```
