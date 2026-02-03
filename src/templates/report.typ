#let report-template(config, body) = {
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
      pagebreak(weak: true)
      set text(size: 1.6em)
      block(above: 2em, below: 1.2em)[
        #text(fill: config.theme.primary)[
          #if config.number-sections {
            counter(heading).display()
            h(0.5em)
          }
          #it.body
        ]
        #v(-0.5em)
        #line(length: 100%, stroke: 1pt + config.theme.primary)
      ]
    } else if it.level == 2 {
      set text(size: 1.3em)
      block(above: 1.5em, below: 0.9em, it)
    } else {
      set text(size: 1.1em)
      block(above: 1.2em, below: 0.7em, it)
    }
  }

  // Title page
  if config.title-page {
    page(
      margin: 2cm,
      header: none,
      footer: none,
    )[
      #align(center + horizon)[
        #block(width: 80%)[
          #v(2cm)

          // Title
          #text(size: 2.5em, weight: "bold", fill: config.theme.primary)[
            #config.title
          ]

          #v(2cm)

          // Author
          #if config.author != none [
            #text(size: 1.5em)[#config.author]
          ]

          #v(4cm)

          // Date
          #text(size: 1.2em)[
            #if config.date != none { config.date.display("[day] [month: repr:long] [year]") }
          ]
        ]
      ]
    ]
  }

  // TOC
  if config.show-toc {
    page[
      #outline(
        title: config.strings.toc,
        indent: auto,
      )
    ]
  }

  // Header and footer
  if config.show-header {
    set page(header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 [
        #set text(size: 9pt, fill: config.theme.text.lighten(30%))
        #if calc.odd(page-num) [
          #grid(
            columns: (1fr, 1fr),
            align: (left, right),
            smallcaps(config.title), counter(page).display("1"),
          )
        ] else [
          #grid(
            columns: (1fr, 1fr),
            align: (left, right),
            counter(page).display("1"), smallcaps(config.title),
          )
        ]
        #v(-0.5em)
        #line(length: 100%, stroke: 0.5pt + config.theme.text.lighten(60%))
      ]
    })
  }

  // Section numbering
  set heading(numbering: if config.number-sections { "1.1" } else { none })

  // Equation numbering
  set math.equation(numbering: if config.number-equations { "(1)" } else {
    none
  })

  // Body
  body
}
