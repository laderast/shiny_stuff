# Shiny: Drawing the Owl

This is my attempt to catalog new shiny things I've learned.

## Big Gains

The biggest gains are in learning:

- `flexdashboard`
- Shiny Modules
- `shinytest`
- `rintrojs`
- HTML/CSS/JavaScript

## Gallery of Shiny Apps with HTMLwidget Interactions

[JS events for Shiny](https://shiny.rstudio.com/articles/js-events.html)


This is a repository cataloging how to interact with various HTMLwidgets. I am mostly making these for my own reference, but hopefully they will be helpful for other people.

In general, you need to add an `onclick` argument with invoking the HTMLwidget to update a Shiny Input. This value for this argument is usually wrapped in `htmlwidgets::JS()`. You'll need to look at the HTML structure of the widget to figure out how to return the value you're interested in.

- [Reactable Interactions](reactable_interaction/index.Rmd) - This is an example of using reactable to monitor row-clicking events. If you click on a row in the reactable, the full dataset for that row will appear in the window on the right.
- [networkD3 Interactions](networkD3_interaction/index.Rmd) - This is an example to monitor cell-clicking events for `networkD3`.


## IntroJS notes

`intro.js` lets you wrap UI elements with helpful tutorial text. 

- Using introjs with `flexdashboard`: To do 
- Super useful: how to use introjs with multiple tabs (need to simulate tab-clicking with JavaScript) https://stackoverflow.com/questions/39545002/multi-page-intro-js-with-shiny

## Why `flexdashboard`? 

### Pros

- ui layouts such as `sidebarLayout()` cause the *nested bracket issue*
- can be really hard to debug, based on misplaced commas/brackets
- `flexdashboard` definitely cuts down on these by removing the layout functions
- can be a little more friendly to different browser window sizes
- flexible - can be used with static visualizations (htmlwidgets) and shiny

### Cons

- `flexbox` is different and can be confusing to learn the parameters
- `shiny_prerendered` as a runtime requires knowledge of code chunk contexts:
  - `server` context is where server code goes
  - ui elements don't need a context
 - Best practices are to use shiny modules here
  
## Why Shiny Modules?

- Keeps the code cleaner
- Namespacing lets you reuse the same code in the application
- Makes testing easier
 
## HTMLWidgets and JavaScript

This series is really helpful.

- [JS Build Widget](http://shiny.rstudio.com.s3-website-us-east-1.amazonaws.com/articles/js-build-widget.html)
- [Add Functionality to JS Widgets](http://shiny.rstudio.com.s3-website-us-east-1.amazonaws.com/articles/js-widget-functionality.html)
- [How to send messages from the browser to server and back](http://shiny.rstudio.com.s3-website-us-east-1.amazonaws.com/articles/js-send-message.html)
- [JS Custom Inputs](http://shiny.rstudio.com.s3-website-us-east-1.amazonaws.com/articles/js-custom-input.html)

## Going farther by learning HTML/CSS/JavaScript

- Garrick Aden-Buie's [JavaScript for Shiny Users](https://js4shiny.com)
- [Style your Apps with CSS](https://shiny.rstudio.com/articles/css.html)

## JavaScript for R

This book is really awesome. One of the best explanations for building an `htmlwidget` I've ever seen. 

https://book.javascript-for-r.com/

## Password Authentication

[shinymanager package](https://datastorm-open.github.io/shinymanager/) - uses encrypted SQLite database for storing credentials
