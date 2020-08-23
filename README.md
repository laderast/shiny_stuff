# Gallery of Shiny Apps with HTMLwidget Interactions

This is a repository cataloging how to interact with various HTMLwidgets. I am mostly making these for my own reference, but hopefully they will be helpful for other people.

- [Reactable Interactions](reactable_interaction/index.Rmd) - This is an example of using reactable to monitor row-clicking events. If you click on a row in the reactable, the full dataset for that row will appear in the window on the right.
- [networkD3 Interactions](networkD3_interaction/index.Rmd) - This is an example to monitor cell-clicking events for `networkD3`.


# IntroJS notes

- Using introjs with `flexdashboard`: To do 
- Super useful: how to use introjs with multiple tabs (need to simulate tab-clicking with JavaScript) https://stackoverflow.com/questions/39545002/multi-page-intro-js-with-shiny

# Why `flexdashboard`? 

## Pros

- ui layouts such as `sidebarLayout()` cause the *nested bracket issue*
- can be really hard to debug, based on misplaced commas/brackets
- `flexdashboard` definitely cuts down on these by removing the layout functions
- can be a little more friendly to different browser window sizes

## Cons

- `flexbox` is different and can be confusing to learn the parameters
- `shiny_prerendered` as a runtime requires knowledge of code chunk contexts:
  - `server` context is where server code goes
  - ui elements don't need a context
 - Best practices are to use shiny modules here
  
