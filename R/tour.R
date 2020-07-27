library(cicerone)

guide <- Cicerone$
  new()$
  step(el = "fdr",
       title = "False Discovery Rate Slider",
       description = "Adjust this slider to move\n 
       the False Discovery Rate Cutoff")$
  step(el = "react",
       title = "Correlation Table",
       description= "This table reacts to the filter cutoff.
       You can also search for cytokines or drugs via the search
       box, and sort by clicking the headers.\n\n
       Click on any row to show the cytokine/drug data in
       the correlation plot")$
  step(el="drug",
       title="Drug Selector",
       description = "Dropdown box to select drug of interest")$
  step(el="cytokine",
       title="Cytokine Selector",
       description = "Dropdown box to select cytokine of interest")