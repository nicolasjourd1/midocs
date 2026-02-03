#import "math.typ": config-state

#let bigO(e) = $cal(O)(#e)$
#let bigTheta(e) = $Theta(#e)$
#let bigOmega(e) = $Omega(#e)$

#let algorithm(title: none, body) = context {
  let config = config-state.get()
  block(
    width: 100%,
    inset: 12pt,
    stroke: 1pt + config.theme.primary,
    fill: config.theme.secondary.lighten(80%),
  )[
    #if title != none [
      #text(weight: "bold", size: 1em, fill: config.theme.primary)[
        #config.strings.algorithm: #title
      ]
      #v(0cm)
    ]
    #set text(font: "FiraCode Nerd Font Mono", size: 0.9em)
    #body
  ]
}
