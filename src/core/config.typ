// Default configurations
#let get-default-config(type) = {
  let base = (
    title: "Document Tittle",
    author: none,
    date: none,
    abstract: none,

    // Page settings
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),

    // Typography
    font-size: 11pt,
    line-spacing: 1.2,

    // Numbering
    number-sections: true,
    number-equations: true,

    // Headers/footers
    show-header: true,
    show-footer: true,
  )

  if type == "article" {
    (
      ..base,
      columns: 1,
      show-abstract: true,
    )
  } else if type == "report" {
    (
      ..base,
      title-page: true,
      columns: 1,
      show-toc: true,
    )
  } else if type == "book" {
    (
      ..base,
      margin: (inside: 3cm, outside: 2cm, y: 2.5cm),
      columns: 1,
      two-sided: true,
      show-toc: true,
      chapter-break: true,
    )
  } else {
    base
  }
}

// Merger user config with defaults (user config overrides defaults)
#let merge-config(base, user) = {
  let result = base
  for (key, value) in user {
    result.insert(key, value)
  }
  result
}
