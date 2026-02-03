#let article-template(config, body) = {
  // Document properties
  set document(
    title: config.title,
    author: if config.author != none { config.author } else { () },
    date: config.date,
  )

  // Page properties
  set page(
    paper: config.paper,
    margin: config.margin,
  )

  // Header (using context)
  if config.show-header {
    set page(header: context {
      if counter(page).get().first() > 1 [
        #set text(size: 9pt, fill: config.theme.text.lighten(30%))
        #smallcaps(config.title)
        #h(1fr)
        #counter(page).display("1")
      ]
    })
  }

  // Text properties
  set text(
    font: config.typography.body-font,
    size: config.font-size,
    fill: config.theme.text,
  )

  set par(
    leading: config.line-spacing * 0.65em,
    justify: true,
  )

  // Heading
  show heading: it => {
    set text(
      font: config.typography.heading-font,
      fill: config.theme.heading,
      weight: config.typography.heading-weight,
    )
    if it.level == 1 {
      set text(size: 1.5em)
      block(above: 1.5em, below: 1em, it)
    } else if it.level == 2 {
      set text(size: 1.25em)
      block(above: 1.2em, below: 0.8em, it)
    } else {
      set text(size: 1.1em)
      block(above: 1em, below: 0.6em, it)
    }
  }

  // Title
  align(center)[
    #block(above: 2em, below: 1em)[
      #text(size: 2em, weight: "bold", fill: config.theme.primary)[
        #config.title
      ]
    ]

    #if config.author != none [
      #text(size: 1.2em)[#config.author]
    ]

    #v(0.5em)
    #text(size: 0.9em)[
      #if config.date != none { config.date.display("[day] [month repr: long] [year]") }
    ]
  ]

  // Abstract
  if config.abstract != none and config.show-abstract [
    #v(2em)
    #align(center)[
      #block(width: 85%)[
        #set par(justify: true)
        #text(weight: "bold", size: 1.1em)[
          #config.strings.abstract
        ]
        #v(0.5em)
        #config.abstract
      ]
    ]
    #v(2em)
  ]

  // Section numbering
  set heading(numbering: if config.number-sections { "1.1" } else { none })

  // Equation numbering
  set math.equation(numbering: if config.number-equations { "(1)" } else {
    none
  })

  // Body
  body
}
