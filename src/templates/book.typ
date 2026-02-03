#let book-template(config, body) = {
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

  // Text properies
  set text(
    font: config.typography.body-font,
    size: config.font-size,
    fill: config.theme.text,
  )

  set par(
    leading: config.line-spacing * 0.65em,
    justify: true,
    first-line-indent: 1.2em,
  )

  // Headings
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(
      font: config.typography.heading-font,
      fill: config.theme.primary,
      size: 1.8em,
      weight: config.typography.heading-weight,
    )
    v(2cm)
    block[
      #text(size: 0.6em, fill: config.theme.text.lighten(40%))[
        #if config.number-sections {
          config.strings.chapter
          " "
          counter(heading).display()
        }
      ]
      \
      #it.body
    ]
    v(2cm)
  }

  show heading.where(level: 2): it => {
    set text(
      font: config.typography.heading-font,
      fill: config.theme.heading,
      size: 1.4em,
      weight: config.typography.heading-weight,
    )
    block(above: 1.8em, below: 1em, it)
  }

  show heading.where(level: 3): it => {
    set text(size: 1.15em)
    block(above: 1.4em, below: 0.8em, it)
  }

  // Title page
  page(
    margin: 2cm,
    header: none,
    footer: none,
  )[
    #align(center + horizon)[
      #v(3cm)
      #text(size: 2.5em, weight: "bold", fill: config.theme.primary)[
        #config.title
      ]

      #v(2cm)

      #if config.author != none [
        #text(size: 1.8em)[#config.author]
      ]

      #v(1fr)

      #text(size: 1.2em)[
        #if config.date != none { config.date.display("[year]") }
      ]
      #v(2cm)
    ]
  ]

  // TOC
  if config.show-toc {
    page[
      #v(2cm)
      #text(size: 2em, weight: "bold", fill: config.theme.primary)[
        #config.strings.toc
      ]
      #v(1cm)
      #outline(title: none, indent: 2em, depth: 2)
    ]
  }

  // Headers
  set page(header: context {
    let page-num = counter(page).get().first()
    if page-num > 2 [
      #set text(size: 9pt, fill: config.theme.text.lighten(40%))

      // Current chapter
      #let chapters = query(selector(heading.where(level: 1)).before(here()))
      #let current-chapter = if chapters.len() > 0 {
        chapters.last().body
      } else {
        []
      }

      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        if calc.rem(page-num, 2) == 0 {
          counter(page).display("1")
        } else {
          smallcaps(current-chapter)
        },
        if calc.rem(page-num, 2) == 0 {
          smallcaps(current-chapter)
        } else {
          counter(page).display("1")
        },
      )
      #v(-0.7em)
      #line(length: 100%, stroke: 0.5pt + config.theme.text.lighten(70%))
    ]
  })

  // Section numbering
  set heading(numbering: if config.number-sections { "1.1" } else { none })

  // Equation numbering
  set math.equation(numbering: if config.number-equations { "(1)" } else {
    none
  })

  // Body
  body
}
